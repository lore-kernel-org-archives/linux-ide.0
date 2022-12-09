Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC3C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 07:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLIHcU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLIHbr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2022 02:31:47 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF12109F
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 23:31:36 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=A/ThwtIHF7VcMrZ1bK//UdrihjBgYq03/cUsdYetRTQ=;
        b=DuC+Xo33viRaPapbApqNVOtXS2IyyVw4Ysmcj0zz/ivtbfgl3pzgYdrXEG0kJULIlq9SfoOqfSRJRrtJi3Oh2hpJ8HdDdNcsZUaqJJJ1nkKGKEPZtMM2ErvhZsg/B2Rk4kSON9s2TYNziQOceV9Fhx+wVvb/fJ/31zXjd/Ewe2C3fwmt0Zl9EnbDdjS6voU40lQ8T0S4sKjXY1s1zVoUKSJGrCbn37R/MVEecf3yNIDIr6B61m9EJG8TuI
        dRZb/NROdaK7vepQx+bT+0BQ4c6vEHJJYjdQNj6tXo17Ib6f3DXqYsNOl4IikpRlpFHcp+/UmhtFscLXyup0Kd6/+Kfg==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Fri, 9 Dec 2022 07:31:33 +0000
MIME-Version: 1.0
Date:   Fri, 09 Dec 2022 07:31:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
References: <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
 <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
X-Originating-IP: 84.232.129.15
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

December 9, 2022 4:58 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> On 12/9/22 03:06, marius@psihoexpert.ro wrote:
>=20
>=20Checking the specs for the SoC again, it does say:
>=20
>=20Gen3 Serial ATA PHY (6 Gbps) with speed negotiation to Gen1, Gen2
>=20
>=20So with your gen2 (3gbps) pmp box, clearly, the speed negotiation is =
not
> working but limiting it to 1.5gbps seems ok. Could you add the followin=
g
> print to see what the HW is saying it supports ?
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..b3925239b8b0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5271,6 +5271,9 @@ int sata_link_init_spd(struct ata_link *link)
> if (rc)
> return rc;
>=20
>=20+ ata_link_info(link, "SCR_CONTROL =3D 0x%x\n",
> + link->saved_scontrol);
> +
> spd =3D (link->saved_scontrol >> 4) & 0xf;
> if (spd)
> link->hw_sata_spd_limit &=3D (1 << spd) - 1;
>=20
>=20--
> Damien Le Moal
> Western Digital Research


Without libata.force=3D2:1.5Gbps, the extra debug message appears only du=
ring boot.
Cable connected or not - doesn't matter - the messages are the same.

[    4.480888][    T1] scsi host1: ahci-mvebu
[    4.485149][    T1] device: 'host1': device_add
[    4.489728][    T1] bus: 'scsi': add device host1
[    4.494544][    T1] device: 'host1': device_add
[    4.499589][    T1] ata1: SCR_CONTROL =3D 0x0
[    4.503822][    T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10=
a9fff] port 0x100 irq 42
[    4.512480][    T1] ata2: SCR_CONTROL =3D 0x0
[    4.516704][    T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10=
a9fff] port 0x180 irq 42
[    4.525443][    T1] driver: 'ahci-mvebu': driver_bound: bound to devic=
e 'f10a8000.sata'
[    4.533599][    T1] bus: 'platform': really_probe: bound device f10a80=
00.sata to driver ahci-mvebu


With libata.force=3D2:1.5Gbps, the same message appears during boot, but =
then, when the device is detected:

[   17.624417][  T113] hardreset, Online=3D>Offline
[   17.625498][  T113] resume, do loop
[   17.853273][  T113] resume, after do loop
[   17.913272][  T113] debounce, SCR=3D0x113
[   17.973271][  T113] debounce, SCR=3D0x113
[   18.033271][  T113] debounce, SCR=3D0x113
[   18.093271][  T113] debounce, SCR=3D0x113
[   18.153271][  T113] debounce, SCR=3D0x113
[   18.213270][  T113] debounce, SCR=3D0x113
[   18.273270][  T113] debounce, SCR=3D0x113
[   18.333270][  T113] debounce, SCR=3D0x113
[   18.393271][  T113] debounce, SCR=3D0x113
[   18.397130][  T113] resume, return at end of function
[   18.400987][  T113] hardreset, Offline=3D>Online
[   18.410547][  T113] hardreset, sata_pmp_supported, before check_ready
[   18.583275][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[   18.597005][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f
[   18.605655][  T113] device: 'link2.0': device_add
[   18.610473][  T113] device: 'link2.0': device_add
[   18.615504][  T113] device: 'dev2.0.0': device_add
[   18.620352][  T113] device: 'dev2.0.0': device_add
[   18.625852][  T113] device: 'link2.1': device_add
[   18.630625][  T113] device: 'link2.1': device_add
[   18.635522][  T113] device: 'dev2.1.0': device_add
[   18.640371][  T113] device: 'dev2.1.0': device_add
[   18.646031][  T113] device: 'link2.2': device_add
[   18.650796][  T113] device: 'link2.2': device_add
[   18.656012][  T113] device: 'dev2.2.0': device_add
[   18.660865][  T113] device: 'dev2.2.0': device_add
[   18.666438][  T113] device: 'link2.3': device_add
[   18.671204][  T113] device: 'link2.3': device_add
[   18.676113][  T113] device: 'dev2.3.0': device_add
[   18.680962][  T113] device: 'dev2.3.0': device_add
[   18.686775][  T113] device: 'link2.4': device_add
[   18.691544][  T113] device: 'link2.4': device_add
[   18.696469][  T113] device: 'dev2.4.0': device_add
[   18.701319][  T113] device: 'dev2.4.0': device_add
[   18.706341][  T113] device: 'link2.5': device_add
[   18.711109][  T113] device: 'link2.5': device_add
[   18.716036][  T113] device: 'dev2.5.0': device_add
[   18.720888][  T113] device: 'dev2.5.0': device_add
[   18.726475][  T113] device: 'link2.6': device_add
[   18.731243][  T113] device: 'link2.6': device_add
[   18.736445][  T113] device: 'dev2.6.0': device_add
[   18.741300][  T113] device: 'dev2.6.0': device_add
[   18.746642][  T113] device: 'link2.7': device_add
[   18.751412][  T113] device: 'link2.7': device_add
[   18.756871][  T113] device: 'dev2.7.0': device_add
[   18.761730][  T113] device: 'dev2.7.0': device_add
[   18.766760][  T113] device: 'link2.8': device_add
[   18.771528][  T113] device: 'link2.8': device_add
[   18.776986][  T113] device: 'dev2.8.0': device_add
[   18.781847][  T113] device: 'dev2.8.0': device_add
[   18.787176][  T113] device: 'link2.9': device_add
[   18.791951][  T113] device: 'link2.9': device_add
[   18.796844][  T113] device: 'dev2.9.0': device_add
[   18.801967][  T113] device: 'dev2.9.0': device_add
[   18.807019][  T113] device: 'link2.10': device_add
[   18.811877][  T113] device: 'link2.10': device_add
[   18.817156][  T113] device: 'dev2.10.0': device_add
[   18.822104][  T113] device: 'dev2.10.0': device_add
[   18.827544][  T113] device: 'link2.11': device_add
[   18.832406][  T113] device: 'link2.11': device_add
[   18.837713][  T113] device: 'dev2.11.0': device_add
[   18.842661][  T113] device: 'dev2.11.0': device_add
[   18.848594][  T113] device: 'link2.12': device_add
[   18.853474][  T113] device: 'link2.12': device_add
[   18.858472][  T113] device: 'dev2.12.0': device_add
[   18.863433][  T113] device: 'dev2.12.0': device_add
[   18.869167][  T113] device: 'link2.13': device_add
[   18.874050][  T113] device: 'link2.13': device_add
[   18.879039][  T113] device: 'dev2.13.0': device_add
[   18.884013][  T113] device: 'dev2.13.0': device_add
[   18.889113][  T113] device: 'link2.14': device_add
[   18.893992][  T113] device: 'link2.14': device_add
[   18.898985][  T113] device: 'dev2.14.0': device_add
[   18.903948][  T113] device: 'dev2.14.0': device_add
[   18.909642][  T113] ahci-mvebu f10a8000.sata: FBS is enabled
[   18.915398][  T113] ata2.00: SCR_CONTROL =3D 0x300
[   18.920044][  T113] ata2.00: FORCE: PHY spd limit set to 1.5Gbps
[   18.926149][  T113] ata2.01: SCR_CONTROL =3D 0x300
[   18.930795][  T113] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
[   18.936889][  T113] ata2.02: SCR_CONTROL =3D 0x300
[   18.941533][  T113] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
[   18.947634][  T113] ata2.03: SCR_CONTROL =3D 0x300
[   18.952277][  T113] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
[   18.958371][  T113] ata2.04: SCR_CONTROL =3D 0x300
[   18.963015][  T113] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
[   18.969111][  T113] ata2.05: SCR_CONTROL =3D 0x300
[   18.973775][  T113] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
[   18.979846][  T113] ata2.06: SCR_CONTROL =3D 0x300
[   18.984515][  T113] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
[   18.990586][  T113] ata2.07: SCR_CONTROL =3D 0x300
[   18.995251][  T113] ata2.07: FORCE: PHY spd limit set to 1.5Gbps
[   19.001401][  T113] ata2.00: hard resetting link
[   19.006066][  T113] hardreset, Online=3D>Offline
[   19.006105][  T113] Reconfig spd
[   19.011857][  T113] resume, do loop
[   19.243309][  T113] resume, after do loop
[   19.251950][  T113] debounce, SCR=3D0x123
[   19.261104][  T113] debounce, SCR=3D0x123
[   19.270082][  T113] debounce, SCR=3D0x123
[   19.279059][  T113] debounce, SCR=3D0x123
[   19.288018][  T113] debounce, SCR=3D0x123
[   19.296978][  T113] debounce, SCR=3D0x123
[   19.305937][  T113] debounce, SCR=3D0x123
[   19.314896][  T113] debounce, SCR=3D0x123
[   19.323855][  T113] debounce, SCR=3D0x123
[   19.332813][  T113] debounce, SCR=3D0x123
[   19.341790][  T113] debounce, SCR=3D0x123
[   19.350768][  T113] debounce, SCR=3D0x123
[   19.354706][  T113] resume, return at end of function
[   19.358595][  T113] hardreset, Offline=3D>Online
[   19.368155][  T113] hardreset, after check_ready
[   19.368372][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   19.380239][  T113] ata2.01: hard resetting link
[   19.384903][  T113] hardreset, Online=3D>Offline
[   19.384940][  T113] Reconfig spd
[   19.390688][  T113] resume, do loop
[   19.623306][  T113] resume, after do loop
[   19.631947][  T113] debounce, SCR=3D0x123
[   19.641098][  T113] debounce, SCR=3D0x123
[   19.650075][  T113] debounce, SCR=3D0x123
[   19.659053][  T113] debounce, SCR=3D0x123
[   19.668011][  T113] debounce, SCR=3D0x123
[   19.676970][  T113] debounce, SCR=3D0x123
[   19.685929][  T113] debounce, SCR=3D0x123
[   19.694889][  T113] debounce, SCR=3D0x123
[   19.703847][  T113] debounce, SCR=3D0x123
[   19.712805][  T113] debounce, SCR=3D0x123
[   19.721782][  T113] debounce, SCR=3D0x123
[   19.730760][  T113] debounce, SCR=3D0x123
[   19.734699][  T113] resume, return at end of function
[   19.738587][  T113] hardreset, Offline=3D>Online
[   19.748146][  T113] hardreset, after check_ready
[   19.748363][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
...


I had the impression that speed always starts low and is negociated up (1=
.5 -> 3 -> 6), not starting high and decreased. How would negociation wor=
k if the speed is too high and one of the devices can't communicate?

I tried the pmp box on other computers. ATI/AMD AHCI, Jmicron PATA/SATA c=
ombo card, Intel ICH7. None of these have any errors in the log.

Marius Dinu

