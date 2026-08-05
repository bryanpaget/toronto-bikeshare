# Landing / About tab generation.
#
# Builds the first (splash) tab shown when the dashboard loads: a hero with
# live system stats, why bike share matters, and a Toronto vs Beijing vs
# Shanghai comparison, plus background reading. Facts mirror the README
# narrative and are linked to the public sources listed at the bottom.

info_stat_chip <- function(label, value) {
  paste0('<div class="hero-stat"><div class="hero-stat-label">', label,
         '</div><div class="hero-stat-value">', value, '</div></div>')
}

info_benefit <- function(idx, title, blurb) {
  paste0('<div class="benefit"><div class="benefit-idx">', sprintf("%02d", idx),
         '</div><h4>', title, '</h4><p>', blurb, '</p></div>')
}

info_comparison_row <- function(label, toronto, beijing, shanghai) {
  paste0('<tr><td class="cmp-row">', label, '</td><td>', toronto,
         '</td><td>', beijing, '</td><td>', shanghai, '</td></tr>')
}

info_link_list <- function(items) {
  paste0('<ul class="link-list">',
         paste0('<li>', items, '</li>', collapse = ""),
         '</ul>')
}

generate_info_tab <- function(current_metrics, timestamp) {
  timestamp_str <- format(timestamp, "%Y-%m-%d %H:%M")

  hero_stats <- paste0(
    info_stat_chip("Bikes Available", fmt_num(current_metrics$total_bikes)),
    info_stat_chip("Docks Available", fmt_num(current_metrics$total_docks)),
    info_stat_chip("Utilization", paste0(round(current_metrics$utilization_rate, 1), "%")),
    info_stat_chip("Active Stations",
                   paste0(current_metrics$active_stations, "/", current_metrics$total_stations))
  )

  benefits <- paste0(
    info_benefit(1, "First- and last-mile connections",
      "Bike share bridges the gap between transit stops (TTC, GO, regional rail) and homes, workplaces, and errands, extending the reach of public transit without large capital investment."),
    info_benefit(2, "Less congestion",
      "Short car trips are replaced by bikes. Research on Washington D.C.'s Capital Bikeshare estimated it reduced neighbourhood-level traffic congestion by up to 4% (Hamilton &amp; Wichman, 2018)."),
    info_benefit(3, "Healthier cities",
      "Everyday cycling promotes physical activity. A study of European bike share systems estimated up to 73 deaths per year could be prevented across those cities if all bike share trips replaced car trips (Otero et al., 2018)."),
    info_benefit(4, "Lower emissions",
      "Replacing car trips cuts greenhouse gases and local air pollution, supporting municipal climate and Vision Zero goals."),
    info_benefit(5, "Equitable, affordable mobility",
      "At low cost, bike share serves residents who may not own a bike or car; targeted pricing and station placement can address transportation inequity in lower-income neighbourhoods."),
    info_benefit(6, "Efficient use of public space",
      "A bike lane or docked station moves far more people per hour than equivalent car parking, making better use of valuable street space.")
  )

  cmp_rows <- paste0(
    info_comparison_row("System / operator",
      "Bike Share Toronto &mdash; Toronto Parking Authority",
      "Municipal docked &ldquo;public bicycle&rdquo; + dockless (Meituan, Hello, DiDi)",
      "Dockless (Meituan, Hello, DiDi Qingju) + municipal docked"),
    info_comparison_row("Launched",
      "2011 (as Bixi; rebranded 2014)",
      "2012 docked &middot; 2015&ndash;17 dockless boom",
      "2009&ndash;10 docked &middot; 2016 dockless"),
    info_comparison_row("Model",
      "Docked stations; mechanical + e-bikes",
      "Mixed: docked + dockless",
      "Dockless-first + docked"),
    info_comparison_row("Fleet (approx.)",
      "10,000+ bikes",
      "&asymp;1M registered; 800K cap in central area",
      "&asymp;800K (regulated)"),
    info_comparison_row("Stations (approx.)",
      "1,000+",
      "2,000+ docked kiosks",
      "Dockless (station-free) + docked hubs"),
    info_comparison_row("Peak fleet (2017 boom)",
      "&mdash;",
      "&asymp;2.3M shared bikes",
      "&asymp;1.7M shared bikes"),
    info_comparison_row("Ridership",
      "7.8M trips (2025)",
      "&gt;1B rides (2023) &middot; &asymp;3.1M/day",
      "&asymp;2.8M rides/day (2024)"),
    info_comparison_row("Regulation &amp; ops",
      "TPA-owned; 2030 plan to roughly double the network",
      "Per-operator fleet caps since 2021",
      "Fleet caps; deep bike&ndash;metro integration")
  )

  paste0(
    '<div id="tab-about" class="tab-pane active">',

    '<div class="hero">',
    '<div class="hero-eyebrow">Live station telemetry &middot; updated ', timestamp_str, ' (Toronto time)</div>',
    '<h2 class="hero-title">Bike Share Analytics for Toronto</h2>',
    '<p class="hero-sub">Live station telemetry, historical trends, and demand predictions for Bike Share Toronto.',
    ' Explore why bike share matters to cities &mdash; and how Toronto compares with two of the world&rsquo;s largest systems.</p>',
    '<div class="hero-stats">', hero_stats, '</div>',
    '<button class="btn btn-cta" data-goto-tab="overview">Launch Dashboard</button>',
    '</div>',

    '<h3 class="section-title">Why bike share matters for cities</h3>',
    '<div class="benefit-grid">', benefits, '</div>',

    '<h3 class="section-title">Toronto &middot; Beijing &middot; Shanghai</h3>',
    '<p class="prose">Toronto operates one of North America&rsquo;s fastest-growing public bike share systems.',
    ' Beijing and Shanghai run two of the largest and most tightly regulated bike share markets on Earth &mdash;',
    ' a useful benchmark for where docked and dockless models succeed, and what mature regulation looks like at massive scale.</p>',
    '<div class="panel"><div class="panel-body no-pad"><div class="table-wrap">',
    '<table class="cmp-table"><thead><tr><th></th><th>Toronto</th><th>Beijing</th><th>Shanghai</th></tr></thead>',
    '<tbody>', cmp_rows, '</tbody></table>',
    '</div></div>',
    '<p class="footnote">Approximate figures from public sources. Toronto fleet/ridership figures from Bike Share Toronto and the',
    ' Toronto Parking Authority 2030 Growth Strategy; live snapshot values are shown in the hero above. China figures:',
    ' Wikipedia (List of bicycle-sharing systems), China.org.cn (2023), Micromobility Industries (2026), and the',
    ' Shanghai 2024 Comprehensive Transportation Development Analysis Report.</p>',

    '<h3 class="section-title">About Bike Share Toronto</h3>',
    '<div class="prose">',
    '<p>Bike Share Toronto is the city&rsquo;s public bike share system, owned and operated by the Toronto Parking Authority.',
    ' It launched in May 2011 as Bixi Toronto with about 1,000 bikes and 80 stations, and was rebranded as Bike Share Toronto',
    ' when the Toronto Parking Authority took over operations in 2014. Today it has grown to more than 1,000 stations and',
    ' 10,000+ bikes (including roughly 2,100 electric bikes) across the city.</p>',
    '<p>The system has expanded rapidly alongside the city&rsquo;s cycling network. Annual ridership grew from about',
    ' 2.9 million trips in 2020 to 5.7 million in 2023, 7.0 million in 2024, and a record 7.8 million trips in 2025.</p>',
    '<p>The city&rsquo;s 2030 Growth Strategy (Ride More, Connect More) lays out a roadmap for roughly doubling the network,',
    ' integrating bike share more closely with transit, and expanding into underserved neighbourhoods. Equity programs such as',
    ' the Reduced Fare Pass make the system more affordable, and expansion priorities are informed by research on how to reach',
    ' more residents in lower-income areas.</p>',
    '</div>',

    '<h3 class="section-title">Bike share across Canada and the world</h3>',
    '<div class="prose"><p>Toronto is part of a growing network of public bike share systems. Montreal&rsquo;s BIXI (2009) was',
    ' the first modern public bike share in North America, and other major Canadian systems include Vancouver&rsquo;s',
    ' Mobi by Shaw Go (2016) and Hamilton&rsquo;s bike share (2015). Internationally, well-known systems include Paris&rsquo; V&eacute;lib&rsquo;,',
    ' London&rsquo;s Santander Cycles, New York&rsquo;s Citi Bike, and Washington D.C.&rsquo;s Capital Bikeshare. Hundreds of cities worldwide',
    ' now operate docked or dockless bike share programs as part of their urban mobility toolkit.</p></div>',

    '<h3 class="section-title">Research &amp; further reading</h3>',
    info_link_list(c(
      '<strong>Health impacts of bike share</strong> &mdash; Otero, I., Nieuwenhuijsen, M.J. &amp; Rojas-Rueda, D. (2018).',
      ' <em>Health impacts of bike sharing systems in Europe</em>. Environment International, 115, 387-394.',
      ' <a href="https://doi.org/10.1016/j.envint.2018.04.014" target="_blank" rel="noopener">doi:10.1016/j.envint.2018.04.014</a>',
      '<strong>Congestion reduction</strong> &mdash; Hamilton, T.L. &amp; Wichman, C.J. (2018).',
      ' <em>Bicycle infrastructure and traffic congestion: Evidence from DC&rsquo;s Capital Bikeshare</em>. JEEM, 87, 72-93.',
      ' <a href="https://doi.org/10.1016/j.jeem.2017.03.007" target="_blank" rel="noopener">doi:10.1016/j.jeem.2017.03.007</a>',
      '<strong>Review of the bike share literature</strong> &mdash; Fishman, E., Washington, S. &amp; Haworth, N. (2013).',
      ' <em>Bike Share: A Synthesis of the Literature</em>. Transport Reviews, 33(2), 148-165.',
      ' <a href="https://doi.org/10.1080/01441647.2013.775612" target="_blank" rel="noopener">doi:10.1080/01441647.2013.775612</a>',
      '<strong>Equity in Toronto&rsquo;s bike share</strong> &mdash; Mekonnen, S. (2022).',
      ' <em>A Plan for an Equitable Expansion of Bike Share Toronto</em> (Toronto Metropolitan University).',
      ' <a href="https://doi.org/10.32920/17329601" target="_blank" rel="noopener">doi:10.32920/17329601</a>'
    )),

    '<h3 class="section-title">Cycling &amp; urban organizations</h3>',
    info_link_list(c(
      '<strong>V&eacute;lo Canada Bikes</strong> &mdash; Canada&rsquo;s national cycling advocacy organization.',
      ' <a href="https://velocanadabikes.org/" target="_blank" rel="noopener">velocanadabikes.org</a>',
      '<strong>Cycle Toronto</strong> &mdash; Toronto&rsquo;s member-supported cycling advocacy charity.',
      ' <a href="https://www.cycleto.ca/" target="_blank" rel="noopener">cycleto.ca</a>',
      '<strong>Share the Road Cycling Coalition</strong> &mdash; Ontario-wide cycling infrastructure and policy.',
      ' <a href="https://sharetheroad.ca/" target="_blank" rel="noopener">sharetheroad.ca</a>',
      '<strong>Transportation Association of Canada</strong> &mdash; sustainable transportation and active mobility guides.',
      ' <a href="https://www.tac-atc.ca/en" target="_blank" rel="noopener">tac-atc.ca</a>',
      '<strong>City of Toronto &mdash; Cycling</strong> &mdash; cycling network, maps, and programs.',
      ' <a href="https://www.toronto.ca/services-payments/streets-parking-transportation/cycling-in-toronto/" target="_blank" rel="noopener">toronto.ca</a>',
      '<strong>Toronto Metropolitan University &mdash; City Building</strong> &mdash; urban mobility and planning research.',
      ' <a href="https://www.torontomu.ca/city-building/" target="_blank" rel="noopener">torontomu.ca</a>'
    )),

    '</div>'
  )
}
