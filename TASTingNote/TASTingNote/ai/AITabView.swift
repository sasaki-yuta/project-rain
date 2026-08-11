//
//  AITabView.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/10.
//
import SwiftUI
import SwiftData

struct AITabView: View {

    @Environment(\.modelContext) private var context

    // ======================
    // Wine Query
    // ======================

    @Query(sort: \Wine.tastingDate, order: .reverse)
    private var whiteWines: [Wine]

    @Query(sort: \redWine.tastingDate, order: .reverse)
    private var redWines: [redWine]

    @Query(sort: \spWine.tastingDate, order: .reverse)
    private var sparklingWines: [spWine]

    @Query(sort: \roseWine.tastingDate, order: .reverse)
    private var roseWines: [roseWine]

    @Query(sort: \orangeWine.tastingDate, order: .reverse)
    private var orangeWines: [orangeWine]

    @Query(sort: \fortifiedWine.tastingDate, order: .reverse)
    private var fortifiedWines: [fortifiedWine]

    @Query(sort: \dessertWine.tastingDate, order: .reverse)
    private var dessertWines: [dessertWine]


    // ======================
    // ワイン種類
    // ======================

    enum WineKind: String, CaseIterable, Identifiable {

        case white
        case red
        case sparkling
        case rose
        case orange
        case fortified
        case dessert

        var id: String {
            rawValue
        }

        var title: String {

            switch self {
            case .white:
                return "白"

            case .red:
                return "赤"

            case .sparkling:
                return "泡"

            case .rose:
                return "ロゼ"

            case .orange:
                return "オレンジ"

            case .fortified:
                return "酒精強化"

            case .dessert:
                return "デザート"
            }
        }

        var fullName: String {

            switch self {
            case .white:
                return "白ワイン"

            case .red:
                return "赤ワイン"

            case .sparkling:
                return "スパークリングワイン"

            case .rose:
                return "ロゼワイン"

            case .orange:
                return "オレンジワイン"

            case .fortified:
                return "酒精強化ワイン"

            case .dessert:
                return "デザートワイン"
            }
        }

        var color: Color {

            switch self {
            case .white:
                return .green

            case .red:
                return .red

            case .sparkling:
                return .orange

            case .rose:
                return .pink

            case .orange:
                return Color.orange.opacity(0.75)

            case .fortified:
                return .purple

            case .dessert:
                return .yellow
            }
        }
    }


    // ======================
    // チャートモデル
    // ======================

    struct ChartPoint: Identifiable {

        let id: String
        let x: Double
        let y: Double
        let kind: WineKind
        let imageData: Data?
        let wineName: String
    }


    // ======================
    // 状態
    // ======================

    @State private var selectedKind: WineKind = .white

    @State private var selectedPoints: [ChartPoint] = []


    // ======================
    // 全ワインのChartPoint
    // ======================

    private var chartPoints: [ChartPoint] {

        let whites = whiteWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "white-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .white,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let reds = redWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "red-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .red,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let sparkling = sparklingWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "sparkling-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .sparkling,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let roses = roseWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "rose-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .rose,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let oranges = orangeWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "orange-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .orange,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let fortifieds = fortifiedWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "fortified-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .fortified,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        let desserts = dessertWines.compactMap { wine -> ChartPoint? in

            guard let x = wine.chartX,
                  let y = wine.chartY else {
                return nil
            }

            return ChartPoint(
                id: "dessert-\(wine.persistentModelID)",
                x: x,
                y: y,
                kind: .dessert,
                imageData: wine.imageData,
                wineName: wine.name
            )
        }


        return whites
            + reds
            + sparkling
            + roses
            + oranges
            + fortifieds
            + desserts
    }


    // ======================
    // 選択中のワインだけ
    // ======================

    private var filteredChartPoints: [ChartPoint] {

        chartPoints.filter {
            $0.kind == selectedKind
        }
    }


    // ======================
    // Body
    // ======================

    var body: some View {

        NavigationStack {

            VStack(spacing: 0) {

                // ======================
                // ワイン種類選択
                // ======================

                ScrollView(.horizontal, showsIndicators: false) {

                    HStack(spacing: 8) {

                        ForEach(WineKind.allCases) { kind in

                            Button {

                                selectedKind = kind

                                // 種類変更時は重なり選択を解除
                                selectedPoints = []

                            } label: {

                                Text(kind.title)
                                    .font(.subheadline)
                                    .fontWeight(
                                        selectedKind == kind
                                        ? .bold
                                        : .regular
                                    )
                                    .foregroundStyle(
                                        selectedKind == kind
                                        ? .white
                                        : kind.color
                                    )
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedKind == kind
                                        ? kind.color
                                        : kind.color.opacity(0.12)
                                    )
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }


                // ======================
                // タイトル
                // ======================

                HStack {

                    Text(selectedKind.fullName)
                        .font(.headline)

                    Spacer()

                    Text("\(filteredChartPoints.count)本")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)


                // ======================
                // チャート
                // ======================

                GeometryReader { screen in

                    ZStack {

                        GeometryReader { geo in

                            AIWineChartPickerView(
                                xValue: .constant(nil),
                                yValue: .constant(nil),
                                isLocked: true
                            )
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )


                            // ======================
                            // タップ判定
                            // ======================

                            Color.clear
                                .contentShape(Rectangle())
                                .onTapGesture { location in

                                    let tapped =
                                        filteredChartPoints.filter { point in

                                            let px =
                                                geo.size.width
                                                * (point.x + 1) / 2

                                            let py =
                                                geo.size.height
                                                * (1 - (point.y + 1) / 2)

                                            let dx =
                                                px - location.x

                                            let dy =
                                                py - location.y

                                            return sqrt(
                                                dx * dx + dy * dy
                                            ) < 20
                                        }

                                    selectedPoints = tapped
                                }


                            // ======================
                            // ワイン表示
                            // ======================

                            ForEach(filteredChartPoints) { point in

                                VStack(spacing: 2) {

                                    if let data = point.imageData,
                                       let uiImage = UIImage(data: data) {

                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(
                                                width: 28,
                                                height: 28
                                            )
                                            .clipShape(Circle())

                                    } else {

                                        Circle()
                                            .fill(point.kind.color)
                                            .frame(
                                                width: 28,
                                                height: 28
                                            )
                                    }


                                    Text(point.wineName)
                                        .font(.caption2)
                                        .lineLimit(1)
                                }
                                .position(
                                    x:
                                        geo.size.width
                                        * (point.x + 1) / 2,

                                    y:
                                        geo.size.height
                                        * (1 - (point.y + 1) / 2)
                                )
                            }
                        }
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding()


                Spacer()
            }
            .navigationTitle("ワインチャート")


            // ======================
            // 重なり表示
            // ======================

            .sheet(
                isPresented: Binding(
                    get: {
                        !selectedPoints.isEmpty
                    },
                    set: {
                        if !$0 {
                            selectedPoints = []
                        }
                    }
                )
            ) {

                WineOverlapListView(
                    points: selectedPoints
                )
                .environment(
                    \.modelContext,
                    context
                )
            }
        }
    }
}

struct WineDetailRouterView: View {

    let point: AITabView.ChartPoint
    @Environment(\.modelContext) private var context

    var body: some View {

        Group {
            switch point.kind {

            case .white:

                if let wine = fetchWhite(id: point.id) {
                    WhiteWineTastingSheetView(wine: wine)
                }

            case .red:

                if let wine = fetchRed(id: point.id) {
                    RedWineTastingSheetView(wine: wine)
                }

            case .sparkling:

                if let wine = fetchSparkling(id: point.id) {
                    SparklingWineTastingSheetView(wine: wine)
                }
                
            case .rose:

                if let wine = fetchRose(id: point.id) {
                    RoseWineTastingSheetView(wine: wine)
                }
                
            case .orange:

                if let wine = fetchOrange(id: point.id) {
                    OrangeWineTastingSheetView(wine: wine)
                }
                
            case .fortified:

                if let wine = fetchFortified(id: point.id) {
                    FortifiedWineTastingSheetView(wine: wine)
                }
                
            case .dessert:

                if let wine = fetchDessert(id: point.id) {
                    DessertWineTastingSheetView(wine: wine)
                }
            }
        }
    }

    // ======================
    // fetch
    // ======================
    private func fetchWhite(id: String) -> Wine? {
        let wines = (try? context.fetch(FetchDescriptor<Wine>())) ?? []
        return wines.first { "white-\($0.persistentModelID)" == id }
    }

    private func fetchRed(id: String) -> redWine? {
        let wines = (try? context.fetch(FetchDescriptor<redWine>())) ?? []
        return wines.first { "red-\($0.persistentModelID)" == id }
    }
    
    private func fetchSparkling(id: String) -> spWine? {

        let wines = (try? context.fetch(FetchDescriptor<spWine>())) ?? []

        return wines.first {
            "sparkling-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchRose(id: String) -> roseWine? {

        let wines = (try? context.fetch(FetchDescriptor<roseWine>())) ?? []

        return wines.first {
            "rose-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchOrange(id: String) -> orangeWine? {

        let wines = (try? context.fetch(FetchDescriptor<orangeWine>())) ?? []

        return wines.first {
            "orange-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchFortified(id: String) -> fortifiedWine? {

        let wines =
            (try? context.fetch(FetchDescriptor<fortifiedWine>()))
            ?? []

        return wines.first {
            "fortified-\($0.persistentModelID)" == id
        }
    }
    
    private func fetchDessert(id: String) -> dessertWine? {

        let wines =
            (try? context.fetch(FetchDescriptor<dessertWine>()))
            ?? []

        return wines.first {
            "dessert-\($0.persistentModelID)" == id
        }
    }
}

struct WineOverlapListView: View {

    let points: [AITabView.ChartPoint]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {

            List(points) { point in

                NavigationLink {

                    // ★ここで詳細へ遷移
                    WineDetailRouterView(point: point)
                        .environment(\.modelContext, context)

                } label: {

                    HStack {

                        if let data = point.imageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                        }

                        VStack(alignment: .leading) {

                            Text(point.wineName)
                                .font(.headline)

                            Text(point.kind.fullName)
                                .font(.subheadline)
                                .foregroundStyle(point.kind.color)
                            .font(.subheadline)
                            .foregroundStyle(
                                point.kind == .white
                                ? .green
                                : point.kind == .red
                                    ? .red
                                    : point.kind == .sparkling
                                        ? .orange
                                        : point.kind == .rose
                                            ? .pink
                                            : point.kind == .orange
                                                ? Color.orange.opacity(0.75)
                                                : point.kind == .fortified
                                                    ? .purple
                                                    : .yellow
                            )

                            Text("X（辛甘）: \(String(format: "%.2f", point.x))  Y（重軽）: \(String(format: "%.2f", point.y))")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("選択したワイン")
        }
    }
}
