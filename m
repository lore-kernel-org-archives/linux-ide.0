Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776CC05027
	for <linux-ide@archiver.kernel.org>; Sun, 29 Jan 2023 10:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjA2KYj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 29 Jan 2023 05:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2KYj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2023 05:24:39 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1120047
        for <linux-ide@vger.kernel.org>; Sun, 29 Jan 2023 02:24:36 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=0IMP6KC0hI/KyEZSknx5C8Hk81O6rOEUXxnff79kl2o=;
        b=T6KjA5xotR1n65YUPjbMxKwzOLuPP/ejOFgkP+PvFCv5VK/Vo66LvwpCu0wz6YuN/F3r3iIfHNf2X+yQyx3zieVgKopuOuVbMLo4rUsYuOg9ejnxwmY64p+OaxG/3f9frAB2TIxztPdchAnQ5abEY96mGB35tMlCHR/olP5FRVhsoGh8wEgTAbUgwU6VWFdlMNeFNUMlz3MLnt9cqupKPLo2iimgDPa7s5Z2n3PLmBr8Rskonm+EV52Idj
        l6uyHuWbSjoaqap/FL3SxPcdjA7lxcpbLx1naJVZq+TcyZOen0YbJab+fBoCuxG0mtvCR3nWGnZt8hda37XJMhpbPh1A==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sun, 29 Jan 2023 10:24:33 +0000
MIME-Version: 1.0
Date:   Sun, 29 Jan 2023 10:24:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <ceb87cfa-b9f9-525b-bd85-9728833e8687@opensource.wdc.com>
References: <ceb87cfa-b9f9-525b-bd85-9728833e8687@opensource.wdc.com>
 <fbbbad64-482e-93eb-14e7-01b54a92d2b3@opensource.wdc.com>
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
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 29, 2023 4:25 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:
>
> OK. That is because the limit is not being changed with the added "retu=
rn 0".
> What about this version:
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..f404e2c2869e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3085,10 +3085,31 @@ int sata_down_spd_limit(struct ata_link *link, =
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
> + * If we reach here, the device is still offline or not
> + * reporting a current speed yet. If we do not have a recorded
> + * speed either, it means that probing the drive is failing,
> + * most likely because problem with link speed autonegotiation
> + * (e.g. reported case with mvebu adapter with a port multiplier
> + * device). In this case, assume that probing was done at Gen3
> + * speed and set the speed limit to the lower Gen2 speed.
> + * With this, the next probe retry will be done after
> + * sata_set_spd() explicitly lowers the link speed. If the
> + * device then responds, the actual maximum speed will be set
> + * once libata-eh finishes the device revalidation.
> + */
> + if (!link->sata_spd && link->sata_spd_limit =3D=3D UINT_MAX) {
> + link->sata_spd_limit =3D 2;
> + ata_link_warn(link,
> + "No reported SATA link speed. Limiting to
> %s\n",
> + sata_spd_string(link->sata_spd_limit));
> + return 0;
> + }
> spd =3D link->sata_spd;
> + }
>=20
>=20mask =3D link->sata_spd_limit;
> if (mask <=3D 1)
>=20
>=20Does this work ?
>=20
>=20--
> Damien Le Moal
> Western Digital Research


No, it doesn't work.

[   29.743388][  T113] hardreset, Online=3D>Offline
[   29.743397][  T113] sata_set_spd_needed, scontrol=3D0x300
[   29.747893][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   29.753149][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   29.759464][  T113] __sata_set_spd_needed, target=3D0x0
[   29.765953][  T113] __sata_set_spd_needed, spd=3D0x0
[   29.771033][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   29.776937][  T113] resume, do loop
[   30.003803][  T113] resume, after do loop
[   30.063823][  T113] debounce, SCR=3D0x100
...
[   31.443802][  T113] debounce, SCR=3D0x100
[   31.447663][  T113] resume, return at end of function
[   31.451522][  T113] hardreset, ata_phys_link_offline check failed
[   31.456625][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[   31.469093][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   31.478986][  T113] ata2: No reported SATA link speed. Limiting to 3.0=
 Gbps
[   31.486004][  T113] hardreset, Online=3D>Offline
[   31.486010][  T113] sata_set_spd_needed, scontrol=3D0x300
[   31.490479][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   31.495747][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   31.501437][  T113] __sata_set_spd_needed, target=3D0x2
[   31.507321][  T113] __sata_set_spd_needed, spd=3D0x0
[   31.512401][  T113] __sata_set_spd_needed, final *scontrol=3D0x320
[   31.517233][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   31.523272][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   31.528975][  T113] __sata_set_spd_needed, target=3D0x2
[   31.534852][  T113] __sata_set_spd_needed, spd=3D0x0
[   31.539933][  T113] __sata_set_spd_needed, final *scontrol=3D0x324
[   31.545834][  T113] resume, do loop
[   31.773802][  T113] resume, after do loop
[   31.833802][  T113] debounce, SCR=3D0x101
...
[   32.433802][  T113] debounce, SCR=3D0x100
[   32.437663][  T113] resume, return at end of function
[   32.441522][  T113] hardreset, ata_phys_link_offline check failed
[   32.446624][  T113] ata2: SATA link down (SStatus 100 SControl 320)
[   32.459090][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   32.468982][  T113] ata2: No reported SATA link speed. Limiting to 3.0=
 Gbps
[   32.475999][  T113] hardreset, Online=3D>Offline
[   32.476005][  T113] sata_set_spd_needed, scontrol=3D0x320
[   32.480474][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   32.485741][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   32.491432][  T113] __sata_set_spd_needed, target=3D0x2
[   32.497315][  T113] __sata_set_spd_needed, spd=3D0x2
[   32.502395][  T113] __sata_set_spd_needed, final *scontrol=3D0x320
[   32.508296][  T113] resume, do loop
[   32.743801][  T113] resume, after do loop
[   32.803802][  T113] debounce, SCR=3D0x100
...
[   34.423802][  T113] debounce, SCR=3D0x100
[   34.427662][  T113] resume, return at end of function
[   34.431520][  T113] hardreset, ata_phys_link_offline check failed
[   34.436624][  T113] ata2: SATA link down (SStatus 100 SControl 320)
[   34.449088][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   34.458981][  T113] ata2: No reported SATA link speed. Limiting to 3.0=
 Gbps
[   34.465998][  T113] hardreset, Online=3D>Offline
[   34.466004][  T113] sata_set_spd_needed, scontrol=3D0x320
[   34.470473][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   34.475740][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   34.481430][  T113] __sata_set_spd_needed, target=3D0x2
[   34.487314][  T113] __sata_set_spd_needed, spd=3D0x2
[   34.492393][  T113] __sata_set_spd_needed, final *scontrol=3D0x320
[   34.498294][  T113] resume, do loop
[   34.723823][  T113] resume, after do loop
[   34.783802][  T113] debounce, SCR=3D0x101
...
[   36.763802][  T113] debounce, SCR=3D0x100
[   36.767662][  T113] debounce, loop end with timeout
[   36.771521][  T113] hardreset, sata_link_resume check failed
[   36.776445][  T113] ata2: COMRESET failed (errno=3D-32)
[   36.787224][  T113] ata2: reset failed (errno=3D-32), retrying in 8 se=
cs
[   44.643801][  T113] sata_down_spd_limit: limit 0x0, cur spd 0x0, saved=
 limit 0x2, hw limit 0xffffffff
[   44.653073][  T113] hardreset, Online=3D>Offline
[   44.653079][  T113] sata_set_spd_needed, scontrol=3D0x320
[   44.657569][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   44.662823][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   44.668527][  T113] __sata_set_spd_needed, target=3D0x2
[   44.674403][  T113] __sata_set_spd_needed, spd=3D0x2
[   44.679484][  T113] __sata_set_spd_needed, final *scontrol=3D0x320
[   44.685385][  T113] resume, do loop
[   44.913802][  T113] resume, after do loop
[   44.973802][  T113] debounce, SCR=3D0x100
...
[   46.233802][  T113] debounce, SCR=3D0x100
[   46.237663][  T113] resume, return at end of function
[   46.241520][  T113] hardreset, ata_phys_link_offline check failed
[   46.246622][  T113] ata2: SATA link down (SStatus 100 SControl 320)
[   46.259088][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   46.268981][  T113] ata2: No reported SATA link speed. Limiting to 3.0=
 Gbps
[   46.275997][  T113] hardreset, Online=3D>Offline
[   46.276003][  T113] sata_set_spd_needed, scontrol=3D0x320
[   46.280473][  T113] __sata_set_spd_needed, initial limit=3D0x2
[   46.285740][  T113] __sata_set_spd_needed, corrected limit=3D0x2
[   46.291430][  T113] __sata_set_spd_needed, target=3D0x2
[   46.297314][  T113] __sata_set_spd_needed, spd=3D0x2
[   46.302394][  T113] __sata_set_spd_needed, final *scontrol=3D0x320
[   46.308296][  T113] resume, do loop
[   46.543802][  T113] resume, after do loop
[   46.603802][  T113] debounce, SCR=3D0x100
...
[   47.683802][  T113] debounce, SCR=3D0x100
[   47.687662][  T113] resume, return at end of function
[   47.691520][  T113] hardreset, ata_phys_link_offline check failed
[   47.696636][  T113] ata2: SATA link down (SStatus 101 SControl 320)
[   47.709086][  T113] ata2: EH pending after 5 tries, giving up

Marius Dinu

