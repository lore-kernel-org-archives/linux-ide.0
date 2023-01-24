Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CCC25B4E
	for <linux-ide@archiver.kernel.org>; Tue, 24 Jan 2023 08:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjAXIFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 03:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXIFN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 03:05:13 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5AB303FB
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 00:05:10 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=5fbHRfQeUBShN5rgNpyP/2MYtMnx6a9cibCa7zNPNqM=;
        b=l5815fvLj4lvrsO50Xvg+SGS6dtAIZVKhcYwmm7PT3czwe2zEHOmF9R8LEY0K3Qgi8/G/KsYQQyjyGnxFXVyzJnCdTa6DC+n/3hbPpwi68/QkBsGBUOa3naXDGFvDpo++knVPcUaGFRqFKf1BAfS43zuUzcFPAzXtT+XN/Ql7bNI9Sfcz39ntQMSwZAJv4TRp6SmqgACI7W3+eUdscY/als5mZSdop1a5ZXahmWSR19nRVUbL0oJbBaw/Z
        gXsUXCf9O8Vt7MsheVPXZtLbfmuDFoPh0xQ+A2WzRYeZkpkxRL/gSF0YD1Fcaaccz1SyIB8/4bPYCxDomc7DRMZevcJA==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 24 Jan 2023 08:04:53 +0000
MIME-Version: 1.0
Date:   Tue, 24 Jan 2023 08:04:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <fa7f7eea-7b43-f2d7-18e5-f253ed316919@opensource.wdc.com>
References: <fa7f7eea-7b43-f2d7-18e5-f253ed316919@opensource.wdc.com>
 <cf5d33e3-995f-4346-b02a-b203ed94d9e3@opensource.wdc.com>
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
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 24, 2023 1:00 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

>> I think that the old behaviour (before commit
>> 2dc0b46b5ea30f169b0b272253ea846a5a281731) of slowing down sata speed
>> when a connection can't be established is in fact the right thing to
>> do. Maybe a longer delay before reducing the link speed would satisfy
>> the random cases that the commit author reported. Maybe he was just
>> having a loose connector issue - especially since he only reported one
>> case.
>=20
>=20I do not think that a longer delay will change anything in your case =
since
> the device presence cannot be established when starting speed negotiati=
on
> without a limit: see the "debounce, SCR=3D0x100" messages in your debug=
,
> while the 1.5gbps link speed forcing leads to an immediate device prese=
nce
> detected (debounce, SCR=3D0x113 message).

I was referring to the original "bug" the commit author (David Milburn) w=
as trying to fix.

> Can you please try this one:
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..a4e2a93af0e5 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3085,10 +3085,17 @@ int sata_down_spd_limit(struct ata_link *link, =
u32
> spd_limit)
> * If not, use cached value in link->sata_spd.
> */
> rc =3D sata_scr_read(link, SCR_STATUS, &sstatus);
> - if (rc =3D=3D 0 && ata_sstatus_online(sstatus))
> + if (rc =3D=3D 0 && ata_sstatus_online(sstatus)) {
> spd =3D (sstatus >> 4) & 0xf;
> - else
> + } else {
> + /*
> + * Device is not reporting a speed yet. Use the last recorded
> + * speed. If we do not have that either, start with Gen3
> speed.
> + */
> + if (!link->sata_spd)
> + link->sata_spd =3D 3;
> spd =3D link->sata_spd;
> + }
>=20
>=20mask =3D link->sata_spd_limit;
> if (mask <=3D 1)

It works.

[   19.408712][  T113] hardreset, Online=3D>Offline
[   19.408721][  T113] sata_set_spd_needed, scontrol=3D0x330
[   19.413195][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   19.418473][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   19.424789][  T113] __sata_set_spd_needed, target=3D0x3
[   19.431265][  T113] __sata_set_spd_needed, spd=3D0x3
[   19.436358][  T113] __sata_set_spd_needed, final *scontrol=3D0x330
[   19.442248][  T113] resume, do loop
[   19.673966][  T113] resume, after do loop
[   19.733966][  T113] debounce, SCR=3D0x100
[   19.793965][  T113] debounce, SCR=3D0x100
[   19.853965][  T113] debounce, SCR=3D0x100
[   19.913966][  T113] debounce, SCR=3D0x100
[   19.973965][  T113] debounce, SCR=3D0x100
[   20.033966][  T113] debounce, SCR=3D0x100
[   20.093966][  T113] debounce, SCR=3D0x100
[   20.153965][  T113] debounce, SCR=3D0x0
[   20.213987][  T113] debounce, SCR=3D0x0
[   20.217673][  T113] resume, return at end of function
[   20.221358][  T113] hardreset, ata_phys_link_offline check failed
[   20.226462][  T113] ata2: SATA link down (SStatus 0 SControl 330)
[   20.321504][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   20.331407][  T113] ata2: limiting SATA link speed to 1.5 Gbps
[   20.337294][  T113] hardreset, Online=3D>Offline
[   20.337300][  T113] sata_set_spd_needed, scontrol=3D0x330
[   20.341770][  T113] __sata_set_spd_needed, initial limit=3D0x1
[   20.347037][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.352728][  T113] __sata_set_spd_needed, target=3D0x1
[   20.358605][  T113] __sata_set_spd_needed, spd=3D0x3
[   20.363684][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   20.368515][  T113] __sata_set_spd_needed, initial limit=3D0x1
[   20.374576][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   20.380267][  T113] __sata_set_spd_needed, target=3D0x1
[   20.386144][  T113] __sata_set_spd_needed, spd=3D0x3
[   20.391223][  T113] __sata_set_spd_needed, final *scontrol=3D0x314
[   20.397127][  T113] resume, do loop
[   20.623966][  T113] resume, after do loop
[   20.683966][  T113] debounce, SCR=3D0x113
[   20.733987][  T113] debounce, SCR=3D0x113
[   20.793966][  T113] debounce, SCR=3D0x113
[   20.853965][  T113] debounce, SCR=3D0x113
[   20.913966][  T113] debounce, SCR=3D0x113
[   20.973965][  T113] debounce, SCR=3D0x113
[   21.033966][  T113] debounce, SCR=3D0x113
[   21.093966][  T113] debounce, SCR=3D0x113
[   21.153965][  T113] debounce, SCR=3D0x113
[   21.157826][  T113] resume, return at end of function
[   21.161684][  T113] hardreset, Offline=3D>Online
[   21.171249][  T113] hardreset, sata_pmp_supported, before check_ready
[   21.343968][  T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[   21.357696][  T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f
[   21.366318][  T113] device: 'link2.0': device_add
[   21.371124][  T113] device: 'link2.0': device_add
[   21.376120][  T113] device: 'dev2.0.0': device_add
[   21.380966][  T113] device: 'dev2.0.0': device_add
[   21.385953][  T113] device: 'link2.1': device_add
[   21.390711][  T113] device: 'link2.1': device_add
[   21.395569][  T113] device: 'dev2.1.0': device_add
[   21.400437][  T113] device: 'dev2.1.0': device_add
[   21.405469][  T113] device: 'link2.2': device_add
[   21.410232][  T113] device: 'link2.2': device_add
[   21.415086][  T113] device: 'dev2.2.0': device_add
[   21.419937][  T113] device: 'dev2.2.0': device_add
[   21.424910][  T113] device: 'link2.3': device_add
[   21.429669][  T113] device: 'link2.3': device_add
[   21.434528][  T113] device: 'dev2.3.0': device_add
[   21.439374][  T113] device: 'dev2.3.0': device_add
...
[   21.640403][  T113] device: 'link2.14': device_add
[   21.645287][  T113] device: 'link2.14': device_add
[   21.650234][  T113] device: 'dev2.14.0': device_add
[   21.655197][  T113] device: 'dev2.14.0': device_add
[   21.660252][  T113] ahci-mvebu f10a8000.sata: FBS is enabled
[   21.666005][  T113] ata2.00: SCR_CONTROL =3D 0x300
[   21.670684][  T113] ata2.01: SCR_CONTROL =3D 0x300
[   21.675389][  T113] ata2.02: SCR_CONTROL =3D 0x300
[   21.680066][  T113] ata2.03: SCR_CONTROL =3D 0x300
[   21.684774][  T113] ata2.04: SCR_CONTROL =3D 0x300
[   21.689452][  T113] ata2.05: SCR_CONTROL =3D 0x300
[   21.694194][  T113] ata2.06: SCR_CONTROL =3D 0x300
[   21.698871][  T113] ata2.07: SCR_CONTROL =3D 0x300
[   21.703624][  T113] ata2.00: hard resetting link
[   21.708304][  T113] hardreset, Online=3D>Offline
[   21.708343][  T113] sata_set_spd_needed, scontrol=3D0x300
[   21.712815][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   21.718093][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   21.724409][  T113] __sata_set_spd_needed, target=3D0x1
[   21.730274][  T113] __sata_set_spd_needed, spd=3D0x0
[   21.735366][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   21.740280][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   21.746343][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   21.752643][  T113] __sata_set_spd_needed, target=3D0x1
[   21.758522][  T113] __sata_set_spd_needed, spd=3D0x0
[   21.763602][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   21.769655][  T113] resume, do loop
[   22.004001][  T113] resume, after do loop
[   22.012645][  T113] debounce, SCR=3D0x123
[   22.021803][  T113] debounce, SCR=3D0x123
[   22.030784][  T113] debounce, SCR=3D0x123
[   22.039763][  T113] debounce, SCR=3D0x123
[   22.048725][  T113] debounce, SCR=3D0x123
[   22.057686][  T113] debounce, SCR=3D0x123
[   22.066647][  T113] debounce, SCR=3D0x123
[   22.075608][  T113] debounce, SCR=3D0x123
[   22.084568][  T113] debounce, SCR=3D0x123
[   22.093529][  T113] debounce, SCR=3D0x123
[   22.102511][  T113] debounce, SCR=3D0x123
[   22.111494][  T113] debounce, SCR=3D0x123
[   22.115437][  T113] resume, return at end of function
[   22.119327][  T113] hardreset, Offline=3D>Online
[   22.128892][  T113] hardreset, after check_ready
[   22.129113][  T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   22.140984][  T113] ata2.01: hard resetting link
[   22.145653][  T113] hardreset, Online=3D>Offline
[   22.145691][  T113] sata_set_spd_needed, scontrol=3D0x300
[   22.150161][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   22.155436][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   22.161737][  T113] __sata_set_spd_needed, target=3D0x1
[   22.167614][  T113] __sata_set_spd_needed, spd=3D0x0
[   22.172695][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   22.177617][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   22.183657][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   22.189979][  T113] __sata_set_spd_needed, target=3D0x1
[   22.195857][  T113] __sata_set_spd_needed, spd=3D0x0
[   22.200936][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   22.206971][  T113] resume, do loop
[   22.434000][  T113] resume, after do loop
[   22.442642][  T113] debounce, SCR=3D0x123
[   22.451798][  T113] debounce, SCR=3D0x123
[   22.460779][  T113] debounce, SCR=3D0x123
[   22.469760][  T113] debounce, SCR=3D0x123
[   22.478720][  T113] debounce, SCR=3D0x123
[   22.487680][  T113] debounce, SCR=3D0x123
[   22.496641][  T113] debounce, SCR=3D0x123
[   22.505602][  T113] debounce, SCR=3D0x123
[   22.514563][  T113] debounce, SCR=3D0x123
[   22.523524][  T113] debounce, SCR=3D0x123
[   22.532504][  T113] debounce, SCR=3D0x123
[   22.541487][  T113] debounce, SCR=3D0x123
[   22.545429][  T113] resume, return at end of function
[   22.549320][  T113] hardreset, Offline=3D>Online
[   22.558885][  T113] hardreset, after check_ready
[   22.559103][  T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   22.570973][  T113] ata2.02: hard resetting link
[   22.575639][  T113] hardreset, Online=3D>Offline
[   22.575677][  T113] sata_set_spd_needed, scontrol=3D0x300
[   22.580148][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   22.585423][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   22.591724][  T113] __sata_set_spd_needed, target=3D0x1
[   22.597602][  T113] __sata_set_spd_needed, spd=3D0x0
[   22.602682][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   22.607608][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   22.613648][  T113] __sata_set_spd_needed, corrected limit=3D0x1
[   22.619968][  T113] __sata_set_spd_needed, target=3D0x1
[   22.625847][  T113] __sata_set_spd_needed, spd=3D0x0
[   22.630927][  T113] __sata_set_spd_needed, final *scontrol=3D0x310
[   22.636959][  T113] resume, do loop
[   22.864000][  T113] resume, after do loop
[   22.872642][  T113] debounce, SCR=3D0x0
[   22.881798][  T113] debounce, SCR=3D0x0
[   22.890603][  T113] debounce, SCR=3D0x0
[   22.899408][  T113] debounce, SCR=3D0x0
[   22.908194][  T113] debounce, SCR=3D0x0
[   22.916979][  T113] debounce, SCR=3D0x0
[   22.925766][  T113] debounce, SCR=3D0x0
[   22.934553][  T113] debounce, SCR=3D0x0
[   22.943339][  T113] debounce, SCR=3D0x0
[   22.952146][  T113] debounce, SCR=3D0x0
[   22.960953][  T113] debounce, SCR=3D0x0
[   22.969761][  T113] debounce, SCR=3D0x0
[   22.978547][  T113] debounce, SCR=3D0x0
[   22.982295][  T113] resume, return at end of function
[   22.986033][  T113] hardreset, ata_phys_link_offline check failed
[   22.991325][  T113] ata2.02: SATA link down (SStatus 0 SControl 300)
...
[   25.191319][  T113] ata2.07: SATA link down (SStatus 0 SControl 300)
[   25.204010][  T113] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, =
max UDMA/133
[   25.211624][  T113] ata2.00: 976773168 sectors, multi 0: LBA48=20
[=20  25.217741][  T113] ata2.00: configured for UDMA/133
[   25.222815][  T113] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA=
/133
[   25.229751][  T113] ata2.01: 23437498368 sectors, multi 0: LBA48=20
[   25.236026][  T113] ata2.01: configured for UDMA/133
[   25.241168][  T113] ata2: EH complete

Marius Dinu

