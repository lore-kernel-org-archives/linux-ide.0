From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] ARM: shmobile: sata_rcar updates
Date: Wed, 29 Oct 2014 14:58:48 +0100
Message-ID: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

	Hi Tejun, Simon, Magnus,

This patch series improves DT bindings documentation and usage for the
sata_rcar driver.

The first patch was sent before by Valentine Barshak a while ago, but never
updated according to the review comments.

Thanks for applying!

Geert Uytterhoeven (2):
  sata_rcar: Document deprecated "renesas,rcar-sata"
  ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property

Valentine Barshak (1):
  sata_rcar: Add clocks to sata_rcar bindings

 Documentation/devicetree/bindings/ata/sata_rcar.txt | 11 +++++++----
 arch/arm/boot/dts/r8a7779.dtsi                      |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
