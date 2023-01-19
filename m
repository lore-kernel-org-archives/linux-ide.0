Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC07C004D4
	for <linux-ide@archiver.kernel.org>; Thu, 19 Jan 2023 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASSqV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjASSqR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2023 13:46:17 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B38EFCF
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2023 10:46:13 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=3jWMwbQELGSJL5Oh+RACcldqeqk6F20JAmJFc0PTVs4=;
        b=T6fDG7SqMn+QQFZy9u9bLZyOrIcAwn/b6CWZTHop3QMSRWaCf3l0Tbm+iUhfYVLfPtapxA7ovdab9M9fDi76iWZxYb1EOyeWoEdH3HfFAQ91imPoQGiPuEjIR4A92RP5dFt63+Ie2t1V4OrtKxlfxDjKylxzUMS70vFqIu0Z+Ia2ODdADhGkTWHOeSFGPyHxoNXBahlrSFYJWz7vSBMxopk9OXxadHZa+1ZlFakD96RtMQrmQ9PxTuzy8D
        hM//Z3cb9EuVbndkZdgIBSuoFxCruklxNdDuUqkJ0bSi5SbJjROxeYkjC4d7Kxcf6vaGMQDyPPs5V66zWif5tVkox5aQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Thu, 19 Jan 2023 18:46:09 +0000
MIME-Version: 1.0
Date:   Thu, 19 Jan 2023 18:46:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <5171a47a-e508-1433-6975-8da5b27318b8@opensource.wdc.com>
References: <5171a47a-e508-1433-6975-8da5b27318b8@opensource.wdc.com>
 <41774337-a8d9-a2de-72ea-27b6016ff720@opensource.wdc.com>
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
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
X-Originating-IP: 86.123.22.43
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 19, 2023 2:29 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> On 2023/01/19 4:43, marius@psihoexpert.ro wrote:
>=20
>>=20[ 73.075849][ T112] hardreset, Online=3D>Offline
>> [ 73.075856][ T112] sata_set_spd_needed, scontrol=3D0x300
>> [ 73.080328][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
>> [ 73.085601][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFF=
F
>> [ 73.091900][ T112] __sata_set_spd_needed, target=3D0x0
>> [ 73.098386][ T112] __sata_set_spd_needed, spd=3D0x0
>> [ 73.103475][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
>=20
>=20Can you share the patch/diff printing these ? Just to be sure I look =
at the
> right place :)

--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -427,6 +430,7 @@ static int __sata_set_spd_needed(struct ata_link *lin=
k, u32 *scontrol)
        u32 limit, target, spd;

        limit =3D link->sata_spd_limit;
+       printk(KERN_DEBUG "__sata_set_spd_needed, initial limit=3D0x%X",l=
imit);

        /* Don't configure downstream link faster than upstream link.
         * It doesn't speed up anything and some PMPs choke on such
@@ -435,14 +439,18 @@ static int __sata_set_spd_needed(struct ata_link *l=
ink, u32 *scontrol)
        if (!ata_is_host_link(link) && host_link->sata_spd)
                limit &=3D (1 << host_link->sata_spd) - 1;

+       printk(KERN_DEBUG "__sata_set_spd_needed, corrected limit=3D0x%X"=
,limit);
        if (limit =3D=3D UINT_MAX)
                target =3D 0;
        else
                target =3D fls(limit);

+       printk(KERN_DEBUG "__sata_set_spd_needed, target=3D0x%X",target);
        spd =3D (*scontrol >> 4) & 0xf;
        *scontrol =3D (*scontrol & ~0xf0) | ((target & 0xf) << 4);

+       printk(KERN_DEBUG "__sata_set_spd_needed, spd=3D0x%X",spd);
+       printk(KERN_DEBUG "__sata_set_spd_needed, final *scontrol=3D0x%X"=
,*scontrol);
        return spd !=3D target;
 }

@@ -467,6 +475,7 @@ static int sata_set_spd_needed(struct ata_link *link)

        if (sata_scr_read(link, SCR_CONTROL, &scontrol))
                return 1;
+       printk(KERN_DEBUG "sata_set_spd_needed, scontrol=3D0x%X",scontrol=
);

        return __sata_set_spd_needed(link, &scontrol);
 }

Marius Dinu

