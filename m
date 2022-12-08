Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA8C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  8 Dec 2022 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLHSH0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Dec 2022 13:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLHSHS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 8 Dec 2022 13:07:18 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E02D2FBED
        for <linux-ide@vger.kernel.org>; Thu,  8 Dec 2022 10:07:13 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=3FPqhk+S5R5aN70cYo2fQKtpTdiFytsF0N11USVeWRQ=;
        b=mUY1lHP07q9k1cHpYgzGGjrWBaw37cq+C54FAtkQp4MMUdjBmzmUvk1zaf421FFym/cnIr8aNy+STSb/3cF9wkqWeYOeZ5MqniEwDSMFt51fZgbmRdS/LOiwG8v0I87dWLBG4+eyOuhodJYT3rL4vDlQltt6ANZvdtejtWlz3sRUI801IoyEQOTOsDFu6FDiVBzS7K9v2of0wCoGReAXFG+FWQA7Dwh/uJFXekzicHf2vC3ZYi5x6JXvs7
        5bBWuBksl8ckqWpC4xaJieg0NnfWJakcU+f6K6SKr2Wbn92r6qEAhUgjGluFDMNL3RXs3g/N0G8vN89xqD0Wm6OaM/Tg==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Thu, 8 Dec 2022 18:06:57 +0000
MIME-Version: 1.0
Date:   Thu, 08 Dec 2022 18:06:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
References: <f030af47-8522-cdef-8394-84f020c6ddca@opensource.wdc.com>
 <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
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
X-Originating-IP: 84.232.129.15
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

December 8, 2022 12:51 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> By the way, did you also try a cold boot ? Switching off your router,
> connect the pmp box, turn on the router ? Does it change anything ?
> ATA hot-plugging tends to have more problems, so worth trying. The
> ahci_mvebu driver errata is for hot-plug, so this newer SoC may have
> different issues with that too.

Yes. No change. Same errors.

> Can you try with no patches and no revert adding the following options =
to
> your kernel command line ?
>=20
>=20libata.force=3D2:3Gbps

No change. Same errors.

> libata.force=3D2:1.5Gbps

This one works, without any error at the beginning, unlike the way revert=
ed commit worked.

[ 33.635191][ T112] hardreset, Online=3D>Offline
[ 33.636272][ T112] resume, do loop
[ 33.862817][ T112] resume, after do loop
[ 33.922816][ T112] debounce, SCR=3D0x113
[ 33.982816][ T112] debounce, SCR=3D0x113
[ 34.042816][ T112] debounce, SCR=3D0x113
[ 34.102815][ T112] debounce, SCR=3D0x113
[ 34.162816][ T112] debounce, SCR=3D0x113
[ 34.222816][ T112] debounce, SCR=3D0x113
[ 34.282815][ T112] debounce, SCR=3D0x113
[ 34.342815][ T112] debounce, SCR=3D0x113
[ 34.402815][ T112] debounce, SCR=3D0x113
[ 34.406673][ T112] resume, return at end of function
[ 34.410531][ T112] hardreset, Offline=3D>Online
[ 34.420090][ T112] hardreset, sata_pmp_supported, before check_ready
[ 34.592820][ T112] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[ 34.606547][ T112] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 p=
orts, feat 0xf/0x1f
[ 34.615196][ T112] device: 'link2.0': device_add
[ 34.620015][ T112] device: 'link2.0': device_add
[ 34.625514][ T112] device: 'dev2.0.0': device_add
[ 34.630365][ T112] device: 'dev2.0.0': device_add
[ 34.635780][ T112] device: 'link2.1': device_add
[ 34.640545][ T112] device: 'link2.1': device_add
[ 34.646038][ T112] device: 'dev2.1.0': device_add
[ 34.650892][ T112] device: 'dev2.1.0': device_add
[ 34.656245][ T112] device: 'link2.2': device_add
[ 34.661009][ T112] device: 'link2.2': device_add
[ 34.666209][ T112] device: 'dev2.2.0': device_add
[ 34.671063][ T112] device: 'dev2.2.0': device_add
[ 34.676631][ T112] device: 'link2.3': device_add
[ 34.681400][ T112] device: 'link2.3': device_add
[ 34.686289][ T112] device: 'dev2.3.0': device_add
[ 34.691429][ T112] device: 'dev2.3.0': device_add
[ 34.696441][ T112] device: 'link2.4': device_add
[ 34.701206][ T112] device: 'link2.4': device_add
[ 34.706700][ T112] device: 'dev2.4.0': device_add
[ 34.711554][ T112] device: 'dev2.4.0': device_add
[ 34.716867][ T112] device: 'link2.5': device_add
[ 34.721634][ T112] device: 'link2.5': device_add
[ 34.726850][ T112] device: 'dev2.5.0': device_add
[ 34.731704][ T112] device: 'dev2.5.0': device_add
[ 34.737502][ T112] device: 'link2.6': device_add
[ 34.742271][ T112] device: 'link2.6': device_add
[ 34.747160][ T112] device: 'dev2.6.0': device_add
[ 34.752013][ T112] device: 'dev2.6.0': device_add
[ 34.757613][ T112] device: 'link2.7': device_add
[ 34.762387][ T112] device: 'link2.7': device_add
[ 34.767307][ T112] device: 'dev2.7.0': device_add
[ 34.772733][ T112] device: 'dev2.7.0': device_add
[ 34.777760][ T112] device: 'link2.8': device_add
[ 34.782531][ T112] device: 'link2.8': device_add
[ 34.787757][ T112] device: 'dev2.8.0': device_add
[ 34.792616][ T112] device: 'dev2.8.0': device_add
[ 34.797950][ T112] device: 'link2.9': device_add
[ 34.802722][ T112] device: 'link2.9': device_add
[ 34.807959][ T112] device: 'dev2.9.0': device_add
[ 34.812836][ T112] device: 'dev2.9.0': device_add
[ 34.818405][ T112] device: 'link2.10': device_add
[ 34.823282][ T112] device: 'link2.10': device_add
[ 34.828837][ T112] device: 'dev2.10.0': device_add
[ 34.833811][ T112] device: 'dev2.10.0': device_add
[ 34.839470][ T112] device: 'link2.11': device_add
[ 34.844348][ T112] device: 'link2.11': device_add
[ 34.849349][ T112] device: 'dev2.11.0': device_add
[ 34.854309][ T112] device: 'dev2.11.0': device_add
[ 34.859989][ T112] device: 'link2.12': device_add
[ 34.864870][ T112] device: 'link2.12': device_add
[ 34.869875][ T112] device: 'dev2.12.0': device_add
[ 34.875187][ T112] device: 'dev2.12.0': device_add
[ 34.880283][ T112] device: 'link2.13': device_add
[ 34.885162][ T112] device: 'link2.13': device_add
[ 34.890768][ T112] device: 'dev2.13.0': device_add
[ 34.895744][ T112] device: 'dev2.13.0': device_add
[ 34.901156][ T112] device: 'link2.14': device_add
[ 34.906038][ T112] device: 'link2.14': device_add
[ 34.911351][ T112] device: 'dev2.14.0': device_add
[ 34.916318][ T112] device: 'dev2.14.0': device_add
[ 34.922247][ T112] ahci-mvebu f10a8000.sata: FBS is enabled
[ 34.928004][ T112] ata2.00: FORCE: PHY spd limit set to 1.5Gbps <-- OK!
[ 34.934110][ T112] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
[ 34.940182][ T112] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
[ 34.946276][ T112] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
[ 34.952346][ T112] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
[ 34.958446][ T112] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
[ 34.964539][ T112] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
[ 34.970609][ T112] ata2.07: FORCE: PHY spd limit set to 1.5Gbps
[ 34.976785][ T112] ata2.00: hard resetting link
[ 34.981430][ T112] hardreset, Online=3D>Offline
[ 34.981466][ T112] Reconfig spd
[ 34.987235][ T112] resume, do loop
[ 35.212851][ T112] resume, after do loop
[ 35.221492][ T112] debounce, SCR=3D0x123
[ 35.230644][ T112] debounce, SCR=3D0x123
[ 35.239620][ T112] debounce, SCR=3D0x123
[ 35.248595][ T112] debounce, SCR=3D0x123
[ 35.257553][ T112] debounce, SCR=3D0x123
[ 35.266511][ T112] debounce, SCR=3D0x123
[ 35.275470][ T112] debounce, SCR=3D0x123
[ 35.284427][ T112] debounce, SCR=3D0x123
[ 35.293385][ T112] debounce, SCR=3D0x123
[ 35.302342][ T112] debounce, SCR=3D0x123
[ 35.311317][ T112] debounce, SCR=3D0x123
[ 35.320294][ T112] debounce, SCR=3D0x123
[ 35.324232][ T112] resume, return at end of function
[ 35.328121][ T112] hardreset, Offline=3D>Online
[ 35.337681][ T112] hardreset, after check_ready
[ 35.337896][ T112] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
[ 35.349762][ T112] ata2.01: hard resetting link ^
[ 35.354440][ T112] hardreset, Online=3D>Offline |
[ 35.354477][ T112] Reconfig spd |
[ 35.360222][ T112] resume, do loop |
[ 35.592850][ T112] resume, after do loop WHY?
[ 35.601489][ T112] debounce, SCR=3D0x123
[ 35.610638][ T112] debounce, SCR=3D0x123
[ 35.619614][ T112] debounce, SCR=3D0x123
[ 35.628590][ T112] debounce, SCR=3D0x123
[ 35.637546][ T112] debounce, SCR=3D0x123
[ 35.646505][ T112] debounce, SCR=3D0x123
[ 35.655462][ T112] debounce, SCR=3D0x123
[ 35.664419][ T112] debounce, SCR=3D0x123
[ 35.673376][ T112] debounce, SCR=3D0x123
[ 35.682333][ T112] debounce, SCR=3D0x123
[ 35.691308][ T112] debounce, SCR=3D0x123
[ 35.700286][ T112] debounce, SCR=3D0x123
[ 35.704222][ T112] resume, return at end of function
[ 35.708109][ T112] hardreset, Offline=3D>Online
[ 35.717668][ T112] hardreset, after check_ready
[ 35.717882][ T112] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
[ 35.729745][ T112] ata2.02: hard resetting link
[ 35.734408][ T112] hardreset, Online=3D>Offline
[ 35.734445][ T112] Reconfig spd
[ 35.740187][ T112] resume, do loop
[ 35.972849][ T112] resume, after do loop
[ 35.981488][ T112] debounce, SCR=3D0x0
[ 35.990638][ T112] debounce, SCR=3D0x0
[ 35.999438][ T112] debounce, SCR=3D0x0
[ 36.008238][ T112] debounce, SCR=3D0x0
[ 36.017020][ T112] debounce, SCR=3D0x0
[ 36.025803][ T112] debounce, SCR=3D0x0
[ 36.034586][ T112] debounce, SCR=3D0x0
[ 36.043368][ T112] debounce, SCR=3D0x0
[ 36.052150][ T112] debounce, SCR=3D0x0
[ 36.060951][ T112] debounce, SCR=3D0x0
[ 36.069751][ T112] debounce, SCR=3D0x0
[ 36.078570][ T112] debounce, SCR=3D0x0
[ 36.087354][ T112] debounce, SCR=3D0x0
[ 36.091097][ T112] resume, return at end of function
[ 36.094830][ T112] hardreset, ata_phys_link_offline check failed
[ 36.100117][ T112] ata2.02: SATA link down (SStatus 0 SControl 300)
[ 36.112710][ T112] ata2.03: hard resetting link
[ 36.117371][ T112] hardreset, Online=3D>Offline
[ 36.117407][ T112] Reconfig spd
[ 36.123152][ T112] resume, do loop
[ 36.352850][ T112] resume, after do loop
[ 36.361489][ T112] debounce, SCR=3D0x0
[ 36.370639][ T112] debounce, SCR=3D0x0
[ 36.379440][ T112] debounce, SCR=3D0x0
[ 36.388241][ T112] debounce, SCR=3D0x0
[ 36.397023][ T112] debounce, SCR=3D0x0
[ 36.405806][ T112] debounce, SCR=3D0x0
[ 36.414589][ T112] debounce, SCR=3D0x0
[ 36.423372][ T112] debounce, SCR=3D0x0
[ 36.432154][ T112] debounce, SCR=3D0x0
[ 36.440954][ T112] debounce, SCR=3D0x0
[ 36.449755][ T112] debounce, SCR=3D0x0
[ 36.458556][ T112] debounce, SCR=3D0x0
[ 36.467339][ T112] debounce, SCR=3D0x0
[ 36.471083][ T112] resume, return at end of function
[ 36.474816][ T112] hardreset, ata_phys_link_offline check failed
[ 36.480102][ T112] ata2.03: SATA link down (SStatus 0 SControl 300)
[ 36.492694][ T112] ata2.04: hard resetting link
[ 36.497357][ T112] hardreset, Online=3D>Offline
[ 36.497393][ T112] Reconfig spd
[ 36.503138][ T112] resume, do loop
[ 36.732849][ T112] resume, after do loop
[ 36.741487][ T112] debounce, SCR=3D0x0
[ 36.750637][ T112] debounce, SCR=3D0x0
[ 36.759438][ T112] debounce, SCR=3D0x0
[ 36.768238][ T112] debounce, SCR=3D0x0
[ 36.777022][ T112] debounce, SCR=3D0x0
[ 36.785805][ T112] debounce, SCR=3D0x0
[ 36.794588][ T112] debounce, SCR=3D0x0
[ 36.803370][ T112] debounce, SCR=3D0x0
[ 36.812152][ T112] debounce, SCR=3D0x0
[ 36.820952][ T112] debounce, SCR=3D0x0
[ 36.829752][ T112] debounce, SCR=3D0x0
[ 36.838554][ T112] debounce, SCR=3D0x0
[ 36.847337][ T112] debounce, SCR=3D0x0
[ 36.851081][ T112] resume, return at end of function
[ 36.854813][ T112] hardreset, ata_phys_link_offline check failed
[ 36.860099][ T112] ata2.04: SATA link down (SStatus 0 SControl 300)
[ 36.872692][ T112] ata2.05: hard resetting link
[ 36.877353][ T112] hardreset, Online=3D>Offline
[ 36.877390][ T112] Reconfig spd
[ 36.883134][ T112] resume, do loop
[ 37.112853][ T112] resume, after do loop
[ 37.121495][ T112] debounce, SCR=3D0x0
[ 37.130645][ T112] debounce, SCR=3D0x0
[ 37.139446][ T112] debounce, SCR=3D0x0
[ 37.148246][ T112] debounce, SCR=3D0x0
[ 37.157029][ T112] debounce, SCR=3D0x0
[ 37.165812][ T112] debounce, SCR=3D0x0
[ 37.174595][ T112] debounce, SCR=3D0x0
[ 37.183377][ T112] debounce, SCR=3D0x0
[ 37.192159][ T112] debounce, SCR=3D0x0
[ 37.200960][ T112] debounce, SCR=3D0x0
[ 37.209760][ T112] debounce, SCR=3D0x0
[ 37.218562][ T112] debounce, SCR=3D0x0
[ 37.227345][ T112] debounce, SCR=3D0x0
[ 37.231088][ T112] resume, return at end of function
[ 37.234820][ T112] hardreset, ata_phys_link_offline check failed
[ 37.240107][ T112] ata2.05: SATA link down (SStatus 0 SControl 300)
[ 37.252700][ T112] ata2.06: hard resetting link
[ 37.257361][ T112] hardreset, Online=3D>Offline
[ 37.257398][ T112] Reconfig spd
[ 37.263142][ T112] resume, do loop
[ 37.492850][ T112] resume, after do loop
[ 37.501489][ T112] debounce, SCR=3D0x0
[ 37.510639][ T112] debounce, SCR=3D0x0
[ 37.519439][ T112] debounce, SCR=3D0x0
[ 37.528240][ T112] debounce, SCR=3D0x0
[ 37.537023][ T112] debounce, SCR=3D0x0
[ 37.545806][ T112] debounce, SCR=3D0x0
[ 37.554588][ T112] debounce, SCR=3D0x0
[ 37.563371][ T112] debounce, SCR=3D0x0
[ 37.572154][ T112] debounce, SCR=3D0x0
[ 37.580955][ T112] debounce, SCR=3D0x0
[ 37.589755][ T112] debounce, SCR=3D0x0
[ 37.598557][ T112] debounce, SCR=3D0x0
[ 37.607339][ T112] debounce, SCR=3D0x0
[ 37.611082][ T112] resume, return at end of function
[ 37.614814][ T112] hardreset, ata_phys_link_offline check failed
[ 37.620099][ T112] ata2.06: SATA link down (SStatus 0 SControl 300)
[ 37.632690][ T112] ata2.07: hard resetting link
[ 37.637353][ T112] hardreset, Online=3D>Offline
[ 37.637388][ T112] Reconfig spd
[ 37.643133][ T112] resume, do loop
[ 37.872850][ T112] resume, after do loop
[ 37.881488][ T112] debounce, SCR=3D0x0
[ 37.890637][ T112] debounce, SCR=3D0x0
[ 37.899438][ T112] debounce, SCR=3D0x0
[ 37.908239][ T112] debounce, SCR=3D0x0
[ 37.917021][ T112] debounce, SCR=3D0x0
[ 37.925804][ T112] debounce, SCR=3D0x0
[ 37.934587][ T112] debounce, SCR=3D0x0
[ 37.943370][ T112] debounce, SCR=3D0x0
[ 37.952152][ T112] debounce, SCR=3D0x0
[ 37.960952][ T112] debounce, SCR=3D0x0
[ 37.969752][ T112] debounce, SCR=3D0x0
[ 37.978555][ T112] debounce, SCR=3D0x0
[ 37.987338][ T112] debounce, SCR=3D0x0
[ 37.991082][ T112] resume, return at end of function
[ 37.994814][ T112] hardreset, ata_phys_link_offline check failed
[ 38.000100][ T112] ata2.07: SATA link down (SStatus 0 SControl 300)
[ 38.012779][ T112] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max=
 UDMA/133
[ 38.020410][ T112] ata2.00: 976773168 sectors, multi 0: LBA48
[ 38.026514][ T112] ata2.00: configured for UDMA/133
[ 38.031581][ T112] ata2.01: ATA-6: Areca Archive, 0100 AX, max UDMA/133
[ 38.038512][ T112] ata2.01: 23437498368 sectors, multi 0: LBA48
[ 38.044787][ T112] ata2.01: configured for UDMA/133
[ 38.049919][ T112] ata2: EH complete
[ 38.054454][ T58] scsi 1:0:0:0: Direct-Access ATA WDC WD50ARC-5040 n/a P=
Q: 0 ANSI: 5
[ 38.064242][ T58] device: 'target1:0:0': device_add
[ 38.069370][ T58] bus: 'scsi': add device target1:0:0
[ 38.074767][ T58] device: '1:0:0:0': device_add
[ 38.079843][ T58] bus: 'scsi': add device 1:0:0:0
[ 38.084831][ T58] scsi 1:0:0:0: scheduling asynchronous probe
[ 38.090835][ T58] device: '1:0:0:0': device_add
[ 38.090848][ T117] bus: 'scsi': __driver_probe_device: matched device 1:=
0:0:0 with driver sd
[ 38.095746][ T58] device: '1:0:0:0': device_add
[ 38.104210][ T117] bus: 'scsi': really_probe: probing driver sd with dev=
ice 1:0:0:0
[ 38.117256][ T117] sd 1:0:0:0: no default pinctrl state
[ 38.122722][ T117] device: '1:0:0:0': device_add
[ 38.123554][ T58] scsi 1:1:0:0: Direct-Access ATA Areca Archive n/a PQ: =
0 ANSI: 5
[ 38.127910][ T117] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: =
(500 GB/466 GiB)
[ 38.137665][ T58] device: 'target1:1:0': device_add
[ 38.144920][ T117] sd 1:0:0:0: [sdb] Write Protect is off
[ 38.149702][ T58] bus: 'scsi': add device target1:1:0
[ 38.155226][ T117] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 38.160531][ T58] device: '1:1:0:0': device_add
[ 38.166371][ T117] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: e=
nabled, doesn't support
DPO or FUA
[ 38.171768][ T58] bus: 'scsi': add device 1:1:0:0
[ 38.180968][ T117] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 byte=
s
[ 38.185759][ T58] scsi 1:1:0:0: scheduling asynchronous probe
[ 38.192625][ T117] device: 'sdb': device_add
[ 38.199208][ T58] device: '1:1:0:0': device_add
[ 38.203409][ T21] bus: 'scsi': __driver_probe_device: matched device 1:1=
:0:0 with driver sd
[ 38.208171][ T58] device: '1:1:0:0': device_add
[ 38.216301][ T21] bus: 'scsi': really_probe: probing driver sd with devi=
ce 1:1:0:0
[ 38.228860][ T21] sd 1:1:0:0: no default pinctrl state
[ 38.234346][ T21] device: '1:1:0:0': device_add
[ 38.240819][ T117] device: '8:16': device_add
[ 38.247070][ T117] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[ 38.253360][ T117] driver: 'sd': driver_bound: bound to device '1:0:0:0'
[ 38.260231][ T117] bus: 'scsi': really_probe: bound device 1:0:0:0 to dr=
iver sd
[ 38.262841][ T21] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blocks:=
 (12.0 TB/10.9 TiB)
[ 38.267709][ T117] sd 1:0:0:0: async probe completed
[ 38.276356][ T21] sd 1:1:0:0: [sdc] Write Protect is off
[ 38.286864][ T21] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 38.292945][ T21] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: en=
abled, doesn't support DPO
or FUA
[ 38.303020][ T21] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 bytes
[ 38.309950][ T21] device: 'sdc': device_add
[ 38.316143][ T21] device: '8:32': device_add
[ 38.322104][ T21] sd 1:1:0:0: [sdc] Attached SCSI removable disk
[ 38.328368][ T21] driver: 'sd': driver_bound: bound to device '1:1:0:0'
[ 38.335279][ T21] bus: 'scsi': really_probe: bound device 1:1:0:0 to dri=
ver sd
[ 38.342721][ T21] sd 1:1:0:0: async probe completed

Note that the kernel command doesn't seem to actually limit the speed.
I looked in /sys too, and it matches kernel log:

/sys/devices/platform/soc/soc:internal-regs/f10a8000.sata # find -type f =
-name *spd* -print -exec cat {} \;
./ata1/link1/dev1.0/ata_device/dev1.0/spdn_cnt
0
./ata1/link1/ata_link/link1/sata_spd_limit
<unknown>
./ata1/link1/ata_link/link1/hw_sata_spd_limit
<unknown>
./ata1/link1/ata_link/link1/sata_spd
<unknown>
./ata2/link2.2/dev2.2.0/ata_device/dev2.2.0/spdn_cnt
0
./ata2/link2.2/ata_link/link2.2/sata_spd_limit
1.5 Gbps
./ata2/link2.2/ata_link/link2.2/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.2/ata_link/link2.2/sata_spd
<unknown>
./ata2/link2.12/dev2.12.0/ata_device/dev2.12.0/spdn_cnt
0
./ata2/link2.12/ata_link/link2.12/sata_spd_limit
<unknown>
./ata2/link2.12/ata_link/link2.12/hw_sata_spd_limit
<unknown>
./ata2/link2.12/ata_link/link2.12/sata_spd
<unknown>
./ata2/link2.0/dev2.0.0/ata_device/dev2.0.0/spdn_cnt
0
./ata2/link2.0/ata_link/link2.0/sata_spd_limit
1.5 Gbps
./ata2/link2.0/ata_link/link2.0/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.0/ata_link/link2.0/sata_spd
3.0 Gbps
./ata2/link2.10/dev2.10.0/ata_device/dev2.10.0/spdn_cnt
0
./ata2/link2.10/ata_link/link2.10/sata_spd_limit
<unknown>
./ata2/link2.10/ata_link/link2.10/hw_sata_spd_limit
<unknown>
./ata2/link2.10/ata_link/link2.10/sata_spd
<unknown>
./ata2/link2.9/ata_link/link2.9/sata_spd_limit
<unknown>
./ata2/link2.9/ata_link/link2.9/hw_sata_spd_limit
<unknown>
./ata2/link2.9/ata_link/link2.9/sata_spd
<unknown>
./ata2/link2.9/dev2.9.0/ata_device/dev2.9.0/spdn_cnt
0
./ata2/link2.7/dev2.7.0/ata_device/dev2.7.0/spdn_cnt
0
./ata2/link2.7/ata_link/link2.7/sata_spd_limit
1.5 Gbps
./ata2/link2.7/ata_link/link2.7/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.7/ata_link/link2.7/sata_spd
<unknown>
./ata2/link2.5/dev2.5.0/ata_device/dev2.5.0/spdn_cnt
0
./ata2/link2.5/ata_link/link2.5/sata_spd_limit
1.5 Gbps
./ata2/link2.5/ata_link/link2.5/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.5/ata_link/link2.5/sata_spd
<unknown>
./ata2/link2.3/dev2.3.0/ata_device/dev2.3.0/spdn_cnt
0
./ata2/link2.3/ata_link/link2.3/sata_spd_limit
1.5 Gbps
./ata2/link2.3/ata_link/link2.3/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.3/ata_link/link2.3/sata_spd
<unknown>
./ata2/link2.13/dev2.13.0/ata_device/dev2.13.0/spdn_cnt
0
./ata2/link2.13/ata_link/link2.13/sata_spd_limit
<unknown>
./ata2/link2.13/ata_link/link2.13/hw_sata_spd_limit
<unknown>
./ata2/link2.13/ata_link/link2.13/sata_spd
<unknown>
./ata2/link2.1/dev2.1.0/ata_device/dev2.1.0/spdn_cnt
0
./ata2/link2.1/ata_link/link2.1/sata_spd_limit
1.5 Gbps
./ata2/link2.1/ata_link/link2.1/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.1/ata_link/link2.1/sata_spd
3.0 Gbps
./ata2/link2/dev2.0/ata_device/dev2.0/spdn_cnt
0
./ata2/link2/ata_link/link2/sata_spd_limit
1.5 Gbps
./ata2/link2/ata_link/link2/hw_sata_spd_limit
1.5 Gbps
./ata2/link2/ata_link/link2/sata_spd
1.5 Gbps
./ata2/link2.11/ata_link/link2.11/sata_spd_limit
<unknown>
./ata2/link2.11/ata_link/link2.11/hw_sata_spd_limit
<unknown>
./ata2/link2.11/ata_link/link2.11/sata_spd
<unknown>
./ata2/link2.11/dev2.11.0/ata_device/dev2.11.0/spdn_cnt
0
./ata2/link2.8/dev2.8.0/ata_device/dev2.8.0/spdn_cnt
0
./ata2/link2.8/ata_link/link2.8/sata_spd_limit
<unknown>
./ata2/link2.8/ata_link/link2.8/hw_sata_spd_limit
<unknown>
./ata2/link2.8/ata_link/link2.8/sata_spd
<unknown>
./ata2/link2.6/ata_link/link2.6/sata_spd_limit
1.5 Gbps
./ata2/link2.6/ata_link/link2.6/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.6/ata_link/link2.6/sata_spd
<unknown>
./ata2/link2.6/dev2.6.0/ata_device/dev2.6.0/spdn_cnt
0
./ata2/link2.4/dev2.4.0/ata_device/dev2.4.0/spdn_cnt
0
./ata2/link2.4/ata_link/link2.4/sata_spd_limit
1.5 Gbps
./ata2/link2.4/ata_link/link2.4/hw_sata_spd_limit
1.5 Gbps
./ata2/link2.4/ata_link/link2.4/sata_spd
<unknown>
./ata2/link2.14/ata_link/link2.14/sata_spd_limit
<unknown>
./ata2/link2.14/ata_link/link2.14/hw_sata_spd_limit
<unknown>
./ata2/link2.14/ata_link/link2.14/sata_spd
<unknown>
./ata2/link2.14/dev2.14.0/ata_device/dev2.14.0/spdn_cnt
0

Marius Dinu

