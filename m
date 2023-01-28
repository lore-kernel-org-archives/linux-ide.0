Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB4C27C76
	for <linux-ide@archiver.kernel.org>; Sat, 28 Jan 2023 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjA1RI4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 28 Jan 2023 12:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjA1RIz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jan 2023 12:08:55 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E497224CAD
        for <linux-ide@vger.kernel.org>; Sat, 28 Jan 2023 09:08:52 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=61muY3k6saQDFZ+uhGgHSTVF5U8c9KzlRxGVmGPD1FE=;
        b=Rju6+xGW/SqQu1IY8/5ptopgSZDaU1badsazzB4mYK8j01sqxkBDt0j5CPRVkBz1aUaJFkGEAJW+Ys0XHajwrdIPUUZVv6kkDyRUTINSd01WMvLtYJx1MOO2Ai/3eoifFV0Mdi+LvKV62fooYR9/JWE+Xzp3IEvdPMskujFpyoLS2jSKTNSeOsCsFmBBhHlElxTMn5gpwEl9IpbZyVZw4zU4910JMrD9D0LiE8/v1XlPtlLY3aPXPWa6LB
        dN8kzjzkFmUy0iLRanakSVl2+tX9KLXhgXJivMTNjJYxBrQd4CN7wDc8PROp02SmbGdfNpPtWt7LfruVqTs0d5TpVwKg==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sat, 28 Jan 2023 17:08:51 +0000
MIME-Version: 1.0
Date:   Sat, 28 Jan 2023 17:08:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <fbbbad64-482e-93eb-14e7-01b54a92d2b3@opensource.wdc.com>
References: <fbbbad64-482e-93eb-14e7-01b54a92d2b3@opensource.wdc.com>
 <f4d558fd-343a-8cb5-605d-574af42ad3db@opensource.wdc.com>
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
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 27, 2023 8:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> On 1/27/23 14:13, Damien Le Moal wrote:
>=20
>>=20Marius,
>>=20
>>=20Thanks again for testing.
>> Could you try a new variation of the fix shown below ? This newer fix
>> should avoid uselessly going down to 1.5 Gbps as shown above.
>> Thanks !
>>=20
>>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 884ae73b11ea..04938db566e5 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -3085,10 +3085,31 @@ int sata_down_spd_limit(struct ata_link *link,=
 u32
>> spd_limit)
>> * If not, use cached value in link->sata_spd.
>> */
>> rc =3D sata_scr_read(link, SCR_STATUS, &sstatus);
>> - if (rc =3D=3D 0 && ata_sstatus_online(sstatus))
>> + if (rc =3D=3D 0 && ata_sstatus_online(sstatus)) {
>> spd =3D (sstatus >> 4) & 0xf;
>> - else
>> + } else {
>> + /*
>> + * If we reach here, the device is still offline or not
>> + * reporting a current speed yet. If we do not have a recorded
>> + * speed either, it means that probing the drive is failing,
>> + * most likely because problem with link speed autonegotiation
>> + * (e.g. reported case with mvebu adapter with a port multiplier
>> + * device). In this case, assume that probing was done at Gen3
>> + * speed and set the recorded speed to lower Gen2. With this,
>> + * the next probe retry will be done after sata_set_spd()
>> + * explicitly lowers the link speed. If the device then
>> + * responds, the actual maximum speed will be set once
>> + * libata-eh finishes the device revalidation.
>> + */
>> + if (!link->sata_spd) {
>> + link->sata_spd =3D 2;
>> + ata_link_warn(link,
>> + "No reported link speed. Assuming %s\n",
>> + sata_spd_string(link->sata_spd));
>> + return;
>=20
>=20Oops. My bad. This should be "return 0;" of course.
>=20
>>=20+ }
>> spd =3D link->sata_spd;
>> + }
>>=20
>>=20mask =3D link->sata_spd_limit;
>> if (mask <=3D 1)
>=20
>=20--
> Damien Le Moal
> Western Digital Research


It doesn't work.

[   15.145150][  T113] hardreset, Online=3D>Offline
[   15.145159][  T113] sata_set_spd_needed, scontrol=3D0x300
[   15.149632][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   15.154910][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   15.161211][  T113] __sata_set_spd_needed, target=3D0x0
[   15.167700][  T113] __sata_set_spd_needed, spd=3D0x0
[   15.172781][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   15.178685][  T113] resume, do loop
[   15.413909][  T113] resume, after do loop
[   15.473909][  T113] debounce, SCR=3D0x100
..
[   16.553930][  T113] debounce, SCR=3D0x100
[   16.557791][  T113] resume, return at end of function
[   16.561650][  T113] hardreset, ata_phys_link_offline check failed
[   16.566754][  T113] ata2: SATA link down (SStatus 101 SControl 300)
[   16.579222][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   16.589115][  T113] ata2: No reported link speed. Assuming 3.0 Gbps
[   16.595436][  T113] hardreset, Online=3D>Offline
[   16.595442][  T113] sata_set_spd_needed, scontrol=3D0x300
[   16.599911][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   16.605178][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   16.611479][  T113] __sata_set_spd_needed, target=3D0x0
[   16.617975][  T113] __sata_set_spd_needed, spd=3D0x0
[   16.623055][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   16.628957][  T113] resume, do loop
[   16.863910][  T113] resume, after do loop
[   16.923909][  T113] debounce, SCR=3D0x100
...
[   18.123908][  T113] debounce, SCR=3D0x100
[   18.127770][  T113] resume, return at end of function
[   18.131628][  T113] hardreset, ata_phys_link_offline check failed
[   18.136731][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[   18.149196][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   18.159089][  T113] ata2: No reported link speed. Assuming 3.0 Gbps
[   18.165409][  T113] hardreset, Online=3D>Offline
[   18.165415][  T113] sata_set_spd_needed, scontrol=3D0x300
[   18.169884][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   18.175151][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   18.181451][  T113] __sata_set_spd_needed, target=3D0x0
[   18.187946][  T113] __sata_set_spd_needed, spd=3D0x0
[   18.193025][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   18.198927][  T113] resume, do loop
[   18.433909][  T113] resume, after do loop
[   18.493909][  T113] debounce, SCR=3D0x100
...
[   20.413909][  T113] debounce, SCR=3D0x100
[   20.417768][  T113] resume, return at end of function
[   20.421627][  T113] hardreset, ata_phys_link_offline check failed
[   20.426730][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[   20.439196][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   20.449089][  T113] ata2: No reported link speed. Assuming 3.0 Gbps
[   20.455409][  T113] hardreset, Online=3D>Offline
[   20.455415][  T113] sata_set_spd_needed, scontrol=3D0x300
[   20.459884][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   20.465151][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   20.471452][  T113] __sata_set_spd_needed, target=3D0x0
[   20.477947][  T113] __sata_set_spd_needed, spd=3D0x0
[   20.483027][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   20.488929][  T113] resume, do loop
[   20.723909][  T113] resume, after do loop
[   20.783909][  T113] debounce, SCR=3D0x0
[   20.843909][  T113] debounce, SCR=3D0x0
[   20.903909][  T113] debounce, SCR=3D0x0
[   20.963909][  T113] debounce, SCR=3D0x0
[   21.023909][  T113] debounce, SCR=3D0x100
[   21.083909][  T113] debounce, SCR=3D0x100
[   21.143909][  T113] debounce, SCR=3D0x100
[   21.203929][  T113] debounce, SCR=3D0x100
[   21.263909][  T113] debounce, SCR=3D0x100
[   21.267768][  T113] resume, return at end of function
[   21.271626][  T113] hardreset, ata_phys_link_offline check failed
[   21.276728][  T113] ata2: SATA link down (SStatus 101 SControl 300)
[   21.289194][  T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved=
 limit 0xffffffff, hw limit 0xffffffff
[   21.299086][  T113] ata2: No reported link speed. Assuming 3.0 Gbps
[   21.305407][  T113] hardreset, Online=3D>Offline
[   21.305413][  T113] sata_set_spd_needed, scontrol=3D0x300
[   21.309882][  T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[   21.315149][  T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
[   21.321448][  T113] __sata_set_spd_needed, target=3D0x0
[   21.327943][  T113] __sata_set_spd_needed, spd=3D0x0
[   21.333024][  T113] __sata_set_spd_needed, final *scontrol=3D0x300
[   21.338925][  T113] resume, do loop
[   21.573909][  T113] resume, after do loop
[   21.633909][  T113] debounce, SCR=3D0x101
...
[   22.893908][  T113] debounce, SCR=3D0x100
[   22.897769][  T113] resume, return at end of function
[   22.901628][  T113] hardreset, ata_phys_link_offline check failed
[   22.906731][  T113] ata2: SATA link down (SStatus 100 SControl 300)
[   22.919179][  T113] ata2: EH pending after 5 tries, giving up

