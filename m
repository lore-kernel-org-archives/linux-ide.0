From: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Date: Tue, 10 Jul 2018 15:05:17 +0200
Message-ID: <20180710130517.GA27236@Red>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
 <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux@armlinux.org.uk, mark.rutland@arm.com, maxime.ripard@free-electrons.com, robh+dt@kernel.org, tj@kernel.org, wens@csie.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-ide@vger.kernel.org

On Mon, Jul 09, 2018 at 11:44:20PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2018年7月9日 GMT+08:00 下午11:20:54, Corentin Labbe <clabbe@baylibre.com> 写到:
> >Hello
> >
> >With Moeicenowy's agreement, I have take leadership ot this patchset.
> >
> >There are no really changes appart renaming struct quirck to variant.
> >
> >Since the last serie is really old, I will answer comment here.
> >The two regulator (1.2 and 2.5V) are not for the PHY since:
> >- nothing in the schematic said that they are for the PHY, they seems
> >  only for controller
> >- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
> >  cannot be used for target)
> 
> Target is not equal to PHY. Target means the supply
> of the disk, which can be usually 5v (for 2.5" HDD) or
> 12v (3.5" HDD).
> 
> By reading Wikipedia articles  about SATA and LVDS, I assume
> 2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
> is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
> used to efficiently deliver ~1.2V LVDS.)
> 
> P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
> Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
> is connected to common VDD-SYS (called INTVDD on the
> schematics) and VDD25-SATA is connected to an always-on
> fixed LDO, maybe due to the lack of power outputs on AXP209.
> 

So we still need to add a regulator on the controller and add an optionnal "phy" regulator for AHCI port.
