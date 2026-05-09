import SwiftUI

enum PursueTheme {
    static let void = Color(red: 0.012, green: 0.016, blue: 0.02)
    static let midnight = Color(red: 0.025, green: 0.04, blue: 0.05)
    static let panel = Color(red: 0.045, green: 0.06, blue: 0.065)
    static let panelHigh = Color(red: 0.08, green: 0.095, blue: 0.1)
    static let lime = Color(red: 0.55, green: 1.0, blue: 0.54)
    static let cyan = Color(red: 0.62, green: 0.9, blue: 1.0)
    static let amber = Color(red: 1.0, green: 0.72, blue: 0.38)
    static let signalRed = Color(red: 1.0, green: 0.34, blue: 0.28)
    static let ink = Color(red: 0.92, green: 0.96, blue: 0.94)
    static let muted = Color(red: 0.66, green: 0.72, blue: 0.72)
}

struct PursueBackground: View {
    var body: some View {
        ZStack {
            Image("CinematicHero")
                .resizable()
                .scaledToFill()
                .saturation(0.82)
                .contrast(1.08)
                .overlay(Color.black.opacity(0.42))
                .overlay(
                    LinearGradient(
                        colors: [
                            PursueTheme.void.opacity(0.18),
                            PursueTheme.void.opacity(0.72),
                            PursueTheme.void.opacity(0.96)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            RadialGradient(colors: [PursueTheme.cyan.opacity(0.16), .clear], center: .top, startRadius: 20, endRadius: 520)
        }
        .ignoresSafeArea()
    }
}

struct CinematicStill: View {
    var cornerRadius: CGFloat = 8

    var body: some View {
        Image("CinematicHero")
            .resizable()
            .scaledToFill()
            .overlay(
                LinearGradient(
                    colors: [.clear, PursueTheme.void.opacity(0.64)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct RadarSignalView: View {
    var size: CGFloat = 190
    @State private var spin = false

    var body: some View {
        ZStack {
            ForEach([1.0, 0.72, 0.44], id: \.self) { scale in
                Circle()
                    .stroke(PursueTheme.lime.opacity(0.18), lineWidth: 1)
                    .frame(width: size * scale, height: size * scale)
            }

            Rectangle()
                .fill(PursueTheme.lime.opacity(0.16))
                .frame(width: 1, height: size)
            Rectangle()
                .fill(PursueTheme.lime.opacity(0.16))
                .frame(width: size, height: 1)

            Circle()
                .trim(from: 0, to: 0.24)
                .stroke(
                    AngularGradient(
                        colors: [.clear, PursueTheme.lime.opacity(0.9), .clear],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: size * 0.48, lineCap: .butt)
                )
                .frame(width: size * 0.52, height: size * 0.52)
                .rotationEffect(.degrees(spin ? 360 : 0))
                .blendMode(.screen)

            Circle()
                .fill(PursueTheme.lime)
                .frame(width: 8, height: 8)
                .shadow(color: PursueTheme.lime, radius: 10)

            SignalDot(x: 0.28, y: -0.22, color: PursueTheme.cyan, size: size)
            SignalDot(x: -0.2, y: 0.24, color: PursueTheme.amber, size: size)
            SignalDot(x: 0.08, y: 0.02, color: PursueTheme.signalRed, size: size)
        }
        .frame(width: size, height: size)
        .onAppear {
            withAnimation(.linear(duration: 4.8).repeatForever(autoreverses: false)) {
                spin = true
            }
        }
    }
}

private struct SignalDot: View {
    let x: CGFloat
    let y: CGFloat
    let color: Color
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 7, height: 7)
            .shadow(color: color, radius: 8)
            .offset(x: x * size, y: y * size)
    }
}

struct MetricPill: View {
    let value: String
    let label: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(.system(.title3, design: .rounded).weight(.black))
                .foregroundStyle(PursueTheme.ink)
            Text(label)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(PursueTheme.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

extension UFOCategory {
    var accentColor: Color {
        switch self {
        case .fbiInfrared: return PursueTheme.signalRed
        case .fbiSketch: return PursueTheme.amber
        case .nasa: return PursueTheme.cyan
        case .military: return PursueTheme.lime
        }
    }

    var shortName: String {
        switch self {
        case .fbiInfrared: return "IR"
        case .fbiSketch: return "SKETCH"
        case .nasa: return "NASA"
        case .military: return "MIL"
        }
    }
}
