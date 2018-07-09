From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Date: Mon, 09 Jul 2018 23:44:20 +0800
Message-ID: <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBF4GR3NAKGQET3Y3MCQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org



=E4=BA=8E 2018=E5=B9=B47=E6=9C=889=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=8811:=
20:54, Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> =E5=86=99=E5=88=B0:
>Hello
>
>With Moeicenowy's agreement, I have take leadership ot this patchset.
>
>There are no really changes appart renaming struct quirck to variant.
>
>Since the last serie is really old, I will answer comment here.
>The two regulator (1.2 and 2.5V) are not for the PHY since:
>- nothing in the schematic said that they are for the PHY, they seems
>  only for controller
>- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>  cannot be used for target)

Target is not equal to PHY. Target means the supply
of the disk, which can be usually 5v (for 2.5" HDD) or
12v (3.5" HDD).

By reading Wikipedia articles  about SATA and LVDS, I assume
2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
used to efficiently deliver ~1.2V LVDS.)

P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
is connected to common VDD-SYS (called INTVDD on the
schematics) and VDD25-SATA is connected to an always-on
fixed LDO, maybe due to the lack of power outputs on AXP209.

>
>Furthermore, the AHCI binding support only one regulator per PHY, so
>using the "target" regulator is out of question for registring this two
>non-phy regulator.
>
>I hope this answer all comments done on last version.
>
>Regards
>
>Corentin Labbe (3):
>  ata: ahci_sunxi: add support for R40 SATA controller
>  ARM: dts: sun8i: r40: add sata node
>  ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
>
>Icenowy Zheng (1):
>  dt-bindings: add binding for Allwinner R40 SATA AHCI controller
>
> .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
> .../bindings/ata/allwinner,sun4i-a10-ahci.txt      |  40 +++++++
> arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  18 +++
> arch/arm/boot/dts/sun8i-r40.dtsi                   |   9 ++
>drivers/ata/ahci_sunxi.c                           | 124
>++++++++++++++++++++-
> 5 files changed, 188 insertions(+), 4 deletions(-)
>create mode 100644
>Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.txt

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
