import Foundation

struct ReleaseData {
    static let release01 = UFORelease(
        id: "release01",
        title: "Release 01",
        titleJa: "第1回公開",
        date: "2026-05-08",
        items: [
            UFOItem(
                id: "fbi-1", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-1.jpg",
                description: "Infrared still image (black hot) of unidentified object over western United States, December 2025",
                descriptionJa: "米国西部上空の未確認物体（赤外線・黒色高温表示）2025年12月",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-12", source: "FBI",
                latitude: 38.0, longitude: -118.0, category: .fbiInfrared),
            UFOItem(
                id: "fbi-a5", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-A5.jpg",
                description: "Infrared still image (black hot) of unidentified object over western United States, December 2025",
                descriptionJa: "米国西部上空の未確認物体（赤外線・黒色高温表示）2025年12月 別角度",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-12", source: "FBI",
                latitude: 38.5, longitude: -117.5, category: .fbiInfrared),
            UFOItem(
                id: "fbi-b2", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-B2.jpg",
                description: "Infrared still image (black hot) of unidentified object over western United States, September 2025",
                descriptionJa: "米国西部上空の未確認物体（赤外線）2025年9月",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-09", source: "FBI",
                latitude: 37.5, longitude: -119.0, category: .fbiInfrared),
            UFOItem(
                id: "fbi-b7", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-B7-.jpg",
                description: "Infrared still image (black hot) of unidentified object below helicopter over western US, September 2025",
                descriptionJa: "ヘリコプター下方の未確認物体（赤外線）2025年9月",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-09", source: "FBI",
                latitude: 37.0, longitude: -118.5, category: .fbiInfrared),
            UFOItem(
                id: "fbi-b18", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-B18.jpg",
                description: "Infrared still image (black hot) of unidentified object(s) over western United States, September 2025",
                descriptionJa: "米国西部上空の未確認物体群（赤外線）2025年9月",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-09", source: "FBI",
                latitude: 36.5, longitude: -117.0, category: .fbiInfrared),
            UFOItem(
                id: "fbi-b20", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/FBI-Photo-B20.jpg",
                description: "Infrared still image (black hot) of unidentified object(s) over western United States, September 2025",
                descriptionJa: "米国西部上空の未確認物体群（赤外線）2025年9月 別フレーム",
                location: "Western United States", locationJa: "米国西部",
                date: "2025-09", source: "FBI",
                latitude: 36.0, longitude: -117.5, category: .fbiInfrared),
            UFOItem(
                id: "sketch-2023", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/2024-04-30-Composite-Sketch.jpg",
                description: "Recreation of anomalous sighting in southeastern US, September 2023. Ellipsoid bronze metallic object, 130-195 feet, disappeared instantaneously",
                descriptionJa: "米国南東部での目撃再現スケッチ。楕円形の青銅色金属物体、全長40〜60m、瞬時に消失。2023年9月",
                location: "Southeastern United States", locationJa: "米国南東部",
                date: "2023-09", source: "FBI",
                latitude: 33.0, longitude: -84.0, category: .fbiSketch),
            UFOItem(
                id: "apollo17", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/NASA-UAP-VM6-Apollo-17-1972.jpg",
                description: "Apollo 17 lunar photo with three lights in triangular formation visible above terrain, December 1972",
                descriptionJa: "アポロ17号月面写真。月面上空に三角形配置の3つの光点。1972年12月",
                location: "Moon", locationJa: "月面",
                date: "1972-12", source: "NASA",
                latitude: nil, longitude: nil, category: .nasa),
            UFOItem(
                id: "me-2022", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR19-Unresolved-UAP-Report-Middle-East-May-2022.jpg",
                description: "Still from video of UAP flying across military operator's screen, Middle East, May 2022",
                descriptionJa: "軍事オペレーター画面上を横切るUAP映像スチル。中東、2022年5月",
                location: "Middle East", locationJa: "中東",
                date: "2022-05", source: "DOW",
                latitude: 28.0, longitude: 50.0, category: .military),
            UFOItem(
                id: "uae-2023", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR26-Unresolved-UAP-Report-United-Arab-Emirates-October-2023.jpg",
                description: "Still from video captured near UAE featuring reported UAP, October 2023",
                descriptionJa: "UAE付近で撮影されたUAP映像スチル。2023年10月",
                location: "United Arab Emirates", locationJa: "アラブ首長国連邦",
                date: "2023-10", source: "DOW",
                latitude: 24.5, longitude: 54.5, category: .military),
            UFOItem(
                id: "greece-scope", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR34-Unresolved-UAP-Report-Greece-October-2023.jpg",
                description: "Scope view with aqua-colored lines showing black squares and rectangles, Greece, October 2023",
                descriptionJa: "スコープ映像。水色の照準線上に黒い物体が散在。ギリシャ、2023年10月",
                location: "Greece", locationJa: "ギリシャ",
                date: "2023-10", source: "DOW",
                latitude: 38.0, longitude: 23.7, category: .military),
            UFOItem(
                id: "greece-ocean", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR35-Unresolved-UAP-Report-Greece-October-2023.jpg",
                description: "UAP flying straight above ocean towards land near Greece, October 2023",
                descriptionJa: "海上から陸地方向へ直線飛行するUAP。ギリシャ、2023年10月",
                location: "Greece", locationJa: "ギリシャ",
                date: "2023-10", source: "DOW",
                latitude: 37.5, longitude: 24.0, category: .military),
            UFOItem(
                id: "me-2013", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR38-Unresolved-UAP-Report-Middle-East-2013.jpg",
                description: "Eight-pointed area of contrast captured via infrared sensor, Middle East, 2013",
                descriptionJa: "赤外線センサーが捉えた八芒星型のコントラスト領域。中東、2013年",
                location: "Middle East", locationJa: "中東",
                date: "2013", source: "DOW/CENTCOM",
                latitude: 30.0, longitude: 47.0, category: .military),
            UFOItem(
                id: "africa-2025", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR43-Unresolved-UAP-Report-Africa-2025.jpg",
                description: "UAP reported by military operator in African airspace, 2025",
                descriptionJa: "アフリカ空域で米軍オペレーターが報告したUAP。2025年",
                location: "Africa", locationJa: "アフリカ",
                date: "2025", source: "DOW",
                latitude: 10.0, longitude: 25.0, category: .military),
            UFOItem(
                id: "us-south-2020", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR45-Unresolved-UAP-Report-Middle-East-2020.jpg",
                description: "UAP reported by U.S. Air Force in southern United States, 2020",
                descriptionJa: "米空軍が米国南部で報告したUAP。2020年",
                location: "Southern United States", locationJa: "米国南部",
                date: "2020", source: "USAF",
                latitude: 32.0, longitude: -95.0, category: .military),
            UFOItem(
                id: "japan-2024", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR46-Unresolved-UAP-Report-INDOPACOM-2024.jpg",
                description: "Football-shaped body reported by U.S. Indo-Pacific Command near Japan, 2024",
                descriptionJa: "日本周辺でインド太平洋軍が報告した「フットボール型」物体。2024年",
                location: "Near Japan", locationJa: "日本周辺",
                date: "2024", source: "INDOPACOM",
                latitude: 35.0, longitude: 140.0, category: .military),
            UFOItem(
                id: "army-2026", imageURL: "https://www.war.gov/portals/1/Interactive/2026/UFO/Slideshow/DOW-UAP-PR49-Unresolved-UAP-Report-Department-of-the-Army-2026.jpg",
                description: "UAP reported by U.S. Army in North America, 2026",
                descriptionJa: "米陸軍が北米で報告したUAP。2026年（最新）",
                location: "North America", locationJa: "北米",
                date: "2026", source: "US Army",
                latitude: 40.0, longitude: -100.0, category: .military)
        ]
    )

    static var allReleases: [UFORelease] {
        [release01]
    }

    static var allItems: [UFOItem] {
        allReleases.flatMap { $0.items }
    }
}
