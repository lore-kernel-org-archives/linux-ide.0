From: Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2 0/4] sun8i: r40: add AHCI
Date: Tue, 10 Jul 2018 21:15:05 +0800
Message-ID: <A588EEB5-5305-4EFC-8DDD-369F0751E382@aosc.io>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com> <EF718AB4-DD07-4D67-BE2E-1B9EBA5EB25F@aosc.io> <20180710130517.GA27236@Red>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710130517.GA27236@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, LABBE Corentin <clabbe@baylibre.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, tj@kernel.org, maxime.ripard@free-electrons.com
List-Id: linux-ide@vger.kernel.org



于 2018年7月10日 GMT+08:00 下午9:05:17, LABBE Corentin <clabbe@baylibre.com> 写到:
>On Mon, Jul 09, 2018 at 11:44:20PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> 于 2018年7月9日 GMT+08:00 下午11:20:54, Corentin Labbe
><clabbe@baylibre.com> 写到:
>> >Hello
>> >
>> >With Moeicenowy's agreement, I have take leadership ot this
>patchset.
>> >
>> >There are no really changes appart renaming struct quirck to
>variant.
>> >
>> >Since the last serie is really old, I will answer comment here.
>> >The two regulator (1.2 and 2.5V) are not for the PHY since:
>> >- nothing in the schematic said that they are for the PHY, they
>seems
>> >  only for controller
>> >- all other AHCI driver use 5V for the target/PHY (vs 1.2/2.5 which
>> >  cannot be used for target)
>> 
>> Target is not equal to PHY. Target means the supply
>> of the disk, which can be usually 5v (for 2.5" HDD) or
>> 12v (3.5" HDD).
>> 
>> By reading Wikipedia articles  about SATA and LVDS, I assume
>> 2.5V is for PHY and 1.2V is for internal digital logic (VDD-SYS
>> is commonly 1.2V on 40nm Allwinner SoCs; 2.5V VDD can be
>> used to efficiently deliver ~1.2V LVDS.)
>> 
>> P.S. VDD-SATA and VDD25-SATA also exist on A20, and by checking
>> Banana Pi M1 (the original Banana Pi) schematics, VDD-SATA
>> is connected to common VDD-SYS (called INTVDD on the
>> schematics) and VDD25-SATA is connected to an always-on
>> fixed LDO, maybe due to the lack of power outputs on AXP209.
>> 
>
>So we still need to add a regulator on the controller and add an
>optionnal "phy" regulator for AHCI port.

No, phy is not a part of the port. From the perspective of
the users, phy is part of the controller.

I still suggest generic multiple regulator support, to
reduce sunxi-specified code.

>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
