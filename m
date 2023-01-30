Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92027C54EED
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 07:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjA3HXg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 02:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjA3HXf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 02:23:35 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB511EAC
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 23:23:22 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=dMfNNiD5Na97i2p/WMe7WDk6UAxpXdWr187XdOO93kU=;
        b=hawd6SOlvIKTlyx8E/ysW+Ah94nH0rrk6HV5dhq6t4mR9CVlkOoMjQv6tIvlebiwy0QIEMS7K22WwHLXwhpWFy5Wi1qRgMnpwI2IkALumyAgtD5MjMdgVcv0dftdhvCsvbbRVu44FQuvuylkEB+yoDiXX8YqmYjIBaslmrz0sEr2bM3QilYvXZEGEewnhynf10YbJ3sDNa2S+SVrKsyNW4drCJWt2PEGVltmhf3g5GGiy5ih2di5NlYx4T
        FSzu0XbqISlrGO/3osMNNkzE1z+hFCxqyIPhtHCUEJlBhEXcL74+nPibPRTeQnhDZNhnC4PeEDlnST0sBVd3n8ZKIEbQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Mon, 30 Jan 2023 07:23:21 +0000
MIME-Version: 1.0
Date:   Mon, 30 Jan 2023 07:23:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <3c508c6e-5377-bb2d-64df-407f73a8170a@opensource.wdc.com>
References: <3c508c6e-5377-bb2d-64df-407f73a8170a@opensource.wdc.com>
 <ceb87cfa-b9f9-525b-bd85-9728833e8687@opensource.wdc.com>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
X-Originating-IP: 188.24.142.89
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 30, 2023 4:39 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:
>=20
>=20Apologies for asking you to test again, but could you try this simple=
r
> version of the initial tweak:
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..2ea572628b1c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u3=
2
> spd_limit)
> */
> if (spd > 1)
> mask &=3D (1 << (spd - 1)) - 1;
> - else
> + else if (link->sata_spd)
> return -EINVAL;
>=20
>=20/* were we already at the bottom? */
>=20
>=20This is a partial revert of the commit that created the issue in the
> first place. But better check this is OK.
>=20
>=20--
> Damien Le Moal
> Western Digital Research

No problem. I'll test everything until you find the best possible fix for=
 the kernel.

It works:

[   15.805656][  T113] hardreset, Online=3D>Offline
[   15.805666][  T113] sata_set_spd_needed, scontrol=3D0x300
[   15.810139][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   15.815417][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   15.821719][  T113] __sata_set_spd_needed, target=3D0x0
[   15.828208][  T113] __sata_set_spd_needed, spd=3D0x0
[   15.833289][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   15.839192][  T113] resume, do loop
[   16.073861][  T113] resume, after do loop
[   16.133861][  T113] debounce, SCR=3D0x100
[   16.193860][  T113] debounce, SCR=3D0x100
[   16.253860][  T113] debounce, SCR=3D0x100
[   16.313860][  T113] debounce, SCR=3D0x100
[   16.373861][  T113] debounce, SCR=3D0x100
[   16.433860][  T113] debounce, SCR=3D0x100
[   16.493860][  T113] debounce, SCR=3D0x100
[   16.553882][  T113] debounce, SCR=3D0x100
[   16.613861][  T113] debounce, SCR=3D0x100
[   16.617722][  T113] resume, return at end of function
[   16.621581][  T113] hardreset, ata_phys_link_offline check failed
[   16.626685][  T113] ata2: SATA link down (SStatus 101 SControl 300)
[   16.639152][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   16.649046][  T113] ata2: limiting SATA link speed to 1.5 Gbps
[   16.654931][  T113] hardreset, Online=3D>Offline
[   16.654937][  T113] sata_set_spd_needed, scontrol=3D0x300
[   16.659407][  T113] __sata_set_spd_needed, initial limit=3D0x1
[   16.664675][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   16.670364][  T113] __sata_set_spd_needed, target=3D0x1
[   16.676249][  T113] __sata_set_spd_needed, spd=3D0x0
[   16.681329][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   16.686160][  T113] __sata_set_spd_needed, initial limit=3D0x1
[   16.692200][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   16.697902][  T113] __sata_set_spd_needed, target=3D0x1
[   16.703767][  T113] __sata_set_spd_needed, spd=3D0x0
[   16.708858][  T113] __sata_set_spd_needed, final *scontrol=3D0x314
[   16.714748][  T113] resume, do loop
[   16.943861][  T113] resume, after do loop
[   17.003861][  T113] debounce, SCR=3D0x113
[   17.063882][  T113] debounce, SCR=3D0x113
[   17.123860][  T113] debounce, SCR=3D0x113
[   17.183861][  T113] debounce, SCR=3D0x113
[   17.243860][  T113] debounce, SCR=3D0x113
[   17.303861][  T113] debounce, SCR=3D0x113
[   17.363860][  T113] debounce, SCR=3D0x113
[   17.423860][  T113] debounce, SCR=3D0x113
[   17.483860][  T113] debounce, SCR=3D0x113
[   17.487721][  T113] resume, return at end of function
[   17.491580][  T113] hardreset, Offline=3D>Online
[   17.501142][  T113] hardreset, sata_pmp_supported, before check_ready
[   17.673864][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[   17.687589][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f
[   17.696209][  T113] device: 'link2.0': device_add
[   17.701015][  T113] device: 'link2.0': device_add
[   17.706001][  T113] device: 'dev2.0.0': device_add
[   17.710846][  T113] device: 'dev2.0.0': device_add
[   17.715847][  T113] device: 'link2.1': device_add
[   17.720606][  T113] device: 'link2.1': device_add
[   17.725467][  T113] device: 'dev2.1.0': device_add
[   17.730312][  T113] device: 'dev2.1.0': device_add
[   17.735299][  T113] device: 'link2.2': device_add
[   17.740056][  T113] device: 'link2.2': device_add
[   17.744909][  T113] device: 'dev2.2.0': device_add
[   17.749754][  T113] device: 'dev2.2.0': device_add
[   17.754725][  T113] device: 'link2.3': device_add
[   17.759483][  T113] device: 'link2.3': device_add
[   17.764355][  T113] device: 'dev2.3.0': device_add
[   17.769200][  T113] device: 'dev2.3.0': device_add
[   17.774175][  T113] device: 'link2.4': device_add
[   17.778934][  T113] device: 'link2.4': device_add
[   17.783773][  T113] device: 'dev2.4.0': device_add
[   17.788635][  T113] device: 'dev2.4.0': device_add
[   17.793605][  T113] device: 'link2.5': device_add
[   17.798397][  T113] device: 'link2.5': device_add
[   17.803238][  T113] device: 'dev2.5.0': device_add
[   17.808100][  T113] device: 'dev2.5.0': device_add
[   17.813066][  T113] device: 'link2.6': device_add
[   17.817848][  T113] device: 'link2.6': device_add
[   17.822690][  T113] device: 'dev2.6.0': device_add
[   17.827552][  T113] device: 'dev2.6.0': device_add
[   17.832512][  T113] device: 'link2.7': device_add
[   17.837289][  T113] device: 'link2.7': device_add
[   17.842138][  T113] device: 'dev2.7.0': device_add
[   17.847004][  T113] device: 'dev2.7.0': device_add
[   17.851966][  T113] device: 'link2.8': device_add
[   17.856752][  T113] device: 'link2.8': device_add
[   17.861597][  T113] device: 'dev2.8.0': device_add
[   17.866464][  T113] device: 'dev2.8.0': device_add
[   17.871435][  T113] device: 'link2.9': device_add
[   17.876216][  T113] device: 'link2.9': device_add
[   17.881061][  T113] device: 'dev2.9.0': device_add
[   17.885928][  T113] device: 'dev2.9.0': device_add
[   17.890893][  T113] device: 'link2.10': device_add
[   17.895761][  T113] device: 'link2.10': device_add
[   17.900708][  T113] device: 'dev2.10.0': device_add
[   17.905665][  T113] device: 'dev2.10.0': device_add
[   17.910720][  T113] device: 'link2.11': device_add
[   17.915597][  T113] device: 'link2.11': device_add
[   17.920539][  T113] device: 'dev2.11.0': device_add
[   17.925497][  T113] device: 'dev2.11.0': device_add
[   17.930558][  T113] device: 'link2.12': device_add
[   17.935429][  T113] device: 'link2.12': device_add
[   17.940366][  T113] device: 'dev2.12.0': device_add
[   17.945324][  T113] device: 'dev2.12.0': device_add
[   17.950393][  T113] device: 'link2.13': device_add
[   17.955265][  T113] device: 'link2.13': device_add
[   17.960203][  T113] device: 'dev2.13.0': device_add
[   17.965163][  T113] device: 'dev2.13.0': device_add
[   17.970219][  T113] device: 'link2.14': device_add
[   17.975099][  T113] device: 'link2.14': device_add
[   17.980046][  T113] device: 'dev2.14.0': device_add
[   17.985007][  T113] device: 'dev2.14.0': device_add
[   17.990061][  T113] ahci-mvebu f10a8000.sata: FBS is enabled
[   17.995812][  T113] ata2.00: SCR_CONTROL =3D 0x300
[   18.000492][  T113] ata2.01: SCR_CONTROL =3D 0x300
[   18.005195][  T113] ata2.02: SCR_CONTROL =3D 0x300
[   18.009873][  T113] ata2.03: SCR_CONTROL =3D 0x300
[   18.014580][  T113] ata2.04: SCR_CONTROL =3D 0x300
[   18.019257][  T113] ata2.05: SCR_CONTROL =3D 0x300
[   18.023998][  T113] ata2.06: SCR_CONTROL =3D 0x300
[   18.028676][  T113] ata2.07: SCR_CONTROL =3D 0x300
[   18.033427][  T113] ata2.00: hard resetting link
[   18.038105][  T113] hardreset, Online=3D>Offline
[   18.038144][  T113] sata_set_spd_needed, scontrol=3D0x300
[   18.042615][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.047892][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.054208][  T113] __sata_set_spd_needed, target=3D0x1
[   18.060072][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.065164][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.070076][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.076145][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.082447][  T113] __sata_set_spd_needed, target=3D0x1
[   18.088325][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.093406][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.099473][  T113] resume, do loop
[   18.333896][  T113] resume, after do loop
[   18.342538][  T113] debounce, SCR=3D0x123
[   18.351693][  T113] debounce, SCR=3D0x123
[   18.360674][  T113] debounce, SCR=3D0x123
[   18.369653][  T113] debounce, SCR=3D0x123
[   18.378614][  T113] debounce, SCR=3D0x123
[   18.387574][  T113] debounce, SCR=3D0x123
[   18.396533][  T113] debounce, SCR=3D0x123
[   18.405493][  T113] debounce, SCR=3D0x123
[   18.414452][  T113] debounce, SCR=3D0x123
[   18.423411][  T113] debounce, SCR=3D0x123
[   18.432390][  T113] debounce, SCR=3D0x123
[   18.441371][  T113] debounce, SCR=3D0x123
[   18.445312][  T113] resume, return at end of function
[   18.449202][  T113] hardreset, Offline=3D>Online
[   18.458767][  T113] hardreset, after check_ready
[   18.458984][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   18.470857][  T113] ata2.01: hard resetting link
[   18.475524][  T113] hardreset, Online=3D>Offline
[   18.475562][  T113] sata_set_spd_needed, scontrol=3D0x300
[   18.480032][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.485305][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.491606][  T113] __sata_set_spd_needed, target=3D0x1
[   18.497484][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.502564][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.507488][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.513527][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.519847][  T113] __sata_set_spd_needed, target=3D0x1
[   18.525725][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.530804][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.536834][  T113] resume, do loop
[   18.763894][  T113] resume, after do loop
[   18.772537][  T113] debounce, SCR=3D0x123
[   18.781691][  T113] debounce, SCR=3D0x123
[   18.790671][  T113] debounce, SCR=3D0x123
[   18.799650][  T113] debounce, SCR=3D0x123
[   18.808610][  T113] debounce, SCR=3D0x123
[   18.817570][  T113] debounce, SCR=3D0x123
[   18.826530][  T113] debounce, SCR=3D0x123
[   18.835489][  T113] debounce, SCR=3D0x123
[   18.844448][  T113] debounce, SCR=3D0x123
[   18.853407][  T113] debounce, SCR=3D0x123
[   18.862386][  T113] debounce, SCR=3D0x123
[   18.871368][  T113] debounce, SCR=3D0x123
[   18.875309][  T113] resume, return at end of function
[   18.879199][  T113] hardreset, Offline=3D>Online
[   18.888761][  T113] hardreset, after check_ready
[   18.888978][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   18.900849][  T113] ata2.02: hard resetting link
[   18.905516][  T113] hardreset, Online=3D>Offline
[   18.905554][  T113] sata_set_spd_needed, scontrol=3D0x300
[   18.910024][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.915297][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.921598][  T113] __sata_set_spd_needed, target=3D0x1
[   18.927476][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.932555][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.937478][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.943517][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   18.949837][  T113] __sata_set_spd_needed, target=3D0x1
[   18.955715][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.960794][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   18.966826][  T113] resume, do loop
[   19.193895][  T113] resume, after do loop
[   19.202536][  T113] debounce, SCR=3D0x0
[   19.211691][  T113] debounce, SCR=3D0x0
[   19.220496][  T113] debounce, SCR=3D0x0
[   19.229301][  T113] debounce, SCR=3D0x0
[   19.238087][  T113] debounce, SCR=3D0x0
[   19.246872][  T113] debounce, SCR=3D0x0
[   19.255658][  T113] debounce, SCR=3D0x0
[   19.264443][  T113] debounce, SCR=3D0x0
[   19.273228][  T113] debounce, SCR=3D0x0
[   19.282034][  T113] debounce, SCR=3D0x0
[   19.290839][  T113] debounce, SCR=3D0x0
[   19.299646][  T113] debounce, SCR=3D0x0
[   19.308430][  T113] debounce, SCR=3D0x0
[   19.312175][  T113] resume, return at end of function
[   19.315911][  T113] hardreset, ata_phys_link_offline check failed
[   19.321203][  T113] ata2.02: SATA link down (SStatus 0 SControl 300)
[   19.333802][  T113] ata2.03: hard resetting link
[   19.338467][  T113] hardreset, Online=3D>Offline
[   19.338504][  T113] sata_set_spd_needed, scontrol=3D0x300
[   19.342974][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   19.348247][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   19.354562][  T113] __sata_set_spd_needed, target=3D0x1
[   19.360426][  T113] __sata_set_spd_needed, spd=3D0x0
[   19.365526][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   19.370436][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   19.376495][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   19.382796][  T113] __sata_set_spd_needed, target=3D0x1
[   19.388674][  T113] __sata_set_spd_needed, spd=3D0x0
[   19.393753][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   19.399778][  T113] resume, do loop
[   19.633894][  T113] resume, after do loop
[   19.642535][  T113] debounce, SCR=3D0x0
[   19.651703][  T113] debounce, SCR=3D0x0
[   19.660509][  T113] debounce, SCR=3D0x0
[   19.669314][  T113] debounce, SCR=3D0x0
[   19.678100][  T113] debounce, SCR=3D0x0
[   19.686886][  T113] debounce, SCR=3D0x0
[   19.695671][  T113] debounce, SCR=3D0x0
[   19.704456][  T113] debounce, SCR=3D0x0
[   19.713242][  T113] debounce, SCR=3D0x0
[   19.722048][  T113] debounce, SCR=3D0x0
[   19.730852][  T113] debounce, SCR=3D0x0
[   19.739659][  T113] debounce, SCR=3D0x0
[   19.748444][  T113] debounce, SCR=3D0x0
[   19.752191][  T113] resume, return at end of function
[   19.755927][  T113] hardreset, ata_phys_link_offline check failed
[   19.761219][  T113] ata2.03: SATA link down (SStatus 0 SControl 300)
[   19.773817][  T113] ata2.04: hard resetting link
[   19.778481][  T113] hardreset, Online=3D>Offline
[   19.778519][  T113] sata_set_spd_needed, scontrol=3D0x300
[   19.782989][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   19.788262][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   19.794577][  T113] __sata_set_spd_needed, target=3D0x1
[   19.800441][  T113] __sata_set_spd_needed, spd=3D0x0
[   19.805541][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   19.810452][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   19.816511][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   19.822812][  T113] __sata_set_spd_needed, target=3D0x1
[   19.828689][  T113] __sata_set_spd_needed, spd=3D0x0
[   19.833769][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   19.839792][  T113] resume, do loop
[   20.073895][  T113] resume, after do loop
[   20.082536][  T113] debounce, SCR=3D0x0
[   20.091690][  T113] debounce, SCR=3D0x0
[   20.100496][  T113] debounce, SCR=3D0x0
[   20.109301][  T113] debounce, SCR=3D0x0
[   20.118087][  T113] debounce, SCR=3D0x0
[   20.126872][  T113] debounce, SCR=3D0x0
[   20.135658][  T113] debounce, SCR=3D0x0
[   20.144443][  T113] debounce, SCR=3D0x0
[   20.153228][  T113] debounce, SCR=3D0x0
[   20.162047][  T113] debounce, SCR=3D0x0
[   20.170854][  T113] debounce, SCR=3D0x0
[   20.179660][  T113] debounce, SCR=3D0x0
[   20.188447][  T113] debounce, SCR=3D0x0
[   20.192193][  T113] resume, return at end of function
[   20.195930][  T113] hardreset, ata_phys_link_offline check failed
[   20.201220][  T113] ata2.04: SATA link down (SStatus 0 SControl 300)
[   20.213818][  T113] ata2.05: hard resetting link
[   20.218483][  T113] hardreset, Online=3D>Offline
[   20.218520][  T113] sata_set_spd_needed, scontrol=3D0x300
[   20.222990][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   20.228263][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.234578][  T113] __sata_set_spd_needed, target=3D0x1
[   20.240442][  T113] __sata_set_spd_needed, spd=3D0x0
[   20.245542][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   20.250452][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   20.256511][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.262812][  T113] __sata_set_spd_needed, target=3D0x1
[   20.268689][  T113] __sata_set_spd_needed, spd=3D0x0
[   20.273768][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   20.279792][  T113] resume, do loop
[   20.513895][  T113] resume, after do loop
[   20.522535][  T113] debounce, SCR=3D0x0
[   20.531689][  T113] debounce, SCR=3D0x0
[   20.540495][  T113] debounce, SCR=3D0x0
[   20.549300][  T113] debounce, SCR=3D0x0
[   20.558085][  T113] debounce, SCR=3D0x0
[   20.566870][  T113] debounce, SCR=3D0x0
[   20.575657][  T113] debounce, SCR=3D0x0
[   20.584441][  T113] debounce, SCR=3D0x0
[   20.593226][  T113] debounce, SCR=3D0x0
[   20.602031][  T113] debounce, SCR=3D0x0
[   20.610836][  T113] debounce, SCR=3D0x0
[   20.619643][  T113] debounce, SCR=3D0x0
[   20.628429][  T113] debounce, SCR=3D0x0
[   20.632175][  T113] resume, return at end of function
[   20.635911][  T113] hardreset, ata_phys_link_offline check failed
[   20.641203][  T113] ata2.05: SATA link down (SStatus 0 SControl 300)
[   20.653800][  T113] ata2.06: hard resetting link
[   20.658466][  T113] hardreset, Online=3D>Offline
[   20.658503][  T113] sata_set_spd_needed, scontrol=3D0x300
[   20.662974][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   20.668261][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.674576][  T113] __sata_set_spd_needed, target=3D0x1
[   20.680440][  T113] __sata_set_spd_needed, spd=3D0x0
[   20.685539][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   20.690451][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   20.696510][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.702811][  T113] __sata_set_spd_needed, target=3D0x1
[   20.708688][  T113] __sata_set_spd_needed, spd=3D0x0
[   20.713768][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   20.719791][  T113] resume, do loop
[   20.953895][  T113] resume, after do loop
[   20.962536][  T113] debounce, SCR=3D0x0
[   20.971690][  T113] debounce, SCR=3D0x0
[   20.980496][  T113] debounce, SCR=3D0x0
[   20.989301][  T113] debounce, SCR=3D0x0
[   20.998087][  T113] debounce, SCR=3D0x0
[   21.006872][  T113] debounce, SCR=3D0x0
[   21.015657][  T113] debounce, SCR=3D0x0
[   21.024442][  T113] debounce, SCR=3D0x0
[   21.033227][  T113] debounce, SCR=3D0x0
[   21.042033][  T113] debounce, SCR=3D0x0
[   21.050838][  T113] debounce, SCR=3D0x0
[   21.059644][  T113] debounce, SCR=3D0x0
[   21.068429][  T113] debounce, SCR=3D0x0
[   21.072176][  T113] resume, return at end of function
[   21.075913][  T113] hardreset, ata_phys_link_offline check failed
[   21.081202][  T113] ata2.06: SATA link down (SStatus 0 SControl 300)
[   21.093800][  T113] ata2.07: hard resetting link
[   21.098465][  T113] hardreset, Online=3D>Offline
[   21.098502][  T113] sata_set_spd_needed, scontrol=3D0x300
[   21.102972][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   21.108246][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   21.114560][  T113] __sata_set_spd_needed, target=3D0x1
[   21.120424][  T113] __sata_set_spd_needed, spd=3D0x0
[   21.125524][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   21.130435][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   21.136494][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   21.142795][  T113] __sata_set_spd_needed, target=3D0x1
[   21.148673][  T113] __sata_set_spd_needed, spd=3D0x0
[   21.153752][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   21.159775][  T113] resume, do loop
[   21.393895][  T113] resume, after do loop
[   21.402537][  T113] debounce, SCR=3D0x0
[   21.411690][  T113] debounce, SCR=3D0x0
[   21.420496][  T113] debounce, SCR=3D0x0
[   21.429300][  T113] debounce, SCR=3D0x0
[   21.438085][  T113] debounce, SCR=3D0x0
[   21.446870][  T113] debounce, SCR=3D0x0
[   21.455656][  T113] debounce, SCR=3D0x0
[   21.464441][  T113] debounce, SCR=3D0x0
[   21.473227][  T113] debounce, SCR=3D0x0
[   21.482032][  T113] debounce, SCR=3D0x0
[   21.490837][  T113] debounce, SCR=3D0x0
[   21.499644][  T113] debounce, SCR=3D0x0
[   21.508430][  T113] debounce, SCR=3D0x0
[   21.512176][  T113] resume, return at end of function
[   21.515913][  T113] hardreset, ata_phys_link_offline check failed
[   21.521202][  T113] ata2.07: SATA link down (SStatus 0 SControl 300)
[   21.533889][  T113] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, =
max UDMA/133
[   21.541502][  T113] ata2.00: 976773168 sectors, multi 0: LBA48=20
[=20  21.547615][  T113] ata2.00: configured for UDMA/133
[   21.552677][  T113] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA=
/133
[   21.559611][  T113] ata2.01: 23437498368 sectors, multi 0: LBA48=20
[=20  21.565886][  T113] ata2.01: configured for UDMA/133
[   21.571033][  T113] ata2: EH complete
[   21.575491][   T76] scsi 1:0:0:0: Direct-Access     ATA      WDC WD50A=
RC-5040 n/a  PQ: 0 ANSI: 5
[   21.585235][   T76] device: 'target1:0:0': device_add
[   21.590356][   T76] bus: 'scsi': add device target1:0:0
[   21.595735][   T76] device: '1:0:0:0': device_add
[   21.600740][   T76] bus: 'scsi': add device 1:0:0:0
[   21.605721][   T76] scsi 1:0:0:0: scheduling asynchronous probe
[   21.611719][   T76] device: '1:0:0:0': device_add
[   21.611734][   T22] bus: 'scsi': __driver_probe_device: matched device=
 1:0:0:0 with driver sd
[   21.616593][   T76] device: '1:0:0:0': device_add
[   21.625099][   T22] bus: 'scsi': really_probe: probing driver sd with =
device 1:0:0:0
[   21.637640][   T22] sd 1:0:0:0: no default pinctrl state
[   21.643071][   T22] device: '1:0:0:0': device_add
[   21.644450][   T76] scsi 1:1:0:0: Direct-Access     ATA      Areca   A=
rchive  n/a  PQ: 0 ANSI: 5
[   21.648193][   T22] sd 1:0:0:0: [sdb] 976773168 512-byte logical block=
s: (500 GB/466 GiB)
[   21.657934][   T76] device: 'target1:1:0': device_add
[   21.665225][   T22] sd 1:0:0:0: [sdb] Write Protect is off
[   21.670030][   T76] bus: 'scsi': add device target1:1:0
[   21.675566][   T22] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   21.680850][   T76] device: '1:1:0:0': device_add
[   21.686703][   T22] sd 1:0:0:0: [sdb] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   21.691586][   T76] bus: 'scsi': add device 1:1:0:0
[   21.701326][   T22] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 b=
ytes
[   21.706077][   T76] scsi 1:1:0:0: scheduling asynchronous probe
[   21.712958][   T22] device: 'sdb': device_add
[   21.718923][   T76] device: '1:1:0:0': device_add
[   21.723651][    T8] bus: 'scsi': __driver_probe_device: matched device=
 1:1:0:0 with driver sd
[   21.728161][   T76] device: '1:1:0:0': device_add
[   21.736660][    T8] bus: 'scsi': really_probe: probing driver sd with =
device 1:1:0:0
[   21.749211][    T8] sd 1:1:0:0: no default pinctrl state
[   21.754659][    T8] device: '1:1:0:0': device_add
[   21.759991][   T22] device: '8:16': device_add
[   21.765576][    T8] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blo=
cks: (12.0 TB/10.9 TiB)
[   21.774242][    T8] sd 1:1:0:0: [sdc] Write Protect is off
[   21.779764][    T8] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   21.785698][    T8] sd 1:1:0:0: [sdc] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   21.795680][    T8] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 b=
ytes
[   21.802612][    T8] device: 'sdc': device_add
[   21.807704][    T8] device: '8:32': device_add
[   21.836417][    T8] sd 1:1:0:0: [sdc] Attached SCSI removable disk
[   21.842641][    T8] driver: 'sd': driver_bound: bound to device '1:1:0=
:0'
[   21.849545][    T8] bus: 'scsi': really_probe: bound device 1:1:0:0 to=
 driver sd
[   21.857027][    T8] sd 1:1:0:0: async probe completed
[   22.253067][   T22] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   22.259320][   T22] driver: 'sd': driver_bound: bound to device '1:0:0=
:0'
[   22.266220][   T22] bus: 'scsi': really_probe: bound device 1:0:0:0 to=
 driver sd
[   22.273664][   T22] sd 1:0:0:0: async probe completed


I also tested it with the latest kernel, no other modifications
(commit 6d796c50f84ca79f1722bb131799e5a5710c4700, tag: v6.2-rc6)
This is the boot log with Areca DAS already connected:

BootROM - 1.73

Booting from NAND flash


General initialization - Version: 1.0.0

Detected Device ID 6820

High speed PHY - Version: 2.0


Init RD NAS topology Serdes Lane 3 is USB3

Serdes Lane 4 is SGMII

board SerDes lanes topology details:

 | Lane #  | Speed |  Type       |

 --------------------------------

 |   0    |  06   |  SATA0	|

 |   1    |  05   |  PCIe0	|

 |   2    |  06   |  SATA1	|

 |   3    |  05   |  USB3 HOST1	|

 |   4    |  05   |  PCIe1	|

 |   5    |  00   |  SGMII2	|

 --------------------------------

:** Link is Gen1, check the EP capability=20

PCIe,=20Idx 0: Link upgraded to Gen2 based on client cpabilities=20

:**=20Link is Gen1, check the EP capability=20

PCIe,=20Idx 1: remains Gen1

High speed PHY - Ended Successfully

DDR3 Training Sequence - Ver TIP-1.26.0

mvSysEnvGetTopologyUpdateInfo: TWSI Read failed

DDR3 Training Sequence - Switching XBAR Window to FastPath Window=20

DDR3=20Training Sequence - Ended Successfully

Not detected suspend to RAM indication

BootROM: Image checksum verification PASSED

l
 __   __                      _ _
|  \/  | __ _ _ ____   _____| | |
| |\/| |/ _` | '__\ \ / / _ \ | |
| |  | | (_| | |   \ V /  __/ | |
|_|  |_|\__,_|_|    \_/ \___|_|_|
         _   _     ____              _
        | | | |   | __ )  ___   ___ | |_=20
=20       | | | |___|  _ \ / _ \ / _ \| __|=20
=20       | |_| |___| |_) | (_) | (_) | |_=20
=20        \___/    |____/ \___/ \___/ \__|=20
=20** LOADER **


U-Boot 2013.01 (Mar 27 2015 - 16:50:46) Marvell version: 2014_T3.0p6

Boot version : v1.0.13

Board: RD-NAS-88F6820-DDR3
SoC:   MV88F6820 Rev A0
       running 2 CPUs
CPU:   ARM Cortex A9 MPCore (Rev 1) LE
       CPU 0
       CPU    @ 1600 [MHz]
       L2     @ 800 [MHz]
       TClock @ 200 [MHz]
       DDR    @ 800 [MHz]
       DDR 32 Bit Width, FastPath Memory Access, DLB Enabled, ECC Disable=
d
DRAM:  512 MiB

Map:   Code:			0x1fea9000:0x1ff7632c
       BSS:			0x1ffef6b4
       Stack:			0x1f9a8f20
       Heap:			0x1f9a9000:0x1fea9000
raise: Signal # 8 caught
U-ENV offset =3D=3D 0x200000
raise: Signal # 8 caught
U-ENV offset =3D=3D 0x200000
       U-Boot Environment:	0x00200000:0x00220000 (NAND)

NAND:  128 MiB
MMC:   mv_sdh: 0
DEVINFO offset =3D=3D 0x900000
U-ENV offset =3D=3D 0x200000
U-ENV offset =3D=3D 0x200000
S-ENV offset =3D=3D 0x240000


#### auto_recovery ####
[u_env] get auto_recovery =3D=3D yes
[u_env] get auto_recovery =3D=3D yes
[u_env] get boot_part =3D=3D 2
[u_env] get boot_part_ready =3D=3D 3
auto_recovery enabled:1, boot_part:2, boot_part_ready:3=20

S-ENV=20offset =3D=3D 0x240000
[boot_count_read] block:0x240000, size:128KB, records:64=20
[boot_count_read_record]=20boot_count:1, next_record:11

[boot_count_write] erase:0, auto_recovery->block_offset:0x240000 offset=
=3D0x245800

Updating boot_count ...=20
[boot_count_write]=20offset:0x245800 , length:2048
done

PCI-e 0 (IF 0 - bus 0) Root Complex Interface, Detected Link X1, GEN 2.0
PCI-e 1 (IF 1 - bus 1) Root Complex Interface, Detected Link X1, GEN 1.1
USB2.0 0: Host Mode
USB3.0 1: Host Mode
USB3.0 0: Host Mode
Board configuration detected:
mvEthE6171SwitchBasicInit init=20
Net:=20=20=20
|=20 port  | Interface | PHY address  |
|--------|-----------|--------------|
| egiga0 |   RGMII   |     0x01     |
| egiga1 |   SGMII   |     0x00     |
egiga0 [PRIME], egiga1
auto_recovery_check changes bootcmd: run altnandboot=20
Hit=20any key to stop autoboot:  3
Marvell>> run bootcmd_tftp
Using egiga0 device
TFTP from server 192.168.1.254; our IP address is 192.168.1.1
Filename 'uImage'.
Load address: 0x2000000
Loading: * ##############################################################=
###
	 #################################################################
	 ##########################################################
	 205.1 KiB/s
done
Bytes transferred =3D 2750299 (29f75b hex)

Starting kernel ...

[    0.000000][    T0] Booting Linux on physical CPU 0x0
[    0.000000][    T0] Linux version 6.2.0-rc6-M95D-00001-gd783bde80fb1 (=
marius95@GRAPHIM) (arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GCC 12.2.0 =
r21391+9-a8f3c97ce8) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP Mon Jan 3=
0 09:02:19 EET 2023
[    0.000000][    T0] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7)=
, cr=3D10c5387d
[    0.000000][    T0] CPU: PIPT / VIPT nonaliasing data cache, VIPT alia=
sing instruction cache
[    0.000000][    T0] OF: fdt: Machine model: Linksys WRT1900ACS
[    0.000000][    T0] Memory policy: Data cache writealloc
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   Normal   [mem 0x0000000000000000-0x000000001ffff=
fff]
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
[    0.000000][    T0]   node   0: [mem 0x0000000000000000-0x000000001fff=
ffff]
[    0.000000][    T0] Initmem setup node 0 [mem 0x0000000000000000-0x000=
000001fffffff]
[    0.000000][    T0] percpu: Embedded 13 pages/cpu s29648 r0 d23600 u53=
248
[    0.000000][    T0] pcpu-alloc: s29648 r0 d23600 u53248 alloc=3D13*409=
6
[    0.000000][    T0] pcpu-alloc: [0] 0 [0] 1=20
[=20   0.000000][    T0] Built 1 zonelists, mobility grouping on.  Total =
pages: 130048
[    0.000000][    T0] Kernel command line:  console=3DttyS0,115200 nfcCo=
nfig=3D4bitecc mtdparts=3Darmada-nand:2048K(uboot)ro,256K(u_env),256K(s_e=
nv),1m@9m(devinfo),40m@10m(kernel),34m@16m(rootfs),40m@50m(alt_kernel),34=
m@56m(alt_rootfs),80m@10m(ubifs),-@90m(syscfg) root=3D/dev/sda rootdelay=
=3D100  dyndbg=3D\"file *ata* +plmft\"
[    0.000000][    T0] Unknown kernel command line parameters "nfcConfig=
=3D4bitecc mtdparts=3Darmada-nand:2048K(uboot)ro,256K(u_env),256K(s_env),=
1m@9m(devinfo),40m@10m(kernel),34m@16m(rootfs),40m@50m(alt_kernel),34m@56=
m(alt_rootfs),80m@10m(ubifs),-@90m(syscfg)", will be passed to user space=
.
[    0.000000][    T0] Dentry cache hash table entries: 65536 (order: 6, =
262144 bytes, linear)
[    0.000000][    T0] Inode-cache hash table entries: 32768 (order: 5, 1=
31072 bytes, linear)
[    0.000000][    T0] mem auto-init: stack:off, heap alloc:off, heap fre=
e:off
[    0.000000][    T0] Memory: 503304K/524288K available (6144K kernel co=
de, 682K rwdata, 1724K rodata, 1024K init, 6363K bss, 20984K reserved, 0K=
 cma-reserved)
[    0.000000][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, C=
PUs=3D2, Nodes=3D1
[    0.000000][    T0] trace event string verifier disabled
[    0.000000][    T0] Running RCU self tests
[    0.000000][    T0] rcu: Hierarchical RCU implementation.
[    0.000000][    T0] rcu: 	RCU lockdep checking is enabled.
[    0.000000][    T0] rcu: RCU calculated value of scheduler-enlistment =
delay is 10 jiffies.
[    0.000000][    T0] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000][    T0] L2C: DT/platform modifies aux control register: 0x=
06070000 -> 0x16070000
[    0.000000][    T0] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000][    T0] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000][    T0] L2C-310 D prefetch enabled, offset 1 lines
[    0.000000][    T0] L2C-310 dynamic clock gating enabled, standby mode=
 enabled
[    0.000000][    T0] L2C-310 Coherent cache controller enabled, 16 ways=
, 1024 kB
[    0.000000][    T0] L2C-310 Coherent: CACHE_ID 0x410054c9, AUX_CTRL 0x=
56070001
[    0.000000][    T0] rcu: srcu_init: Setting srcu_struct sizes based on=
 contention.
[    0.000001][    T0] sched_clock: 64 bits at 800MHz, resolution 1ns, wr=
aps every 4398046511103ns
[    0.000013][    T0] clocksource: arm_global_timer: mask: 0xfffffffffff=
fffff max_cycles: 0xb881274fa3, max_idle_ns: 440795210636 ns
[    0.000091][    T0] Switching to timer-based delay loop, resolution 1n=
s
[    0.000336][    T0] Ignoring duplicate/late registration of read_curre=
nt_timer delay
[    0.000342][    T0] clocksource: armada_370_xp_clocksource: mask: 0xff=
ffffff max_cycles: 0xffffffff, max_idle_ns: 76450417870 ns
[    0.000671][    T0] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
[    0.000686][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000691][    T0] ... MAX_LOCK_DEPTH:          48
[    0.000696][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    0.000700][    T0] ... CLASSHASH_SIZE:          4096
[    0.000703][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000707][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000711][    T0] ... CHAINHASH_SIZE:          32768
[    0.000715][    T0]  memory used by lock dependency info: 4061 kB
[    0.000720][    T0]  memory used for stack traces: 2112 kB
[    0.000724][    T0]  per task-struct memory footprint: 1536 bytes
[    0.000773][    T0] Calibrating delay loop (skipped), value calculated=
 using timer frequency.. 1600.00 BogoMIPS (lpj=3D8000000)
[    0.000787][    T0] pid_max: default: 32768 minimum: 301
[    0.000886][    T0] Mount-cache hash table entries: 1024 (order: 0, 40=
96 bytes, linear)
[    0.000895][    T0] Mountpoint-cache hash table entries: 1024 (order: =
0, 4096 bytes, linear)
[    0.002105][    T0] CPU: Testing write buffer coherency: ok
[    0.002168][    T0] Spectre V2: workarounds disabled by configuration
[    0.003606][    T1] Setting up static identity map for 0x100000 - 0x10=
0060
[    0.003756][    T1] mvebu-soc-id: MVEBU SoC ID=3D0x6820, Rev=3D0x4
[    0.003891][    T1] mvebu-pmsu: Initializing Power Management Service =
Unit
[    0.004190][    T1] rcu: Hierarchical SRCU implementation.
[    0.004196][    T1] rcu: 	Max phase no-delay instances is 1000.
[    0.004870][    T1] dyndbg: unknown flag '\'
[    0.004877][    T1] dyndbg: flags parse failed
[    0.005143][    T1] smp: Bringing up secondary CPUs ...
[    0.006060][    T1] Booting CPU 1
[    0.006572][    T1] smp: Brought up 1 node, 2 CPUs
[    0.006581][    T1] SMP: Total of 2 processors activated (3200.00 Bogo=
MIPS).
[    0.006589][    T1] CPU: All CPU(s) started in SVC mode.
[    0.007669][    T1] devtmpfs: initialized
[    0.016228][    T1] device: 'platform': device_add
[    0.016350][    T1] bus: 'platform': registered
[    0.016402][    T1] bus: 'cpu': registered
[    0.016418][    T1] device: 'cpu': device_add
[    0.016577][    T1] bus: 'container': registered
[    0.016586][    T1] device: 'container': device_add
[    0.017162][    T1] VFP support v0.3: implementor 41 architecture 3 pa=
rt 30 variant 9 rev 4
[    0.017308][    T1] bus: 'workqueue': registered
[    0.017318][    T1] device: 'workqueue': device_add
[    0.017863][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017890][    T1] futex hash table entries: 512 (order: 3, 32768 byt=
es, linear)
[    0.018045][    T1] pinctrl core: initialized pinctrl subsystem
[    0.018482][    T1] bus: 'gpio': registered
[    0.018491][    T1] bus: 'gpio': add driver gpio_stub_drv
[    0.018582][    T1] device class 'regulator': registering
[    0.018665][    T1] Registering platform device 'reg-dummy'. Parent at=
 platform
[    0.018674][    T1] device: 'reg-dummy': device_add
[    0.018694][    T1] bus: 'platform': add device reg-dummy
[    0.018798][    T1] bus: 'platform': add driver reg-dummy
[    0.018817][    T1] bus: 'platform': __driver_probe_device: matched de=
vice reg-dummy with driver reg-dummy
[    0.018875][    T1] bus: 'platform': really_probe: probing driver reg-=
dummy with device reg-dummy
[    0.018957][    T1] reg-dummy reg-dummy: no default pinctrl state
[    0.019076][    T1] regulator-dummy: no parameters, enabled
[    0.019088][    T1] device: 'regulator.0': device_add
[    0.019451][    T1] driver: 'reg-dummy': driver_bound: bound to device=
 'reg-dummy'
[    0.019504][    T1] bus: 'platform': really_probe: bound device reg-du=
mmy to driver reg-dummy
[    0.019630][    T1] bus: 'soc': registered
[    0.020109][    T1] DMA: preallocated 256 KiB pool for atomic coherent=
 allocations
[    0.020145][    T1] device: 'soc0': device_add
[    0.020215][    T1] bus: 'soc': add device soc0
[    0.021619][    T1] device class 'bdi': registering
[    0.021727][    T1] device class 'gpio': registering
[    0.021779][    T1] device class 'pci_bus': registering
[    0.021860][    T1] bus: 'pci': registered
[    0.021909][    T1] bus: 'pci_express': registered
[    0.021917][    T1] device class 'tty': registering
[    0.021941][    T1] device class 'devlink': registering
[    0.022046][    T1] bus: 'platform': add driver sram
[    0.022135][    T1] bus: 'spi': registered
[    0.022141][    T1] device class 'spi_master': registering
[    0.022231][    T1] bus: 'i2c': registered
[    0.022238][    T1] bus: 'i2c': add driver dummy
[    0.022359][    T1] thermal_sys: Registered thermal governor 'step_wis=
e'
[    0.022365][    T1] device class 'thermal': registering
[    0.022520][    T1] hw-breakpoint: found 5 (+1 reserved) breakpoint an=
d 1 watchpoint registers.
[    0.022529][    T1] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.022652][    T1] mvebu-pmsu: CPU hotplug support is currently broke=
n on Armada 38x: disabling
[    0.022663][    T1] mvebu-pmsu: CPU idle is currently broken on Armada=
 38x: disabling
[    0.022722][    T1] device class 'dma': registering
[    0.022894][    T1] bus: 'platform': add driver mvebu-uart-clock
[    0.022942][    T1] bus: 'platform': add driver mvebu-uart
[    0.023168][    T1] device: 'pmu': device_add
[    0.023201][    T1] bus: 'platform': add device pmu
[    0.023374][    T1] device: 'soc': device_add
[    0.023405][    T1] bus: 'platform': add device soc
[    0.023761][    T1] i2c@11000 Linked as a fwnode consumer to pinctrl@1=
8000
[    0.026641][    T1] device: 'fff00000.bootrom': device_add
[    0.026675][    T1] bus: 'platform': add device fff00000.bootrom
[    0.026806][    T1] device: 'soc:internal-regs': device_add
[    0.026845][    T1] bus: 'platform': add device soc:internal-regs
[    0.027715][    T1] device: 'f1001400.sdramc': device_add
[    0.027746][    T1] bus: 'platform': add device f1001400.sdramc
[    0.027960][    T1] device: 'f1008000.cache-controller': device_add
[    0.027990][    T1] bus: 'platform': add device f1008000.cache-control=
ler
[    0.028197][    T1] device: 'f100c000.scu': device_add
[    0.028226][    T1] bus: 'platform': add device f100c000.scu
[    0.028427][    T1] device: 'f100c200.timer': device_add
[    0.028457][    T1] bus: 'platform': add device f100c200.timer
[    0.028658][    T1] device: 'f100c600.timer': device_add
[    0.028693][    T1] bus: 'platform': add device f100c600.timer
[    0.028902][    T1] device: 'f1011000.i2c': device_add
[    0.028932][    T1] bus: 'platform': add device f1011000.i2c
[    0.029230][    T1] device: 'f1012000.serial': device_add
[    0.029260][    T1] bus: 'platform': add device f1012000.serial
[    0.029472][    T1] device: 'f1018000.pinctrl': device_add
[    0.029501][    T1] bus: 'platform': add device f1018000.pinctrl
[    0.029665][    T1] device: 'platform:f1018000.pinctrl--platform:f1011=
000.i2c': device_add
[    0.029921][    T1] devices_kset: Moving f1011000.i2c to end of list
[    0.029933][    T1] platform f1011000.i2c: Linked as a consumer to f10=
18000.pinctrl
[    0.029941][    T1] i2c@11000 Dropping the fwnode link to pinctrl@1800=
0
[    0.030283][    T1] device: 'f1018100.gpio': device_add
[    0.030315][    T1] bus: 'platform': add device f1018100.gpio
[    0.030598][    T1] device: 'f1018140.gpio': device_add
[    0.030628][    T1] bus: 'platform': add device f1018140.gpio
[    0.030835][    T1] device: 'f1018200.system-controller': device_add
[    0.030865][    T1] bus: 'platform': add device f1018200.system-contro=
ller
[    0.031148][    T1] device: 'f1018300.phy': device_add
[    0.031189][    T1] bus: 'platform': add device f1018300.phy
[    0.031579][    T1] device: 'f1020000.mbus-controller': device_add
[    0.031615][    T1] bus: 'platform': add device f1020000.mbus-controll=
er
[    0.031896][    T1] device: 'f1020300.timer': device_add
[    0.031926][    T1] bus: 'platform': add device f1020300.timer
[    0.032273][    T1] device: 'f1020300.watchdog': device_add
[    0.032303][    T1] bus: 'platform': add device f1020300.watchdog
[    0.032510][    T1] device: 'f1020800.cpurst': device_add
[    0.032539][    T1] bus: 'platform': add device f1020800.cpurst
[    0.032752][    T1] device: 'f1020d20.mpcore-soc-ctrl': device_add
[    0.032783][    T1] bus: 'platform': add device f1020d20.mpcore-soc-ct=
rl
[    0.032998][    T1] device: 'f1021010.coherency-fabric': device_add
[    0.033034][    T1] bus: 'platform': add device f1021010.coherency-fab=
ric
[    0.033237][    T1] device: 'f1022000.pmsu': device_add
[    0.033266][    T1] bus: 'platform': add device f1022000.pmsu
[    0.033470][    T1] device: 'f1070000.ethernet': device_add
[    0.033500][    T1] bus: 'platform': add device f1070000.ethernet
[    0.033715][    T1] device: 'f1034000.ethernet': device_add
[    0.033744][    T1] bus: 'platform': add device f1034000.ethernet
[    0.033953][    T1] device: 'f1058000.usb': device_add
[    0.033983][    T1] bus: 'platform': add device f1058000.usb
[    0.034255][    T1] device: 'f1060800.xor': device_add
[    0.034291][    T1] bus: 'platform': add device f1060800.xor
[    0.034580][    T1] device: 'f1060900.xor': device_add
[    0.034610][    T1] bus: 'platform': add device f1060900.xor
[    0.034827][    T1] device: 'f1072004.mdio': device_add
[    0.034856][    T1] bus: 'platform': add device f1072004.mdio
[    0.035117][    T1] device: 'f1090000.crypto': device_add
[    0.035146][    T1] bus: 'platform': add device f1090000.crypto
[    0.035353][    T1] device: 'f10a8000.sata': device_add
[    0.035382][    T1] bus: 'platform': add device f10a8000.sata
[    0.035584][    T1] device: 'f10c8000.bm': device_add
[    0.035620][    T1] bus: 'platform': add device f10c8000.bm
[    0.035904][    T1] device: 'f10e4078.thermal': device_add
[    0.035934][    T1] bus: 'platform': add device f10e4078.thermal
[    0.036136][    T1] device: 'f10d0000.nand-controller': device_add
[    0.036166][    T1] bus: 'platform': add device f10d0000.nand-controll=
er
[    0.036534][    T1] device: 'f10f8000.usb3': device_add
[    0.036564][    T1] bus: 'platform': add device f10f8000.usb3
[    0.036741][    T1] device: 'f1100000.sa-sram0': device_add
[    0.036771][    T1] bus: 'platform': add device f1100000.sa-sram0
[    0.036847][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1100000.sa-sram0 with driver sram
[    0.036859][    T1] bus: 'platform': really_probe: probing driver sram=
 with device f1100000.sa-sram0
[    0.036879][    T1] sram f1100000.sa-sram0: no pinctrl handle
[    0.037062][    T1] driver: 'sram': driver_bound: bound to device 'f11=
00000.sa-sram0'
[    0.037141][    T1] bus: 'platform': really_probe: bound device f11000=
00.sa-sram0 to driver sram
[    0.037259][    T1] device: 'f1110000.sa-sram1': device_add
[    0.037292][    T1] bus: 'platform': add device f1110000.sa-sram1
[    0.037359][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1110000.sa-sram1 with driver sram
[    0.037369][    T1] bus: 'platform': really_probe: probing driver sram=
 with device f1110000.sa-sram1
[    0.037387][    T1] sram f1110000.sa-sram1: no pinctrl handle
[    0.037492][    T1] driver: 'sram': driver_bound: bound to device 'f11=
10000.sa-sram1'
[    0.037541][    T1] bus: 'platform': really_probe: bound device f11100=
00.sa-sram1 to driver sram
[    0.037662][    T1] device: 'f1200000.bm-bppi': device_add
[    0.037693][    T1] bus: 'platform': add device f1200000.bm-bppi
[    0.037759][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1200000.bm-bppi with driver sram
[    0.037769][    T1] bus: 'platform': really_probe: probing driver sram=
 with device f1200000.bm-bppi
[    0.037787][    T1] sram f1200000.bm-bppi: no pinctrl handle
[    0.037897][    T1] driver: 'sram': driver_bound: bound to device 'f12=
00000.bm-bppi'
[    0.037946][    T1] bus: 'platform': really_probe: bound device f12000=
00.bm-bppi to driver sram
[    0.038019][    T1] device: 'soc:pcie': device_add
[    0.038051][    T1] bus: 'platform': add device soc:pcie
[    0.038193][    T1] device: 'usb3_1-phy': device_add
[    0.038223][    T1] bus: 'platform': add device usb3_1-phy
[    0.038291][    T1] usb3_1-phy Linked as a fwnode consumer to usb3_1-v=
bus
[    0.038356][    T1] device: 'usb3_1-vbus': device_add
[    0.038396][    T1] bus: 'platform': add device usb3_1-vbus
[    0.038468][    T1] usb3_1-vbus Linked as a fwnode consumer to pinctrl=
@18000
[    0.038499][    T1] usb3_1-vbus Linked as a fwnode consumer to gpio@18=
140
[    0.038525][    T1] device: 'platform:usb3_1-vbus--platform:usb3_1-phy=
': device_add
[    0.038633][    T1] devices_kset: Moving usb3_1-phy to end of list
[    0.038643][    T1] platform usb3_1-phy: Linked as a consumer to usb3_=
1-vbus
[    0.038651][    T1] usb3_1-phy Dropping the fwnode link to usb3_1-vbus
[    0.038669][    T1] device: 'platform:f1018140.gpio--platform:usb3_1-v=
bus': device_add
[    0.038771][    T1] devices_kset: Moving usb3_1-vbus to end of list
[    0.038780][    T1] devices_kset: Moving usb3_1-phy to end of list
[    0.038789][    T1] platform usb3_1-vbus: Linked as a consumer to f101=
8140.gpio
[    0.038796][    T1] usb3_1-vbus Dropping the fwnode link to gpio@18140
[    0.038815][    T1] device: 'platform:f1018000.pinctrl--platform:usb3_=
1-vbus': device_add
[    0.038924][    T1] devices_kset: Moving usb3_1-vbus to end of list
[    0.038933][    T1] devices_kset: Moving usb3_1-phy to end of list
[    0.038942][    T1] platform usb3_1-vbus: Linked as a consumer to f101=
8000.pinctrl
[    0.038949][    T1] usb3_1-vbus Dropping the fwnode link to pinctrl@18=
000
[    0.039075][    T1] device: 'gpio-keys': device_add
[    0.039105][    T1] bus: 'platform': add device gpio-keys
[    0.039175][    T1] gpio-keys Linked as a fwnode consumer to pinctrl@1=
8000
[    0.039208][    T1] button-wps Linked as a fwnode consumer to gpio@181=
00
[    0.039240][    T1] button-reset Linked as a fwnode consumer to gpio@1=
8100
[    0.039265][    T1] device: 'platform:f1018000.pinctrl--platform:gpio-=
keys': device_add
[    0.039392][    T1] devices_kset: Moving gpio-keys to end of list
[    0.039403][    T1] platform gpio-keys: Linked as a consumer to f10180=
00.pinctrl
[    0.039410][    T1] gpio-keys Dropping the fwnode link to pinctrl@1800=
0
[    0.039504][    T1] device: 'platform:f1018100.gpio--platform:gpio-key=
s': device_add
[    0.039608][    T1] platform gpio-keys: Linked as a sync state only co=
nsumer to f1018100.gpio
[    0.039663][    T1] device: 'gpio-leds': device_add
[    0.039692][    T1] bus: 'platform': add device gpio-leds
[    0.039769][    T1] gpio-leds Linked as a fwnode consumer to pinctrl@1=
8000
[    0.039799][    T1] led-power Linked as a fwnode consumer to gpio@1814=
0
[    0.039831][    T1] led-sata Linked as a fwnode consumer to gpio@18140
[    0.039859][    T1] device: 'platform:f1018000.pinctrl--platform:gpio-=
leds': device_add
[    0.039963][    T1] devices_kset: Moving gpio-leds to end of list
[    0.039973][    T1] platform gpio-leds: Linked as a consumer to f10180=
00.pinctrl
[    0.039981][    T1] gpio-leds Dropping the fwnode link to pinctrl@1800=
0
[    0.040073][    T1] device: 'platform:f1018140.gpio--platform:gpio-led=
s': device_add
[    0.040218][    T1] platform gpio-leds: Linked as a sync state only co=
nsumer to f1018140.gpio
[    0.040293][    T1] device: 'cpu0': device_add
[    0.040320][    T1] bus: 'cpu': add device cpu0
[    0.040416][    T1] device: 'cpu1': device_add
[    0.040443][    T1] bus: 'cpu': add device cpu1
[    0.041005][    T1] device: 'writeback': device_add
[    0.041037][    T1] bus: 'workqueue': add device writeback
[    0.041548][    T1] device class 'block': registering
[    0.041952][    T1] bus: 'platform': add driver reg-fixed-voltage
[    0.042094][    T1] bus: 'platform': __driver_probe_device: matched de=
vice usb3_1-vbus with driver reg-fixed-voltage
[    0.042155][    T1] platform usb3_1-vbus: error -EPROBE_DEFER: supplie=
r f1018140.gpio not ready
[    0.042169][    T1] platform usb3_1-vbus: Added to deferred list
[    0.042234][    T1] device class 'misc': registering
[    0.042472][    T1] device class 'scsi_host': registering
[    0.042554][    T1] bus: 'scsi': registered
[    0.042560][    T1] device class 'scsi_device': registering
[    0.042583][    T1] SCSI subsystem initialized
[    0.042591][    T1] device class 'ata_link': registering
[    0.042614][    T1] device class 'ata_port': registering
[    0.042635][    T1] device class 'ata_device': registering
[    0.042694][    T1] libata version 3.00 loaded.
[    0.042839][    T1] bus: 'usb': registered
[    0.042855][    T1] bus: 'usb': add driver usbfs
[    0.042912][    T1] usbcore: registered new interface driver usbfs
[    0.042949][    T1] bus: 'usb': add driver hub
[    0.043000][    T1] usbcore: registered new interface driver hub
[    0.043029][    T1] bus: 'usb': add driver usb
[    0.043068][    T1] usbcore: registered new device driver usb
[    0.043078][    T1] bus: 'platform': add driver usb_phy_generic
[    0.043192][    T1] bus: 'platform': __driver_probe_device: matched de=
vice usb3_1-phy with driver usb_phy_generic
[    0.043208][    T1] platform usb3_1-phy: error -EPROBE_DEFER: supplier=
 usb3_1-vbus not ready
[    0.043218][    T1] platform usb3_1-phy: Added to deferred list
[    0.043262][    T1] device class 'input': registering
[    0.043304][    T1] device class 'hwmon': registering
[    0.043330][    T1] device class 'leds': registering
[    0.043586][    T1] device class 'watchdog': registering
[    0.053511][    T1] clocksource: Switched to clocksource arm_global_ti=
mer
[    0.054823][    T1] device class 'mem': registering
[    0.054860][    T1] device: 'null': device_add
[    0.055308][    T1] device: 'zero': device_add
[    0.055451][    T1] device: 'full': device_add
[    0.055585][    T1] device: 'random': device_add
[    0.055726][    T1] device: 'urandom': device_add
[    0.055857][    T1] device: 'kmsg': device_add
[    0.056022][    T1] device: 'tty': device_add
[    0.056208][    T1] device: 'console': device_add
[    0.056385][    T1] PCI: CLS 0 bytes, default 64
[    0.056659][    T1] bus: 'platform': add driver armv7-pmu
[    0.056689][    T1] bus: 'platform': __driver_probe_device: matched de=
vice pmu with driver armv7-pmu
[    0.056701][    T1] bus: 'platform': really_probe: probing driver armv=
7-pmu with device pmu
[    0.056723][    T1] armv7-pmu pmu: no pinctrl handle
[    0.128996][    T1] hw perfevents: enabled with armv7_cortex_a9 PMU dr=
iver, 7 counters available
[    0.129014][    T1] driver: 'armv7-pmu': driver_bound: bound to device=
 'pmu'
[    0.129105][    T1] bus: 'platform': really_probe: bound device pmu to=
 driver armv7-pmu
[    0.129535][    T1] bus: 'clocksource': registered
[    0.129551][    T1] device: 'clocksource': device_add
[    0.129576][    T1] device: 'clocksource0': device_add
[    0.129610][    T1] bus: 'clocksource': add device clocksource0
[    0.129710][    T1] bus: 'platform': add driver alarmtimer
[    0.129908][    T1] bus: 'clockevents': registered
[    0.129926][    T1] device: 'clockevents': device_add
[    0.129949][    T1] device: 'clockevent0': device_add
[    0.129968][    T1] bus: 'clockevents': add device clockevent0
[    0.130054][    T1] device: 'clockevent1': device_add
[    0.130078][    T1] bus: 'clockevents': add device clockevent1
[    0.130136][    T1] device: 'broadcast': device_add
[    0.130153][    T1] bus: 'clockevents': add device broadcast
[    0.130374][    T1] bus: 'event_source': registered
[    0.130397][    T1] device: 'software': device_add
[    0.130417][    T1] bus: 'event_source': add device software
[    0.130528][    T1] device: 'tracepoint': device_add
[    0.130550][    T1] bus: 'event_source': add device tracepoint
[    0.130604][    T1] device: 'breakpoint': device_add
[    0.130623][    T1] bus: 'event_source': add device breakpoint
[    0.130675][    T1] device: 'armv7_cortex_a9': device_add
[    0.130833][    T1] bus: 'event_source': add device armv7_cortex_a9
[    0.131094][    T1] workingset: timestamp_bits=3D30 max_order=3D17 buc=
ket_order=3D0
[    0.131792][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.178248][    T1] device class 'bsg': registering
[    0.178294][    T1] Block layer SCSI generic (bsg) driver version 0.4 =
loaded (major 251)
[    0.178445][    T1] bus: 'platform': add driver simple-pm-bus
[    0.178478][    T1] bus: 'platform': __driver_probe_device: matched de=
vice soc with driver simple-pm-bus
[    0.178491][    T1] bus: 'platform': really_probe: probing driver simp=
le-pm-bus with device soc
[    0.178514][    T1] simple-pm-bus soc: no pinctrl handle
[    0.178567][    T1] simple-pm-bus: probe of soc rejects match -19
[    0.178598][    T1] bus: 'platform': __driver_probe_device: matched de=
vice soc:internal-regs with driver simple-pm-bus
[    0.178609][    T1] bus: 'platform': really_probe: probing driver simp=
le-pm-bus with device soc:internal-regs
[    0.178627][    T1] simple-pm-bus soc:internal-regs: no pinctrl handle
[    0.178677][    T1] driver: 'simple-pm-bus': driver_bound: bound to de=
vice 'soc:internal-regs'
[    0.178857][    T1] bus: 'platform': really_probe: bound device soc:in=
ternal-regs to driver simple-pm-bus
[    0.179037][    T1] device class 'phy': registering
[    0.179073][    T1] bus: 'platform': add driver armada-38x-comphy
[    0.179137][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1018300.phy with driver armada-38x-comphy
[    0.179149][    T1] bus: 'platform': really_probe: probing driver arma=
da-38x-comphy with device f1018300.phy
[    0.179169][    T1] armada-38x-comphy f1018300.phy: no pinctrl handle
[    0.179321][    T1] phy phy-f1018300.phy.0: Looking up phy-supply from=
 device tree
[    0.179334][    T1] phy phy-f1018300.phy.0: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@0 failed
[    0.179376][    T1] device: 'phy-f1018300.phy.0': device_add
[    0.179545][    T1] phy phy-f1018300.phy.1: Looking up phy-supply from=
 device tree
[    0.179556][    T1] phy phy-f1018300.phy.1: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@1 failed
[    0.179595][    T1] device: 'phy-f1018300.phy.1': device_add
[    0.179700][    T1] phy phy-f1018300.phy.2: Looking up phy-supply from=
 device tree
[    0.179710][    T1] phy phy-f1018300.phy.2: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@2 failed
[    0.179748][    T1] device: 'phy-f1018300.phy.2': device_add
[    0.179847][    T1] phy phy-f1018300.phy.3: Looking up phy-supply from=
 device tree
[    0.179857][    T1] phy phy-f1018300.phy.3: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@3 failed
[    0.179895][    T1] device: 'phy-f1018300.phy.3': device_add
[    0.179995][    T1] phy phy-f1018300.phy.4: Looking up phy-supply from=
 device tree
[    0.180005][    T1] phy phy-f1018300.phy.4: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@4 failed
[    0.180043][    T1] device: 'phy-f1018300.phy.4': device_add
[    0.180140][    T1] phy phy-f1018300.phy.5: Looking up phy-supply from=
 device tree
[    0.180150][    T1] phy phy-f1018300.phy.5: Looking up phy-supply prop=
erty in node /soc/internal-regs/phy@18300/phy@5 failed
[    0.180188][    T1] device: 'phy-f1018300.phy.5': device_add
[    0.180324][    T1] driver: 'armada-38x-comphy': driver_bound: bound t=
o device 'f1018300.phy'
[    0.180421][    T1] bus: 'platform': really_probe: bound device f10183=
00.phy to driver armada-38x-comphy
[    0.180560][    T1] bus: 'platform': add driver armada-38x-pinctrl
[    0.180622][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1018000.pinctrl with driver armada-38x-pinctrl
[    0.180633][    T1] bus: 'platform': really_probe: probing driver arma=
da-38x-pinctrl with device f1018000.pinctrl
[    0.180659][    T1] armada-38x-pinctrl f1018000.pinctrl: no pinctrl ha=
ndle
[    0.181367][    T1] armada-38x-pinctrl f1018000.pinctrl: registered pi=
nctrl driver
[    0.181413][    T1] driver: 'armada-38x-pinctrl': driver_bound: bound =
to device 'f1018000.pinctrl'
[    0.181585][    T1] bus: 'platform': really_probe: bound device f10180=
00.pinctrl to driver armada-38x-pinctrl
[    0.181731][    T1] bus: 'platform': add driver mvebu-gpio
[    0.181797][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1018100.gpio with driver mvebu-gpio
[    0.181807][    T1] bus: 'platform': really_probe: probing driver mveb=
u-gpio with device f1018100.gpio
[    0.181827][    T1] mvebu-gpio f1018100.gpio: no pinctrl handle
[    0.182549][    T1] gpio gpiochip0: Static allocation of GPIO base is =
deprecated, use dynamic allocation.
[    0.182677][    T1] device: 'gpiochip0': device_add
[    0.182714][    T1] bus: 'gpio': add device gpiochip0
[    0.182971][    T1] device: 'gpiochip0': device_add
[    0.183402][    T1] driver: 'mvebu-gpio': driver_bound: bound to devic=
e 'f1018100.gpio'
[    0.183527][    T1] bus: 'platform': really_probe: bound device f10181=
00.gpio to driver mvebu-gpio
[    0.183547][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1018140.gpio with driver mvebu-gpio
[    0.183557][    T1] bus: 'platform': really_probe: probing driver mveb=
u-gpio with device f1018140.gpio
[    0.183587][    T1] mvebu-gpio f1018140.gpio: no pinctrl handle
[    0.184246][    T1] gpio gpiochip1: Static allocation of GPIO base is =
deprecated, use dynamic allocation.
[    0.184318][    T1] device: 'gpiochip1': device_add
[    0.184353][    T1] bus: 'gpio': add device gpiochip1
[    0.184533][    T1] device: 'gpiochip32': device_add
[    0.184805][    T1] driver: 'mvebu-gpio': driver_bound: bound to devic=
e 'f1018140.gpio'
[    0.184873][    T1] bus: 'platform': really_probe: bound device f10181=
40.gpio to driver mvebu-gpio
[    0.185035][    T1] bus: 'pci': add driver pcieport
[    0.185124][    T1] bus: 'platform': add driver mvebu-pcie
[    0.185282][    T1] bus: 'platform': __driver_probe_device: matched de=
vice soc:pcie with driver mvebu-pcie
[    0.185294][    T1] bus: 'platform': really_probe: probing driver mveb=
u-pcie with device soc:pcie
[    0.185314][    T1] mvebu-pcie soc:pcie: no pinctrl handle
[    0.185371][    T1] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    0.185443][    T1] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1=
081fff -> 0x0000080000
[    0.185495][    T1] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1=
041fff -> 0x0000040000
[    0.185545][    T1] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1=
045fff -> 0x0000044000
[    0.185594][    T1] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1=
049fff -> 0x0000048000
[    0.185641][    T1] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..=
0x00fffffffe -> 0x0100000000
[    0.185686][    T1] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..=
0x00fffffffe -> 0x0100000000
[    0.185730][    T1] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..=
0x00fffffffe -> 0x0200000000
[    0.185774][    T1] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..=
0x00fffffffe -> 0x0200000000
[    0.185818][    T1] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..=
0x00fffffffe -> 0x0300000000
[    0.185861][    T1] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..=
0x00fffffffe -> 0x0300000000
[    0.185905][    T1] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..=
0x00fffffffe -> 0x0400000000
[    0.185931][    T1] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..=
0x00fffffffe -> 0x0400000000
[    0.186664][    T1] device: 'pci0000:00': device_add
[    0.186705][    T1] device: '0000:00': device_add
[    0.186874][    T1] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:0=
0
[    0.186886][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.186897][    T1] pci_bus 0000:00: root bus resource [mem 0xf1080000=
-0xf1081fff] (bus address [0x00080000-0x00081fff])
[    0.186907][    T1] pci_bus 0000:00: root bus resource [mem 0xf1040000=
-0xf1041fff] (bus address [0x00040000-0x00041fff])
[    0.186917][    T1] pci_bus 0000:00: root bus resource [mem 0xf1044000=
-0xf1045fff] (bus address [0x00044000-0x00045fff])
[    0.186926][    T1] pci_bus 0000:00: root bus resource [mem 0xf1048000=
-0xf1049fff] (bus address [0x00048000-0x00049fff])
[    0.186935][    T1] pci_bus 0000:00: root bus resource [mem 0xe0000000=
-0xe7ffffff]
[    0.186943][    T1] pci_bus 0000:00: root bus resource [io  0x1000-0xe=
ffff]
[    0.187114][    T1] pci 0000:00:01.0: [11ab:6820] type 01 class 0x0604=
00
[    0.187276][    T1] device: '0000:00:01.0': device_add
[    0.187361][    T1] bus: 'pci': add device 0000:00:01.0
[    0.187656][    T1] pci 0000:00:02.0: [11ab:6820] type 01 class 0x0604=
00
[    0.187773][    T1] device: '0000:00:02.0': device_add
[    0.187855][    T1] bus: 'pci': add device 0000:00:02.0
[    0.188869][    T1] PCI: bus0: Fast back to back transfers disabled
[    0.188880][    T1] pci 0000:00:01.0: bridge configuration invalid ([b=
us 00-00]), reconfiguring
[    0.188898][    T1] pci 0000:00:02.0: bridge configuration invalid ([b=
us 00-00]), reconfiguring
[    0.188951][    T1] device: '0000:01': device_add
[    0.189126][    T1] pci 0000:01:00.0: [11ab:2a55] type 00 class 0x0200=
00
[    0.189164][    T1] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x400f=
ffff 64bit pref]
[    0.189191][    T1] pci 0000:01:00.0: reg 0x18: [mem 0x40100000-0x401f=
ffff 64bit pref]
[    0.189338][    T1] pci 0000:01:00.0: supports D1 D2
[    0.189346][    T1] pci 0000:01:00.0: PME# supported from D0 D1 D3hot =
D3cold
[    0.189456][    T1] device: '0000:01:00.0': device_add
[    0.189517][    T1] bus: 'pci': add device 0000:01:00.0
[    0.189743][    T1] PCI: bus1: Fast back to back transfers disabled
[    0.189753][    T1] pci_bus 0000:01: busn_res: [bus 01-ff] end is upda=
ted to 01
[    0.189806][    T1] device: '0000:02': device_add
[    0.189987][    T1] pci 0000:02:00.0: [11ab:2a55] type 00 class 0x0200=
00
[    0.190028][    T1] pci 0000:02:00.0: reg 0x10: [mem 0x42000000-0x420f=
ffff 64bit pref]
[    0.190056][    T1] pci 0000:02:00.0: reg 0x18: [mem 0x42100000-0x421f=
ffff 64bit pref]
[    0.190228][    T1] pci 0000:02:00.0: supports D1 D2
[    0.190236][    T1] pci 0000:02:00.0: PME# supported from D0 D1 D3hot =
D3cold
[    0.190281][    T1] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwi=
dth, limited by 2.5 GT/s PCIe x1 link at 0000:00:02.0 (capable of 4.000 G=
b/s with 5.0 GT/s PCIe x1 link)
[    0.190315][    T1] device: '0000:02:00.0': device_add
[    0.190368][    T1] bus: 'pci': add device 0000:02:00.0
[    0.190597][    T1] PCI: bus2: Fast back to back transfers disabled
[    0.190606][    T1] pci_bus 0000:02: busn_res: [bus 02-ff] end is upda=
ted to 02
[    0.190631][    T1] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-=
0xe01fffff]
[    0.190643][    T1] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-=
0xe03fffff]
[    0.190656][    T1] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-=
0xe00fffff 64bit pref]
[    0.190678][    T1] pci 0000:01:00.0: BAR 2: assigned [mem 0xe0100000-=
0xe01fffff 64bit pref]
[    0.190698][    T1] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.190710][    T1] pci 0000:00:01.0:   bridge window [mem 0xe0000000-=
0xe01fffff]
[    0.190733][    T1] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-=
0xe02fffff 64bit pref]
[    0.190755][    T1] pci 0000:02:00.0: BAR 2: assigned [mem 0xe0300000-=
0xe03fffff 64bit pref]
[    0.190775][    T1] pci 0000:00:02.0: PCI bridge to [bus 02]
[    0.190786][    T1] pci 0000:00:02.0:   bridge window [mem 0xe0200000-=
0xe03fffff]
[    0.190818][    T1] pci 0000:00:01.0: Max Payload Size set to  128/ 12=
8 (was  128), Max Read Rq  128
[    0.190861][    T1] pci 0000:01:00.0: Max Payload Size set to  128/ 25=
6 (was  128), Max Read Rq  128
[    0.190897][    T1] pci 0000:00:02.0: Max Payload Size set to  128/ 12=
8 (was  128), Max Read Rq  128
[    0.190929][    T1] pci 0000:02:00.0: Max Payload Size set to  128/ 25=
6 (was  128), Max Read Rq  128
[    0.191002][    T1] bus: 'pci': __driver_probe_device: matched device =
0000:00:01.0 with driver pcieport
[    0.191017][    T1] bus: 'pci': really_probe: probing driver pcieport =
with device 0000:00:01.0
[    0.191040][    T1] pcieport 0000:00:01.0: no pinctrl handle
[    0.191101][    T1] pcieport 0000:00:01.0: enabling device (0140 -> 01=
42)
[    0.191125][    T1] pcieport: probe of 0000:00:01.0 rejects match -19
[    0.191169][    T1] bus: 'pci': __driver_probe_device: matched device =
0000:00:02.0 with driver pcieport
[    0.191179][    T1] bus: 'pci': really_probe: probing driver pcieport =
with device 0000:00:02.0
[    0.191198][    T1] pcieport 0000:00:02.0: no pinctrl handle
[    0.191249][    T1] pcieport 0000:00:02.0: enabling device (0140 -> 01=
42)
[    0.191270][    T1] pcieport: probe of 0000:00:02.0 rejects match -19
[    0.191328][    T1] driver: 'mvebu-pcie': driver_bound: bound to devic=
e 'soc:pcie'
[    0.191397][    T1] bus: 'platform': really_probe: bound device soc:pc=
ie to driver mvebu-pcie
[    0.191463][    T1] bus: 'platform': add driver of_fixed_factor_clk
[    0.191639][    T1] bus: 'platform': add driver of_fixed_clk
[    0.191790][    T1] bus: 'platform': add driver gpio-clk
[    0.191946][    T1] bus: 'platform': add driver mv_xor
[    0.192046][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1060800.xor with driver mv_xor
[    0.192057][    T1] bus: 'platform': really_probe: probing driver mv_x=
or with device f1060800.xor
[    0.192076][    T1] mv_xor f1060800.xor: no pinctrl handle
[    0.192130][    T1] mv_xor f1060800.xor: Marvell shared XOR driver
[    0.255391][    T1] mv_xor f1060800.xor: Marvell XOR (Descriptor Mode)=
: ( xor cpy intr )
[    0.255500][    T1] device: 'dma0chan0': device_add
[    0.255731][    T1] driver: 'mv_xor': driver_bound: bound to device 'f=
1060800.xor'
[    0.255823][    T1] bus: 'platform': really_probe: bound device f10608=
00.xor to driver mv_xor
[    0.255842][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1060900.xor with driver mv_xor
[    0.255852][    T1] bus: 'platform': really_probe: probing driver mv_x=
or with device f1060900.xor
[    0.255873][    T1] mv_xor f1060900.xor: no pinctrl handle
[    0.255930][    T1] mv_xor f1060900.xor: Marvell shared XOR driver
[    0.315392][    T1] mv_xor f1060900.xor: Marvell XOR (Descriptor Mode)=
: ( xor cpy intr )
[    0.315435][    T1] device: 'dma1chan0': device_add
[    0.315623][    T1] driver: 'mv_xor': driver_bound: bound to device 'f=
1060900.xor'
[    0.315711][    T1] bus: 'platform': really_probe: bound device f10609=
00.xor to driver mv_xor
[    0.315850][    T1] device: 'ptmx': device_add
[    0.316039][    T1] Serial: 8250/16550 driver, 1 ports, IRQ sharing di=
sabled
[    0.316073][    T1] Registering platform device 'serial8250'. Parent a=
t platform
[    0.316082][    T1] device: 'serial8250': device_add
[    0.316104][    T1] bus: 'platform': add device serial8250
[    0.316309][    T1] device: 'ttyS0': device_add
[    0.316764][    T1] bus: 'platform': add driver serial8250
[    0.316845][    T1] bus: 'platform': __driver_probe_device: matched de=
vice serial8250 with driver serial8250
[    0.316857][    T1] bus: 'platform': really_probe: probing driver seri=
al8250 with device serial8250
[    0.316877][    T1] serial8250 serial8250: no default pinctrl state
[    0.316907][    T1] driver: 'serial8250': driver_bound: bound to devic=
e 'serial8250'
[    0.316942][    T1] bus: 'platform': really_probe: bound device serial=
8250 to driver serial8250
[    0.316990][    T1] bus: 'platform': add driver dw-apb-uart
[    0.317047][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1012000.serial with driver dw-apb-uart
[    0.317057][    T1] bus: 'platform': really_probe: probing driver dw-a=
pb-uart with device f1012000.serial
[    0.317083][    T1] dw-apb-uart f1012000.serial: no pinctrl handle
[    0.317441][    T1] device: 'ttyS0': device_unregister
[    0.318131][    T1] printk: console [ttyS0] disabled
[    0.338420][    T1] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq =3D=
 41, base_baud =3D 12500000) is a 16550A
[    0.338599][    T1] printk: console [ttyS0] enabled
[    3.904166][    T1] device: 'ttyS0': device_add
[    3.909336][    T1] driver: 'dw-apb-uart': driver_bound: bound to devi=
ce 'f1012000.serial'
[    3.917762][    T1] bus: 'platform': really_probe: bound device f10120=
00.serial to driver dw-apb-uart
[    3.927253][    T1] device: 'ttyprintk': device_add
[    3.932607][    T1] device: 'loop-control': device_add
[    3.938677][    T1] device: 'loop0': device_add
[    3.944055][    T1] device: '7:0': device_add
[    3.948749][    T1] loop: module loaded
[    3.952615][    T1] device class 'zram-control': registering
[    3.958591][    T1] device: 'zram0': device_add
[    3.963951][    T1] device: '254:0': device_add
[    3.968808][    T1] zram: Added device: zram0
[    3.973241][    T1] device class 'scsi_disk': registering
[    3.978745][    T1] bus: 'scsi': add driver sd
[    3.983265][    T1] bus: 'pci': add driver ahci
[    3.987932][    T1] bus: 'platform': add driver ahci-mvebu
[    3.993594][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f10a8000.sata with driver ahci-mvebu
[    4.003762][    T1] bus: 'platform': really_probe: probing driver ahci=
-mvebu with device f10a8000.sata
[    4.013131][    T1] ahci-mvebu f10a8000.sata: no pinctrl handle
[    4.019244][    T1] ahci-mvebu f10a8000.sata: Looking up ahci-supply f=
rom device tree
[    4.027143][    T1] ahci-mvebu f10a8000.sata: Looking up ahci-supply p=
roperty in node /soc/internal-regs/sata@a8000 failed
[    4.038288][    T1] ahci-mvebu f10a8000.sata: supply ahci not found, u=
sing dummy regulator
[    4.046754][    T1] device: 'regulator:regulator.0--platform:f10a8000.=
sata': device_add
[    4.055063][    T1] devices_kset: Moving f10a8000.sata to end of list
[    4.061545][    T1] ahci-mvebu f10a8000.sata: Linked as a consumer to =
regulator.0
[    4.069095][    T1] ahci-mvebu f10a8000.sata: Looking up phy-supply fr=
om device tree
[    4.076903][    T1] ahci-mvebu f10a8000.sata: Looking up phy-supply pr=
operty in node /soc/internal-regs/sata@a8000 failed
[    4.087957][    T1] ahci-mvebu f10a8000.sata: supply phy not found, us=
ing dummy regulator
[    4.096317][    T1] ahci-mvebu f10a8000.sata: Looking up target-supply=
 from device tree
[    4.104389][    T1] ahci-mvebu f10a8000.sata: Looking up target-supply=
 property in node /soc/internal-regs/sata@a8000 failed
[    4.115712][    T1] ahci-mvebu f10a8000.sata: supply target not found,=
 using dummy regulator
[    4.124640][    T1] ahci-mvebu f10a8000.sata: AHCI 0001.0000 32 slots =
2 ports 6 Gbps 0x3 impl platform mode
[    4.134463][    T1] ahci-mvebu f10a8000.sata: flags: 64bit ncq sntf le=
d only pmp fbs pio slum part sxs=20
[=20   4.144166][    T1] device: 'ata1': device_add
[    4.148665][    T1] device: 'ata1': device_add
[    4.153494][    T1] device: 'link1': device_add
[    4.158076][    T1] device: 'link1': device_add
[    4.162753][    T1] device: 'dev1.0': device_add
[    4.167441][    T1] device: 'dev1.0': device_add
[    4.172225][    T1] device: 'ata2': device_add
[    4.176746][    T1] device: 'ata2': device_add
[    4.181318][    T1] device: 'link2': device_add
[    4.185916][    T1] device: 'link2': device_add
[    4.190572][    T1] device: 'dev2.0': device_add
[    4.195257][    T1] device: 'dev2.0': device_add
[    4.200422][    T1] device: 'scsi_tmf_0': device_add
[    4.205482][    T1] bus: 'workqueue': add device scsi_tmf_0
[    4.211166][    T1] scsi host0: ahci-mvebu
[    4.215457][    T1] device: 'host0': device_add
[    4.220034][    T1] bus: 'scsi': add device host0
[    4.224894][    T1] device: 'host0': device_add
[    4.230035][    T1] device: 'scsi_tmf_1': device_add
[    4.235086][    T1] bus: 'workqueue': add device scsi_tmf_1
[    4.240764][    T1] scsi host1: ahci-mvebu
[    4.244976][    T1] device: 'host1': device_add
[    4.249551][    T1] bus: 'scsi': add device host1
[    4.254347][    T1] device: 'host1': device_add
[    4.259117][    T1] ata1: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10=
a9fff] port 0x100 irq 42
[    4.267796][    T1] ata2: SATA max UDMA/133 mmio [mem 0xf10a8000-0xf10=
a9fff] port 0x180 irq 42
[    4.276522][    T1] driver: 'ahci-mvebu': driver_bound: bound to devic=
e 'f10a8000.sata'
[    4.284664][    T1] bus: 'platform': really_probe: bound device f10a80=
00.sata to driver ahci-mvebu
[    4.293790][    T1] device class 'mtd': registering
[    4.298760][    T1] device: 'mtd-0': device_add
[    4.303656][    T1] bus: 'platform': add driver marvell-nfc
[    4.309428][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f10d0000.nand-controller with driver marvell-nfc
[    4.320642][    T1] bus: 'platform': really_probe: probing driver marv=
ell-nfc with device f10d0000.nand-controller
[    4.331079][    T1] marvell-nfc f10d0000.nand-controller: no pinctrl h=
andle
[    4.338645][    T1] nand: device found, Manufacturer ID: 0x01, Chip ID=
: 0xf1
[    4.345773][    T1] nand: AMD/Spansion S34ML01G2
[    4.350417][    T1] nand: 128 MiB, SLC, erase size: 128 KiB, page size=
: 2048, OOB size: 64
[    4.359130][    T1] Bad block table found at page 65472, version 0x01
[    4.366098][    T1] Bad block table found at page 65408, version 0x01
[    4.372977][    T1] 10 fixed-partitions partitions found on MTD device=
 pxa3xx_nand-0
[    4.380809][    T1] Creating 10 MTD partitions on "pxa3xx_nand-0":
[    4.387045][    T1] 0x000000000000-0x000000200000 : "u-boot"
[    4.392853][    T1] device: 'mtd0': device_add
[    4.398063][    T1] device: 'mtd0ro': device_add
[    4.403286][    T1] device: 'mtdblock0': device_add
[    4.408943][    T1] device: '31:0': device_add
[    4.413714][    T1] 0x000000200000-0x000000240000 : "u_env"
[    4.419348][    T1] device: 'mtd1': device_add
[    4.424196][    T1] device: 'mtd1ro': device_add
[    4.429161][    T1] device: 'mtdblock1': device_add
[    4.434666][    T1] device: '31:1': device_add
[    4.439375][    T1] 0x000000240000-0x000000280000 : "s_env"
[    4.445026][    T1] device: 'mtd2': device_add
[    4.449822][    T1] device: 'mtd2ro': device_add
[    4.454814][    T1] device: 'mtdblock2': device_add
[    4.460283][    T1] device: '31:2': device_add
[    4.464991][    T1] 0x000000900000-0x000000a00000 : "devinfo"
[    4.470802][    T1] device: 'mtd3': device_add
[    4.475627][    T1] device: 'mtd3ro': device_add
[    4.480671][    T1] device: 'mtdblock3': device_add
[    4.486343][    T1] device: '31:3': device_add
[    4.491026][    T1] 0x000000a00000-0x000003200000 : "kernel1"
[    4.497574][    T1] device: 'mtd4': device_add
[    4.502393][    T1] device: 'mtd4ro': device_add
[    4.507422][    T1] device: 'mtdblock4': device_add
[    4.512897][    T1] device: '31:4': device_add
[    4.517595][    T1] 0x000001000000-0x000003200000 : "rootfs1"
[    4.524022][    T1] device: 'mtd5': device_add
[    4.528846][    T1] device: 'mtd5ro': device_add
[    4.533837][    T1] device: 'mtdblock5': device_add
[    4.539310][    T1] device: '31:5': device_add
[    4.544010][    T1] 0x000003200000-0x000005a00000 : "kernel2"
[    4.550523][    T1] device: 'mtd6': device_add
[    4.555347][    T1] device: 'mtd6ro': device_add
[    4.560333][    T1] device: 'mtdblock6': device_add
[    4.565869][    T1] device: '31:6': device_add
[    4.570544][    T1] 0x000003800000-0x000005a00000 : "rootfs2"
[    4.576983][    T1] device: 'mtd7': device_add
[    4.581798][    T1] device: 'mtd7ro': device_add
[    4.586787][    T1] device: 'mtdblock7': device_add
[    4.592257][    T1] device: '31:7': device_add
[    4.596967][    T1] 0x000005a00000-0x000008000000 : "syscfg"
[    4.603339][    T1] device: 'mtd8': device_add
[    4.608168][    T1] device: 'mtd8ro': device_add
[    4.613112][    T1] device: 'mtdblock8': device_add
[    4.618616][    T1] device: '31:8': device_add
[    4.623284][    T1] 0x000000280000-0x000000900000 : "unused_area"
[    4.629570][    T1] device: 'mtd9': device_add
[    4.634392][    T1] device: 'mtd9ro': device_add
[    4.635223][  T108] ata1: SATA link down (SStatus 0 SControl 300)
[    4.639358][    T1] device: 'mtdblock9': device_add
[    4.650694][    T1] device: '31:9': device_add
[    4.655423][    T1] driver: 'marvell-nfc': driver_bound: bound to devi=
ce 'f10d0000.nand-controller'
[    4.664665][    T1] bus: 'platform': really_probe: bound device f10d00=
00.nand-controller to driver marvell-nfc
[    4.674824][    T1] bus: 'spi': add driver spi-nor
[    4.679694][    T1] bus: 'platform': add driver orion_spi
[    4.685420][    T1] bus: 'pci': add driver ehci-pci
[    4.690406][    T1] bus: 'platform': add driver orion-ehci
[    4.696033][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1058000.usb with driver orion-ehci
[    4.706111][    T1] bus: 'platform': really_probe: probing driver orio=
n-ehci with device f1058000.usb
[    4.715420][    T1] orion-ehci f1058000.usb: no pinctrl handle
[    4.721508][    T1] orion-ehci f1058000.usb: EHCI Host Controller
[    4.727893][    T1] orion-ehci f1058000.usb: new USB bus registered, a=
ssigned bus number 1
[    4.736445][    T1] orion-ehci f1058000.usb: irq 44, io mem 0xf1058000
[    4.763497][    T1] orion-ehci f1058000.usb: USB 2.0 started, EHCI 1.0=
0
[    4.770833][    T1] usb usb1: New USB device found, idVendor=3D1d6b, i=
dProduct=3D0002, bcdDevice=3D 6.02
[    4.779918][    T1] usb usb1: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    4.787901][    T1] usb usb1: Product: EHCI Host Controller
[    4.793525][    T1] usb usb1: Manufacturer: Linux 6.2.0-rc6-M95D-00001=
-gd783bde80fb1 ehci_hcd
[    4.802095][    T1] usb usb1: SerialNumber: f1058000.usb
[    4.807476][    T1] device: 'usb1': device_add
[    4.812226][    T1] bus: 'usb': add device usb1
[    4.817405][    T1] bus: 'usb': __driver_probe_device: matched device =
usb1 with driver usb
[    4.825814][    T1] bus: 'usb': really_probe: probing driver usb with =
device usb1
[    4.833724][    T1] device: '1-0:1.0': device_add
[    4.838539][    T1] bus: 'usb': add device 1-0:1.0
[    4.843577][    T1] bus: 'usb': __driver_probe_device: matched device =
1-0:1.0 with driver hub
[    4.852178][    T1] bus: 'usb': really_probe: probing driver hub with =
device 1-0:1.0
[    4.860032][    T1] hub 1-0:1.0: USB hub found
[    4.864637][    T1] hub 1-0:1.0: 1 port detected
[    4.869619][    T1] device: 'usb1-port1': device_add
[    4.874854][    T1] usb usb1-port1: adding component (ops connector_op=
s)
[    4.881747][    T1] driver: 'hub': driver_bound: bound to device '1-0:=
1.0'
[    4.888795][    T1] bus: 'usb': really_probe: bound device 1-0:1.0 to =
driver hub
[    4.896355][    T1] device: 'ep_81': device_add
[    4.900994][    T1] driver: 'usb': driver_bound: bound to device 'usb1=
'
[    4.907829][    T1] bus: 'usb': really_probe: bound device usb1 to dri=
ver usb
[    4.915047][    T1] device: 'ep_00': device_add
[    4.919669][    T1] driver: 'orion-ehci': driver_bound: bound to devic=
e 'f1058000.usb'
[    4.927708][    T1] bus: 'platform': really_probe: bound device f10580=
00.usb to driver orion-ehci
[    4.936772][    T1] bus: 'pci': add driver xhci_hcd
[    4.941750][    T1] bus: 'platform': add driver xhci-hcd
[    4.947322][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f10f8000.usb3 with driver xhci-hcd
[    4.957313][    T1] bus: 'platform': really_probe: probing driver xhci=
-hcd with device f10f8000.usb3
[    4.966525][    T1] xhci-hcd f10f8000.usb3: no pinctrl handle
[    4.972620][    T1] xhci-hcd f10f8000.usb3: Driver xhci-hcd requests p=
robe deferral
[    4.980772][    T1] platform f10f8000.usb3: Added to deferred list
[    4.987137][    T1] bus: 'usb': add driver usb-storage
[    4.992376][    T1] usbcore: registered new interface driver usb-stora=
ge
[    4.999142][    T1] i2c_dev: i2c /dev entries driver
[    5.004167][    T1] device class 'i2c-dev': registering
[    5.009459][    T1] bus: 'platform': add driver mv64xxx_i2c
[    5.015128][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1011000.i2c with driver mv64xxx_i2c
[    5.025293][    T1] bus: 'platform': really_probe: probing driver mv64=
xxx_i2c with device f1011000.i2c
[    5.034738][    T1] mv64xxx_i2c f1011000.i2c: no init pinctrl state
[    5.041364][    T1] device: 'i2c-0': device_add
[    5.045987][    T1] bus: 'i2c': add device i2c-0
[    5.050727][    T1] device: 'i2c-0': device_add
[    5.055975][    T1] device: '0-004c': device_add
[    5.060664][    T1] bus: 'i2c': add device 0-004c
[    5.065538][    T1] device: '0-0068': device_add
[    5.070221][    T1] bus: 'i2c': add device 0-0068
[    5.075126][    T1] driver: 'mv64xxx_i2c': driver_bound: bound to devi=
ce 'f1011000.i2c'
[    5.083238][    T1] bus: 'platform': really_probe: bound device f10110=
00.i2c to driver mv64xxx_i2c
[    5.092429][    T1] bus: 'i2c': add driver tmp421
[    5.097200][    T1] bus: 'i2c': __driver_probe_device: matched device =
0-004c with driver tmp421
[    5.105967][    T1] bus: 'i2c': really_probe: probing driver tmp421 wi=
th device 0-004c
[    5.113983][    T1] tmp421 0-004c: no pinctrl handle
[    5.120566][    T1] device: 'hwmon0': device_add
[    5.125468][    T1] driver: 'tmp421': driver_bound: bound to device '0=
-004c'
[    5.127046][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[    5.132677][    T1] bus: 'i2c': really_probe: bound device 0-004c to d=
river tmp421
[    5.146582][    T1] bus: 'platform': add driver armada_thermal
[    5.152605][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f10e4078.thermal with driver armada_thermal
[    5.163382][    T1] bus: 'platform': really_probe: probing driver arma=
da_thermal with device f10e4078.thermal
[    5.173380][    T1] armada_thermal f10e4078.thermal: no pinctrl handle
[    5.181271][    T1] device: 'thermal_zone0': device_add
[    5.186817][    T1] device: 'hwmon1': device_add
[    5.191601][    T1] driver: 'armada_thermal': driver_bound: bound to d=
evice 'f10e4078.thermal'
[    5.200350][    T1] bus: 'platform': really_probe: bound device f10e40=
78.thermal to driver armada_thermal
[    5.210069][    T1] bus: 'platform': add driver orion_wdt
[    5.215608][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1020300.watchdog with driver orion_wdt
[    5.226033][    T1] bus: 'platform': really_probe: probing driver orio=
n_wdt with device f1020300.watchdog
[    5.235681][    T1] orion_wdt f1020300.watchdog: no pinctrl handle
[    5.242461][    T1] device: 'watchdog': device_add
[    5.247620][    T1] device: 'watchdog0': device_add
[    5.252983][    T1] orion_wdt: Initial timeout 171 sec
[    5.258190][    T1] driver: 'orion_wdt': driver_bound: bound to device=
 'f1020300.watchdog'
[    5.266588][    T1] bus: 'platform': really_probe: bound device f10203=
00.watchdog to driver orion_wdt
[    5.276013][    T1] bus: 'platform': add driver leds-gpio
[    5.281559][    T1] bus: 'platform': __driver_probe_device: matched de=
vice gpio-leds with driver leds-gpio
[    5.291288][    T1] bus: 'platform': really_probe: probing driver leds=
-gpio with device gpio-leds
[    5.300303][    T1] leds-gpio gpio-leds: no init pinctrl state
[    5.306412][    T1] device: 'shelby:white:power': device_add
[    5.312553][    T1] device: 'shelby:white:sata': device_add
[    5.318358][    T1] driver: 'leds-gpio': driver_bound: bound to device=
 'gpio-leds'
[    5.326017][    T1] leds-gpio gpio-leds: Dropping the link to f1018140=
.gpio
[    5.333021][    T1] device: 'platform:f1018140.gpio--platform:gpio-led=
s': device_unregister
[    5.341661][    T1] bus: 'platform': really_probe: bound device gpio-l=
eds to driver leds-gpio
[    5.350303][    T1] bus: 'i2c': add driver leds-pca963x
[    5.355603][    T1] bus: 'i2c': __driver_probe_device: matched device =
0-0068 with driver leds-pca963x
[    5.364902][    T1] bus: 'i2c': really_probe: probing driver leds-pca9=
63x with device 0-0068
[    5.373398][    T1] leds-pca963x 0-0068: no pinctrl handle
[    5.381600][    T1] device: 'pca963x:shelby:amber:wan': device_add
[    5.387975][    T1] device: 'pca963x:shelby:white:wan': device_add
[    5.394320][    T1] device: 'pca963x:shelby:white:wlan_2g': device_add
[    5.400996][    T1] device: 'pca963x:shelby:white:wlan_5g': device_add
[    5.407689][    T1] device: 'pca963x:shelby:white:usb2': device_add
[    5.414128][    T1] device: 'pca963x:shelby:white:usb3_1': device_add
[    5.420709][    T1] device: 'pca963x:shelby:white:usb3_2': device_add
[    5.427321][    T1] device: 'pca963x:shelby:white:wps': device_add
[    5.433666][    T1] device: 'pca963x:shelby:amber:wps': device_add
[    5.439962][    T1] driver: 'leds-pca963x': driver_bound: bound to dev=
ice '0-0068'
[    5.447702][    T1] bus: 'i2c': really_probe: bound device 0-0068 to d=
river leds-pca963x
[    5.456218][    T1] bus: 'platform': add driver marvell-cesa
[    5.462067][    T1] bus: 'platform': __driver_probe_device: matched de=
vice f1090000.crypto with driver marvell-cesa
[    5.472583][    T1] bus: 'platform': really_probe: probing driver marv=
ell-cesa with device f1090000.crypto
[    5.482321][    T1] marvell-cesa f1090000.crypto: no pinctrl handle
[    5.489799][    T1] marvell-cesa f1090000.crypto: CESA device successf=
ully registered
[    5.497708][    T1] driver: 'marvell-cesa': driver_bound: bound to dev=
ice 'f1090000.crypto'
[    5.506194][    T1] bus: 'platform': really_probe: bound device f10900=
00.crypto to driver marvell-cesa
[    5.515672][    T1] device class 'extcon': registering
[    5.520876][    T1] bus: 'platform': add driver mvebu-devbus
[    5.526788][    T1] Registering SWP/SWPB emulation handler
[    5.562880][   T22] devices_kset: Moving usb3_1-vbus to end of list
[    5.569355][   T22] devices_kset: Moving usb3_1-phy to end of list
[    5.575603][   T22] platform usb3_1-vbus: Retrying from deferred list
[    5.582133][   T22] bus: 'platform': __driver_probe_device: matched de=
vice usb3_1-vbus with driver reg-fixed-voltage
[    5.592771][   T22] bus: 'platform': really_probe: probing driver reg-=
fixed-voltage with device usb3_1-vbus
[    5.602734][   T22] reg-fixed-voltage usb3_1-vbus: no init pinctrl sta=
te
[    5.609849][   T22] usb3_1-vbus: 5000 mV, disabled
[    5.614702][   T22] device: 'regulator.1': device_add
[    5.620241][   T22] reg-fixed-voltage usb3_1-vbus: usb3_1-vbus supplyi=
ng 5000000uV
[    5.627878][   T22] driver: 'reg-fixed-voltage': driver_bound: bound t=
o device 'usb3_1-vbus'
[    5.636473][   T22] bus: 'platform': really_probe: bound device usb3_1=
-vbus to driver reg-fixed-voltage
[    5.645968][   T22] devices_kset: Moving usb3_1-phy to end of list
[    5.652190][   T22] platform usb3_1-phy: Retrying from deferred list
[    5.658617][   T22] bus: 'platform': __driver_probe_device: matched de=
vice usb3_1-phy with driver usb_phy_generic
[    5.668951][   T22] bus: 'platform': really_probe: probing driver usb_=
phy_generic with device usb3_1-phy
[    5.678512][   T22] usb_phy_generic usb3_1-phy: no pinctrl handle
[    5.684792][   T22] usb_phy_generic usb3_1-phy: Looking up vcc-supply =
from device tree
[    5.692902][   T22] device: 'regulator:regulator.1--platform:usb3_1-ph=
y': device_add
[    5.700897][   T22] devices_kset: Moving usb3_1-phy to end of list
[    5.707136][   T22] usb_phy_generic usb3_1-phy: Linked as a consumer t=
o regulator.1
[    5.714856][   T22] usb_phy_generic usb3_1-phy: Looking up vbus-supply=
 from device tree
[    5.722908][   T22] usb_phy_generic usb3_1-phy: Looking up vbus-supply=
 property in node /usb3_1-phy failed
[    5.732643][   T22] usb_phy_generic usb3_1-phy: dummy supplies not all=
owed for exclusive requests
[    5.741594][   T22] driver: 'usb_phy_generic': driver_bound: bound to =
device 'usb3_1-phy'
[    5.749893][   T22] bus: 'platform': really_probe: bound device usb3_1=
-phy to driver usb_phy_generic
[    5.759101][   T22] devices_kset: Moving f10f8000.usb3 to end of list
[    5.765599][   T22] platform f10f8000.usb3: Retrying from deferred lis=
t
[    5.772344][   T22] bus: 'platform': __driver_probe_device: matched de=
vice f10f8000.usb3 with driver xhci-hcd
[    5.782331][   T22] bus: 'platform': really_probe: probing driver xhci=
-hcd with device f10f8000.usb3
[    5.791547][   T22] xhci-hcd f10f8000.usb3: no pinctrl handle
[    5.797688][   T22] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    5.803844][   T22] xhci-hcd f10f8000.usb3: new USB bus registered, as=
signed bus number 2
[    5.815748][   T22] xhci-hcd f10f8000.usb3: hcc params 0x0a000990 hci =
version 0x100 quirks 0x0000000000010010
[    5.825904][   T22] xhci-hcd f10f8000.usb3: irq 45, io mem 0xf10f8000
[    5.832874][   T22] xhci-hcd f10f8000.usb3: xHCI Host Controller
[    5.838959][   T22] xhci-hcd f10f8000.usb3: new USB bus registered, as=
signed bus number 3
[    5.847221][   T22] xhci-hcd f10f8000.usb3: Host supports USB 3.0 Supe=
rSpeed
[    5.854811][   T22] usb usb2: New USB device found, idVendor=3D1d6b, i=
dProduct=3D0002, bcdDevice=3D 6.02
[    5.863880][   T22] usb usb2: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    5.871843][   T22] usb usb2: Product: xHCI Host Controller
[    5.873495][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[    5.877560][   T22] usb usb2: Manufacturer: Linux 6.2.0-rc6-M95D-00001=
-gd783bde80fb1 xhci-hcd
[    5.883845][  T113] ata2: limiting SATA link speed to 1.5 Gbps
[    5.892342][   T22] usb usb2: SerialNumber: f10f8000.usb3
[    5.903671][   T22] device: 'usb2': device_add
[    5.908401][   T22] bus: 'usb': add device usb2
[    5.913341][   T22] bus: 'usb': __driver_probe_device: matched device =
usb2 with driver usb
[    5.921835][   T22] bus: 'usb': really_probe: probing driver usb with =
device usb2
[    5.929553][   T22] device: '2-0:1.0': device_add
[    5.934415][   T22] bus: 'usb': add device 2-0:1.0
[    5.939337][   T22] bus: 'usb': __driver_probe_device: matched device =
2-0:1.0 with driver hub
[    5.947963][   T22] bus: 'usb': really_probe: probing driver hub with =
device 2-0:1.0
[    5.955808][   T22] hub 2-0:1.0: USB hub found
[    5.960405][   T22] hub 2-0:1.0: 1 port detected
[    5.965266][   T22] device: 'usb2-port1': device_add
[    5.970351][   T22] usb usb2-port1: adding component (ops connector_op=
s)
[    5.977190][   T22] driver: 'hub': driver_bound: bound to device '2-0:=
1.0'
[    5.984226][   T22] bus: 'usb': really_probe: bound device 2-0:1.0 to =
driver hub
[    5.991687][   T22] device: 'ep_81': device_add
[    5.996344][   T22] driver: 'usb': driver_bound: bound to device 'usb2=
'
[    6.003061][   T22] bus: 'usb': really_probe: bound device usb2 to dri=
ver usb
[    6.010293][   T22] device: 'ep_00': device_add
[    6.015169][   T22] usb usb3: We don't know the algorithms for LPM for=
 this host, disabling LPM.
[    6.024305][   T22] usb usb3: New USB device found, idVendor=3D1d6b, i=
dProduct=3D0003, bcdDevice=3D 6.02
[    6.033315][   T22] usb usb3: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[    6.041298][   T22] usb usb3: Product: xHCI Host Controller
[    6.046928][   T22] usb usb3: Manufacturer: Linux 6.2.0-rc6-M95D-00001=
-gd783bde80fb1 xhci-hcd
[    6.055514][   T22] usb usb3: SerialNumber: f10f8000.usb3
[    6.060956][   T22] device: 'usb3': device_add
[    6.065662][   T22] bus: 'usb': add device usb3
[    6.070546][   T22] bus: 'usb': __driver_probe_device: matched device =
usb3 with driver usb
[    6.078914][   T22] bus: 'usb': really_probe: probing driver usb with =
device usb3
[    6.086614][   T22] device: '3-0:1.0': device_add
[    6.091431][   T22] bus: 'usb': add device 3-0:1.0
[    6.096360][   T22] bus: 'usb': __driver_probe_device: matched device =
3-0:1.0 with driver hub
[    6.104967][   T22] bus: 'usb': really_probe: probing driver hub with =
device 3-0:1.0
[    6.112790][   T22] hub 3-0:1.0: USB hub found
[    6.117341][   T22] hub 3-0:1.0: 1 port detected
[    6.122113][   T22] device: 'usb3-port1': device_add
[    6.127206][   T22] usb usb3-port1: adding component (ops connector_op=
s)
[    6.134074][   T22] driver: 'hub': driver_bound: bound to device '3-0:=
1.0'
[    6.141051][   T22] bus: 'usb': really_probe: bound device 3-0:1.0 to =
driver hub
[    6.148534][   T22] device: 'ep_81': device_add
[    6.153173][   T22] driver: 'usb': driver_bound: bound to device 'usb3=
'
[    6.159906][   T22] bus: 'usb': really_probe: bound device usb3 to dri=
ver usb
[    6.167122][   T22] device: 'ep_00': device_add
[    6.171748][   T22] driver: 'xhci-hcd': driver_bound: bound to device =
'f10f8000.usb3'
[    6.179703][   T22] bus: 'platform': really_probe: bound device f10f80=
00.usb3 to driver xhci-hcd
[    6.188719][    T1] device class 'ubi': registering
[    6.193754][    T1] device: 'ubi_ctrl': device_add
[    6.200728][    T1] Waiting 100 sec before mounting root device...
[    6.713487][  T201] usb 2-1: new high-speed USB device number 2 using =
xhci-hcd
[    6.833478][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[    6.840791][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f
[    6.849421][  T113] device: 'link2.0': device_add
[    6.854363][  T113] device: 'link2.0': device_add
[    6.859268][  T113] device: 'dev2.0.0': device_add
[    6.864156][  T113] device: 'dev2.0.0': device_add
[    6.869153][  T113] device: 'link2.1': device_add
[    6.873934][  T113] device: 'link2.1': device_add
[    6.878791][  T113] device: 'dev2.1.0': device_add
[    6.883657][  T113] device: 'dev2.1.0': device_add
[    6.888636][  T113] device: 'link2.2': device_add
[    6.893392][  T113] device: 'link2.2': device_add
[    6.898284][  T113] device: 'dev2.2.0': device_add
[    6.903128][  T113] device: 'dev2.2.0': device_add
[    6.908111][  T113] device: 'link2.3': device_add
[    6.912869][  T113] device: 'link2.3': device_add
[    6.917726][  T113] device: 'dev2.3.0': device_add
[    6.922572][  T113] device: 'dev2.3.0': device_add
[    6.927555][  T113] device: 'link2.4': device_add
[    6.932314][  T113] device: 'link2.4': device_add
[    6.937177][  T113] device: 'dev2.4.0': device_add
[    6.942024][  T113] device: 'dev2.4.0': device_add
[    6.947001][  T113] device: 'link2.5': device_add
[    6.951761][  T113] device: 'link2.5': device_add
[    6.956635][  T113] device: 'dev2.5.0': device_add
[    6.961483][  T113] device: 'dev2.5.0': device_add
[    6.966462][  T113] device: 'link2.6': device_add
[    6.971223][  T113] device: 'link2.6': device_add
[    6.976084][  T113] device: 'dev2.6.0': device_add
[    6.980939][  T113] device: 'dev2.6.0': device_add
[    6.985953][  T113] device: 'link2.7': device_add
[    6.990720][  T113] device: 'link2.7': device_add
[    6.995600][  T113] device: 'dev2.7.0': device_add
[    7.000451][  T113] device: 'dev2.7.0': device_add
[    7.005439][  T113] device: 'link2.8': device_add
[    7.010203][  T113] device: 'link2.8': device_add
[    7.015076][  T113] device: 'dev2.8.0': device_add
[    7.019926][  T113] device: 'dev2.8.0': device_add
[    7.024908][  T113] device: 'link2.9': device_add
[    7.029672][  T113] device: 'link2.9': device_add
[    7.034545][  T113] device: 'dev2.9.0': device_add
[    7.039396][  T113] device: 'dev2.9.0': device_add
[    7.044391][  T113] device: 'link2.10': device_add
[    7.049245][  T113] device: 'link2.10': device_add
[    7.054199][  T113] device: 'dev2.10.0': device_add
[    7.059139][  T113] device: 'dev2.10.0': device_add
[    7.064224][  T113] device: 'link2.11': device_add
[    7.069079][  T113] device: 'link2.11': device_add
[    7.074042][  T113] device: 'dev2.11.0': device_add
[    7.078984][  T113] device: 'dev2.11.0': device_add
[    7.084093][  T113] device: 'link2.12': device_add
[    7.088950][  T113] device: 'link2.12': device_add
[    7.093916][  T113] device: 'dev2.12.0': device_add
[    7.098859][  T113] device: 'dev2.12.0': device_add
[    7.103942][  T113] device: 'link2.13': device_add
[    7.108800][  T113] device: 'link2.13': device_add
[    7.113780][  T113] device: 'dev2.13.0': device_add
[    7.118725][  T113] device: 'dev2.13.0': device_add
[    7.123808][  T113] device: 'link2.14': device_add
[    7.128667][  T113] device: 'link2.14': device_add
[    7.133635][  T113] device: 'dev2.14.0': device_add
[    7.138581][  T113] device: 'dev2.14.0': device_add
[    7.143662][  T113] ahci-mvebu f10a8000.sata: FBS is enabled
[    7.149993][  T113] ata2.00: hard resetting link
[    7.180668][  T201] usb 2-1: New USB device found, idVendor=3D058f, id=
Product=3D6387, bcdDevice=3D 1.00
[    7.189672][  T201] usb 2-1: New USB device strings: Mfr=3D1, Product=
=3D2, SerialNumber=3D3
[    7.197569][  T201] usb 2-1: Product: Mass Storage
[    7.202390][  T201] usb 2-1: Manufacturer: Generic
[    7.207242][  T201] usb 2-1: SerialNumber: 016E07B1
[    7.212167][  T201] device: '2-1': device_add
[    7.216803][  T201] bus: 'usb': add device 2-1
[    7.221626][  T201] bus: 'usb': __driver_probe_device: matched device =
2-1 with driver usb
[    7.229942][  T201] bus: 'usb': really_probe: probing driver usb with =
device 2-1
[    7.237468][  T201] usb 2-1: no default pinctrl state
[    7.243329][  T201] device: '2-1:1.0': device_add
[    7.248194][  T201] bus: 'usb': add device 2-1:1.0
[    7.253118][  T201] bus: 'usb': __driver_probe_device: matched device =
2-1:1.0 with driver usb-storage
[    7.262452][  T201] bus: 'usb': really_probe: probing driver usb-stora=
ge with device 2-1:1.0
[    7.270986][  T201] usb-storage 2-1:1.0: no default pinctrl state
[    7.277185][  T201] usb-storage 2-1:1.0: USB Mass Storage device detec=
ted
[    7.284403][  T201] device: 'scsi_tmf_2': device_add
[    7.289424][  T201] bus: 'workqueue': add device scsi_tmf_2
[    7.295374][  T201] scsi host2: usb-storage 2-1:1.0
[    7.300416][  T201] device: 'host2': device_add
[    7.305042][  T201] bus: 'scsi': add device host2
[    7.309848][  T201] device: 'host2': device_add
[    7.314708][  T201] driver: 'usb-storage': driver_bound: bound to devi=
ce '2-1:1.0'
[    7.322384][  T201] bus: 'usb': really_probe: bound device 2-1:1.0 to =
driver usb-storage
[    7.330593][  T201] device: 'ep_01': device_add
[    7.335248][  T201] device: 'ep_82': device_add
[    7.339884][  T201] driver: 'usb': driver_bound: bound to device '2-1'
[    7.346517][  T201] bus: 'usb': really_probe: bound device 2-1 to driv=
er usb
[    7.353671][  T201] device: 'ep_00': device_add
[    7.486174][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[    7.493398][  T113] ata2.01: hard resetting link
[    7.826136][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[    7.833353][  T113] ata2.02: hard resetting link
[    8.166136][  T113] ata2.02: SATA link down (SStatus 0 SControl 300)
[    8.172603][  T113] ata2.03: hard resetting link
[    8.395831][  T201] scsi 2:0:0:0: Direct-Access     Generic  Flash Dis=
k       8.07 PQ: 0 ANSI: 4
[    8.404822][  T201] device: 'target2:0:0': device_add
[    8.409961][  T201] bus: 'scsi': add device target2:0:0
[    8.415397][  T201] device: '2:0:0:0': device_add
[    8.420330][  T201] bus: 'scsi': add device 2:0:0:0
[    8.425328][  T201] scsi 2:0:0:0: scheduling asynchronous probe
[    8.431348][  T201] device: '2:0:0:0': device_add
[    8.431369][   T22] bus: 'scsi': __driver_probe_device: matched device=
 2:0:0:0 with driver sd
[    8.436365][  T201] device: '2:0:0:0': device_add
[    8.444766][   T22] bus: 'scsi': really_probe: probing driver sd with =
device 2:0:0:0
[    8.457323][   T22] sd 2:0:0:0: no default pinctrl state
[    8.462925][   T22] device: '2:0:0:0': device_add
[    8.468998][   T22] sd 2:0:0:0: [sda] 122880000 512-byte logical block=
s: (62.9 GB/58.6 GiB)
[    8.478142][   T22] sd 2:0:0:0: [sda] Write Protect is off
[    8.483700][   T22] sd 2:0:0:0: [sda] Mode Sense: 23 00 00 00
[    8.490182][   T22] sd 2:0:0:0: [sda] Write cache: disabled, read cach=
e: enabled, doesn't support DPO or FUA
[    8.500128][   T22] device: 'sda': device_add
[    8.505303][   T22] device: '8:0': device_add
[    8.507981][  T113] ata2.03: SATA link down (SStatus 0 SControl 300)
[    8.516425][  T113] ata2.04: hard resetting link
[    8.525164][   T22] sd 2:0:0:0: [sda] Attached SCSI removable disk
[    8.531387][   T22] driver: 'sd': driver_bound: bound to device '2:0:0=
:0'
[    8.538335][   T22] bus: 'scsi': really_probe: bound device 2:0:0:0 to=
 driver sd
[    8.545813][   T22] sd 2:0:0:0: async probe completed
[    8.846145][  T113] ata2.04: SATA link down (SStatus 0 SControl 300)
[    8.852618][  T113] ata2.05: hard resetting link
[    9.186137][  T113] ata2.05: SATA link down (SStatus 0 SControl 300)
[    9.192606][  T113] ata2.06: hard resetting link
[    9.526131][  T113] ata2.06: SATA link down (SStatus 0 SControl 300)
[    9.532597][  T113] ata2.07: hard resetting link
[    9.866143][  T113] ata2.07: SATA link down (SStatus 0 SControl 300)
[    9.872700][  T113] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, =
max UDMA/133
[    9.880350][  T113] ata2.00: 976773168 sectors, multi 0: LBA48=20
[=20   9.886469][  T113] ata2.00: configured for UDMA/133
[    9.891543][  T113] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA=
/133
[    9.898484][  T113] ata2.01: 23437498368 sectors, multi 0: LBA48=20
[=20   9.904761][  T113] ata2.01: configured for UDMA/133
[    9.909902][  T113] ata2: EH complete
[    9.914304][  T201] scsi 1:0:0:0: Direct-Access     ATA      WDC WD50A=
RC-5040 n/a  PQ: 0 ANSI: 5
[    9.924024][  T201] device: 'target1:0:0': device_add
[    9.929148][  T201] bus: 'scsi': add device target1:0:0
[    9.934522][  T201] device: '1:0:0:0': device_add
[    9.939530][  T201] bus: 'scsi': add device 1:0:0:0
[    9.944518][  T201] scsi 1:0:0:0: scheduling asynchronous probe
[    9.950515][  T201] device: '1:0:0:0': device_add
[    9.950530][   T22] bus: 'scsi': __driver_probe_device: matched device=
 1:0:0:0 with driver sd
[    9.955446][  T201] device: '1:0:0:0': device_add
[    9.963876][   T22] bus: 'scsi': really_probe: probing driver sd with =
device 1:0:0:0
[    9.969160][  T201] scsi 1:1:0:0: Direct-Access     ATA      Areca   A=
rchive  n/a  PQ: 0 ANSI: 5
[    9.976414][   T22] sd 1:0:0:0: no default pinctrl state
[    9.986095][  T201] device: 'target1:1:0': device_add
[    9.990662][   T22] device: '1:0:0:0': device_add
[    9.995694][  T201] bus: 'scsi': add device target1:1:0
[   10.001292][   T22] sd 1:0:0:0: [sdb] 976773168 512-byte logical block=
s: (500 GB/466 GiB)
[   10.005739][  T201] device: '1:1:0:0': device_add
[   10.014094][   T22] sd 1:0:0:0: [sdb] Write Protect is off
[   10.018913][  T201] bus: 'scsi': add device 1:1:0:0
[   10.024182][   T22] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   10.024521][   T22] sd 1:0:0:0: [sdb] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   10.029129][  T201] scsi 1:1:0:0: scheduling asynchronous probe
[   10.035141][   T22] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 b=
ytes
[   10.044710][  T201] device: '1:1:0:0': device_add
[   10.050663][   T22] device: 'sdb': device_add
[   10.057645][  T201] device: '1:1:0:0': device_add
[   10.062473][    T8] bus: 'scsi': __driver_probe_device: matched device=
 1:1:0:0 with driver sd
[   10.073944][   T22] device: '8:16': device_add
[   10.080044][    T8] bus: 'scsi': really_probe: probing driver sd with =
device 1:1:0:0
[   10.085794][   T22] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   10.092278][    T8] sd 1:1:0:0: no default pinctrl state
[   10.098515][   T22] driver: 'sd': driver_bound: bound to device '1:0:0=
:0'
[   10.103921][    T8] device: '1:1:0:0': device_add
[   10.110722][   T22] bus: 'scsi': really_probe: bound device 1:0:0:0 to=
 driver sd
[   10.116166][    T8] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blo=
cks: (12.0 TB/10.9 TiB)
[   10.122869][   T22] sd 1:0:0:0: async probe completed
[   10.131515][    T8] sd 1:1:0:0: [sdc] Write Protect is off
[   10.142064][    T8] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   10.147997][    T8] sd 1:1:0:0: [sdc] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   10.157973][    T8] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 b=
ytes
[   10.164952][    T8] device: 'sdc': device_add
[   10.169986][    T8] device: '8:32': device_add
[   10.175532][    T8] sd 1:1:0:0: [sdc] Attached SCSI removable disk
[   10.181753][    T8] driver: 'sd': driver_bound: bound to device '1:1:0=
:0'
[   10.188650][    T8] bus: 'scsi': really_probe: bound device 1:1:0:0 to=
 driver sd
[   10.196111][    T8] sd 1:1:0:0: async probe completed

Marius Dinu

