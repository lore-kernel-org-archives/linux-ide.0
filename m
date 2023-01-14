Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC86C46467
	for <linux-ide@archiver.kernel.org>; Sat, 14 Jan 2023 18:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjANSdA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 14 Jan 2023 13:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjANSc7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jan 2023 13:32:59 -0500
X-Greylist: delayed 1803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 10:32:56 PST
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1BA5E3
        for <linux-ide@vger.kernel.org>; Sat, 14 Jan 2023 10:32:56 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=lwcmPN9ytT4kpbySjh9T+XH6Wv6qgJuQrUdYo2s8g64=;
        b=HzjU4O12cL5aS58vxR8YgYryGFm9Bz5n6U5omSqmfIS/m3HZ7/GsRBq2TR6CWYZjOdtpcTlYT9jEl45vDJQD3AvnJiV97V8PPlEsPHlGH3d7Pc685S2ny6N5CLbSFoSdDJCxQcTx+AucItseXGA61xz7lkDUICuxBEvCghgpQ9jOcrlmeIsmL5U0+osfXgXvIQpK/AWY08g1tthvZ+DLABwWxRlcPaQm+tosKSzvrd0gY8e0lOrI/KBylj
        IlY61e4tM3KFD0Cr4SQ7/QiF6EypOGmsOix88dQYnqnBk2QnTKAjDZ0A8JG0JHaAWce54kQ/l5XtGMZQyuMuaX5JfcZw==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sat, 14 Jan 2023 18:01:31 +0000
MIME-Version: 1.0
Date:   Sat, 14 Jan 2023 18:01:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <b6d818c162b14cc508f5cdb14c6e88a9@psihoexpert.ro>
References: <b6d818c162b14cc508f5cdb14c6e88a9@psihoexpert.ro>
 <7521d86e-a83e-7972-a4cc-55dd7155fa43@opensource.wdc.com>
 <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
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
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
X-Originating-IP: 86.123.22.43
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Do you need any more tests?


December 9, 2022 8:30 PM, marius@psihoexpert.ro wrote:

> December 9, 2022 11:28 AM, "Damien Le Moal" <damien.lemoal@opensource.w=
dc.com> wrote:
>=20
>>>=20[ 19.006105][ T113] Reconfig spd
>>=20
>>=20Which function did you add this message to ?
>=20
>=20sata_link_hardreset(), inside if(sata_set_spd_needed(link)){} conditi=
on,
> but I replaced it with detailed debug inside sata_set_spd_needed() and =
___sata_set_spd_needed()
>=20
>=20I ran the tests again with the new debug messages.
> These are kernel boot logs with eSATA cable already connected.
> I selected only the interesting lines to make it easy to read.
>=20
>=20---- force 1.5Gbps ----
>=20
>=20[ 4.362670][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 =
ports 6 Gbps 0x3 impl platform
> mode
> [ 4.372489][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led on=
ly pmp fbs pio slum part sxs
> [ 4.501238][ T1] ata1: SCR_CONTROL =3D 0x0
> [ 4.505468][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x100 irq 42
> [ 4.514123][ T1] ata2: SCR_CONTROL =3D 0x0
> [ 4.518345][ T1] ata2: FORCE: PHY spd limit set to 1.5Gbps
> [ 4.524121][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x180 irq 42
> [ 4.533000][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f=
10a8000.sata'
> [ 4.533531][ T107] hardreset, Online=3D>Offline
> [ 4.541075][ T107] sata_set_spd_needed, scontrol=3D0x0
> [ 4.545587][ T107] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
> [ 4.559662][ T107] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
> [ 4.559667][ T107] __sata_set_spd_needed, target=3D0x0
> [ 4.559671][ T107] __sata_set_spd_needed, spd=3D0x0
> [ 4.559675][ T107] __sata_set_spd_needed, final *scontrol=3D0x0
> [ 4.560898][ T107] resume, do loop
> [ 4.571158][ T112] hardreset, Online=3D>Offline
> [ 4.582480][ T112] sata_set_spd_needed, scontrol=3D0x0
> [ 4.593173][ T112] __sata_set_spd_needed, initial limit=3D0x1
> [ 4.601251][ T112] __sata_set_spd_needed, corrected limit=3D0x1
> [ 4.611322][ T112] __sata_set_spd_needed, target=3D0x1
> [ 4.627598][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 4.627602][ T112] __sata_set_spd_needed, final *scontrol=3D0x10
> [ 4.627608][ T112] __sata_set_spd_needed, initial limit=3D0x1 <--- why =
does it run twice?
> [ 4.627611][ T112] __sata_set_spd_needed, corrected limit=3D0x1
> [ 4.627615][ T112] __sata_set_spd_needed, target=3D0x1
> [ 4.627619][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 4.627622][ T112] __sata_set_spd_needed, final *scontrol=3D0x314
> [ 4.628702][ T112] resume, do loop
> [ 4.794479][ T107] resume, after do loop
> [ 4.800859][ T107] debounce, SCR=3D0x0 <---- T107 is probably ata1, not=
 connected
> [ 4.805936][ T107] debounce, SCR=3D0x0
> [ 4.814690][ T107] debounce, SCR=3D0x0
> [ 4.822841][ T107] debounce, SCR=3D0x0
> [ 4.836237][ T107] debounce, SCR=3D0x0
> [ 4.845368][ T107] debounce, SCR=3D0x0
> [ 4.855008][ T107] debounce, SCR=3D0x0
> [ 4.864502][ T112] resume, after do loop
> [ 4.869198][ T107] debounce, SCR=3D0x0
> [ 4.877867][ T112] debounce, SCR=3D0x113 <---- T112 is probably ata2, l=
ink detected
> [ 4.886183][ T107] debounce, SCR=3D0x0
> [ 4.894861][ T107] resume, return at end of function
> [ 4.903009][ T107] hardreset, ata_phys_link_offline check failed
> [ 4.913867][ T107] ata1: SATA link down (SStatus 0 SControl 300)
> [ 4.924894][ T112] debounce, SCR=3D0x113
> ...
> [ 5.867867][ T112] ata2.00: SCR_CONTROL =3D 0x300
> [ 5.872520][ T112] ata2.00: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.883284][ T112] ata2.01: SCR_CONTROL =3D 0x300
> [ 5.887960][ T112] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.888111][ T112] ata2.02: SCR_CONTROL =3D 0x300
> [ 5.901206][ T112] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.919553][ T112] ata2.03: SCR_CONTROL =3D 0x300
> [ 5.930054][ T112] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.956888][ T112] ata2.04: SCR_CONTROL =3D 0x300
> [ 5.968103][ T112] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.984053][ T112] ata2.05: SCR_CONTROL =3D 0x300
> [ 5.988735][ T112] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.988858][ T112] ata2.06: SCR_CONTROL =3D 0x300
> [ 5.988865][ T112] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.988947][ T112] ata2.07: SCR_CONTROL =3D 0x300
> [ 5.988953][ T112] ata2.07: FORCE: PHY spd limit set to 1.5Gbps
> [ 5.997728][ T112] ata2.00: hard resetting link
> [ 6.008378][ T112] hardreset, Online=3D>Offline
> [ 6.025110][ T112] sata_set_spd_needed, scontrol=3D0x300
> [ 6.039361][ T112] __sata_set_spd_needed, initial limit=3D0x1
> [ 6.049281][ T112] __sata_set_spd_needed, corrected limit=3D0x1
> [ 6.064930][ T112] __sata_set_spd_needed, target=3D0x1
> [ 6.064935][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 6.064939][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
> [ 6.097506][ T112] __sata_set_spd_needed, initial limit=3D0x1
> [ 6.108372][ T112] __sata_set_spd_needed, corrected limit=3D0x1
> [ 6.118892][ T112] __sata_set_spd_needed, target=3D0x1
> [ 6.118897][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 6.129664][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
> [ 6.153117][ T112] resume, do loop
> [ 6.387397][ T112] resume, after do loop
> [ 6.394052][ T112] debounce, SCR=3D0x123
> [ 6.414455][ T112] debounce, SCR=3D0x123
> [ 6.427772][ T112] debounce, SCR=3D0x123
> [ 6.436940][ T112] debounce, SCR=3D0x123
> [ 6.446566][ T112] debounce, SCR=3D0x123
> [ 6.456201][ T112] debounce, SCR=3D0x123
> [ 6.461379][ T112] debounce, SCR=3D0x123
> [ 6.470664][ T112] debounce, SCR=3D0x123
> [ 6.494546][ T112] debounce, SCR=3D0x123
> [ 6.497712][ T112] resume, return at end of function
> [ 6.512188][ T112] hardreset, Offline=3D>Online
> [ 6.527056][ T112] hardreset, after check_ready
> [ 6.538540][ T112] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl=
 300)
>=20
>=20---- force 3.0Gbps ----
>=20
>=20[ 4.364181][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 =
ports 6 Gbps 0x3 impl platform
> mode
> [ 4.374001][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led on=
ly pmp fbs pio slum part sxs
> [ 4.501990][ T1] ata1: SCR_CONTROL =3D 0x0
> [ 4.506221][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x100 irq 42
> [ 4.514896][ T1] ata2: SCR_CONTROL =3D 0x0
> [ 4.519102][ T1] ata2: FORCE: PHY spd limit set to 3.0Gbps
> [ 4.524894][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x180 irq 42
> [ 4.533679][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f=
10a8000.sata'
> [ 4.541836][ T1] bus: 'platform': really_probe: bound device f10a8000.s=
ata to driver ahci-mvebu
> [ 4.544628][ T107] hardreset, Online=3D>Offline
> [ 4.550844][ T107] sata_set_spd_needed, scontrol=3D0x0
> [ 4.555435][ T107] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
> [ 4.565341][ T107] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
> [ 4.576197][ T107] __sata_set_spd_needed, target=3D0x0
> [ 4.576202][ T107] __sata_set_spd_needed, spd=3D0x0
> [ 4.576206][ T107] __sata_set_spd_needed, final *scontrol=3D0x0
> [ 4.590311][ T107] resume, do loop
> [ 4.598257][ T112] hardreset, Online=3D>Offline
> [ 4.615265][ T112] sata_set_spd_needed, scontrol=3D0x0
> [ 4.629198][ T112] __sata_set_spd_needed, initial limit=3D0x3
> [ 4.640664][ T112] __sata_set_spd_needed, corrected limit=3D0x3
> [ 4.640668][ T112] __sata_set_spd_needed, target=3D0x2
> [ 4.640672][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 4.652837][ T112] __sata_set_spd_needed, final *scontrol=3D0x20
> [ 4.663171][ T112] __sata_set_spd_needed, initial limit=3D0x3
> [ 4.674127][ T112] __sata_set_spd_needed, corrected limit=3D0x3
> [ 4.687268][ T112] __sata_set_spd_needed, target=3D0x2
> [ 4.687273][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 4.687277][ T112] __sata_set_spd_needed, final *scontrol=3D0x324
> [ 4.688355][ T112] resume, do loop
> [ 4.824481][ T107] resume, after do loop
> [ 4.833744][ T107] debounce, SCR=3D0x0
> ...
> [ 4.916944][ T107] debounce, SCR=3D0x0
> [ 4.924448][ T112] resume, after do loop
> [ 4.930813][ T107] debounce, SCR=3D0x0
> [ 4.940447][ T107] resume, return at end of function
> [ 4.948608][ T107] hardreset, ata_phys_link_offline check failed
> [ 4.958306][ T107] ata1: SATA link down (SStatus 0 SControl 300)
> [ 4.958766][ T112] debounce, SCR=3D0x100
> [ 4.974540][ T112] debounce, SCR=3D0x100
> [ 4.984450][ T112] debounce, SCR=3D0x100
> [ 4.998528][ T112] debounce, SCR=3D0x100
> [ 5.006870][ T112] debounce, SCR=3D0x101
> [ 5.016032][ T112] debounce, SCR=3D0x100
>=20
>=20---- nolpm ----
>=20
>=20[ 4.364384][ T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots 2 =
ports 6 Gbps 0x3 impl platform
> mode
> [ 4.374205][ T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf led on=
ly pmp fbs pio slum part sxs
> [ 4.502855][ T1] ata1: SCR_CONTROL =3D 0x0
> [ 4.507087][ T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x100 irq 42
> [ 4.515761][ T1] ata2: SCR_CONTROL =3D 0x0
> [ 4.519968][ T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10a9ff=
f] port 0x180 irq 42
> [ 4.528704][ T1] driver: 'ahci-mvebu': driver_bound: bound to device 'f=
10a8000.sata'
> [ 4.536860][ T1] bus: 'platform': really_probe: bound device f10a8000.s=
ata to driver ahci-mvebu
> [ 4.544628][ T107] hardreset, Online=3D>Offline
> [ 4.545867][ T107] sata_set_spd_needed, scontrol=3D0x0
> [ 4.550348][ T107] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
> [ 4.560435][ T107] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
> [ 4.571308][ T107] __sata_set_spd_needed, target=3D0x0
> [ 4.583386][ T107] __sata_set_spd_needed, spd=3D0x0
> [ 4.599648][ T107] __sata_set_spd_needed, final *scontrol=3D0x0
> [ 4.615974][ T107] resume, do loop
> [ 4.627876][ T112] hardreset, Online=3D>Offline
> [ 4.638396][ T112] sata_set_spd_needed, scontrol=3D0x0
> [ 4.647521][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
> [ 4.660915][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
> [ 4.673702][ T112] __sata_set_spd_needed, target=3D0x0
> [ 4.686663][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 4.686668][ T112] __sata_set_spd_needed, final *scontrol=3D0x0
> [ 4.688105][ T112] resume, do loop
> [ 4.854467][ T107] resume, after do loop
> [ 4.863650][ T107] debounce, SCR=3D0x0
> [ 4.873874][ T107] debounce, SCR=3D0x0
> [ 4.882559][ T107] debounce, SCR=3D0x0
> [ 4.891306][ T107] debounce, SCR=3D0x0
> [ 4.901119][ T107] debounce, SCR=3D0x0
> [ 4.910367][ T107] debounce, SCR=3D0x0
> [ 4.915322][ T112] resume, after do loop
> [ 4.920379][ T107] debounce, SCR=3D0x0
> [ 4.927643][ T112] debounce, SCR=3D0x100
> [ 4.936031][ T107] debounce, SCR=3D0x0
> [ 4.944728][ T112] debounce, SCR=3D0x100
> [ 4.953532][ T107] debounce, SCR=3D0x0
> [ 4.962475][ T107] resume, return at end of function
> [ 4.970650][ T107] hardreset, ata_phys_link_offline check failed
> [ 4.980376][ T107] ata1: SATA link down (SStatus 0 SControl 300)
> [ 4.991536][ T112] debounce, SCR=3D0x100
> [ 5.007097][ T112] debounce, SCR=3D0x100
> [ 5.016660][ T112] debounce, SCR=3D0x100
> [ 5.025693][ T112] debounce, SCR=3D0x100
> [ 5.030094][ T112] resume, return at end of function
> [ 5.033962][ T112] hardreset, ata_phys_link_offline check failed
> [ 5.043999][ T112] ata2: SATA link down (SStatus 101 SControl 300)
> [ 5.054652][ T112] hardreset, Online=3D>Offline
> [ 5.067061][ T112] sata_set_spd_needed, scontrol=3D0x300
> [ 5.067066][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
> [ 5.076006][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
> [ 5.076010][ T112] __sata_set_spd_needed, target=3D0x0
> [ 5.076014][ T112] __sata_set_spd_needed, spd=3D0x0
> [ 5.076018][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
> [ 5.077276][ T112] resume, do loop
> [ 5.314471][ T112] resume, after do loop
> [ 5.364488][ T112] debounce, SCR=3D0x100
> ... and doesn't work.
>=20
>=20Marius Dinu

