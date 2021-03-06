//
//  AppleTracksTests.swift
//  AppleTracksTests
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import XCTest
@testable import AppleTracks

class AppleTracksTests: XCTestCase {

    var router: TestTrackRouter!
    var service: APIManagerProtocol!
    var view: TracksViewProtocol!
    var detailView: TracksDetailViewProtocol!
    var music: ATResponseProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        router = TestTrackRouter()
        service = APIManager()
        view = TracksViewController()
        detailView = TracksDetailViewController()
        mockData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        router = nil
        service = nil
        view = nil
        detailView = nil
        music = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    ///Set any baseline time you want to test for performance
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let payload = getPayload()
            service.getAlbumsInfo(payload: payload) { result in
                
            }
        }
    }
  
    /**
     Test case to check if the Module gas been added and the view has been configured to show
     */
    func testThatItShowsSongsViewScreen() {
        router.assembleModule(view: view)
        XCTAssertTrue(router.showSongsViewCalled)
        XCTAssertNil(router.presenter?.view, "View can not be nil")
    }
    
    /**
     Test case to check if the detail view has been configured to show
     */
    func testThatItShowsDetailViewScreen() {
        router.showDetailView(detailView: detailView, album: music!)
        XCTAssertTrue(router.showDetailViewCalled)
        XCTAssertNil(router.presenter?.view, "View can not be nil")
    }
    
    /**
     Test case to check if the url is a valid url or not
     Supply some invalid url string to make it fail
     */
    func testIfCanOpenURL() {
        let validUrl = verifyUrl(urlString: music.url)
        if validUrl {
            XCTAssertTrue(validUrl)
        } else {
            XCTFail("Received nil or invalid URL")
        }
    }
    
    /**
     Test case to check  for API call and data
     */
    func testAlbumsAPICalls()  {
        let payload = getPayload()
        let expect = expectation(description: "API response completion")
        service.getAlbumsInfo(payload: payload) { result in
            expect.fulfill()
            switch result {
            case .success(let data):
                XCTAssertTrue( data.albums!.count > 0, "Albums should not be empty" );
            case .failure(_):
                XCTFail()
            }
        }
        waitForExpectations(timeout: 7, handler: nil)
    }

}

extension AppleTracksTests: PayLoadFormat {
    class TestTrackRouter: TracksRouterProtocol {
        
        var presenter: TracksPresenterProtocol?
        var showSongsViewCalled = false
        var showDetailViewCalled = false
        
        ///Check if assembling module happens
        func assembleModule(view: TracksViewProtocol) {
            self.showSongsViewCalled = true
        }
        /// Check if detail view function being called
        func showDetailView(detailView: TracksDetailViewProtocol, album: ATResponseProtocol) {
            self.showDetailViewCalled = true
        }
    }
    
    //Mock the ATMusic struct here
    struct TestATMusic: ATResponseProtocol {
        var track: String?
        var name: String?
        var image: String?
        var price: Double
        var date: Date
        var duration: Int
        var url: String?
    }
    
    /**
     Test case data for Album
     */
    func mockData()  {
        let date = DateFormatter.dateString.date(from: "2011-07-05T12:00:00Z")
        music = TestATMusic(track: "Jazz Love Song", name: "Love Me", image: "https://is1-ssl.mzstatic.com/image/thumb/Music125/v4/47/c4/a2/47c4a2fa-4001-ea50-d109-f81d32778ec1/source/100x100bb.jpg", price: 2.3, date: date ?? Date(), duration: 5, url: "https://music.apple.com/us/album/somebody-that-i-used-to-know-feat-kimbra/1467951962?i=1467952309&uo=4")
    }
    /**
     Function to check if url string is valid url or not
     */
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    /**
     Function to get the Payload for Get method
     */
    func getPayload() -> ATHTTPPayloadProtocol {
        var apiModule = ATAPIModule()
        apiModule.payloadType = ATHTTPPayloadType.requestMethodGET
        return formatGetPayload(url: .albumsUrl, module: apiModule)
    }
}
