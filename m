Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204DC05027
	for <linux-ide@archiver.kernel.org>; Mon, 23 Jan 2023 20:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAWUAs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjAWUAr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2023 15:00:47 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF1B30B11
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2023 12:00:40 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=kcyuPag3qYtoLmVx2mn48Gzsgig6N8v4yQvgZNI13/Y=;
        b=NOZt58Vf/tm6zd84Zre4hfPTFALJKy2IQ3VBw+/Ed9y9CHn6ufe57Fv1Cvj0z/iawV58Zsqfal/QSBn2PK9+KsHw4dTWGvxFe5mN6Ynsp/LoIGUosQQFWL8gQmgbvFEg+zKQ+K3ehoVPp3KFOp7b0+u4UggiDkUSiFCLN9KEiaaIuqwDvo//O/SmX1Mbu/zY677GUxQQCidvmt/2ks05BDtf7NWj4BWYdckU6MZhRUWPCFFNTb/d8AvQ/b
        iqsQRCNGuYw3iAcBYmHHP3ADMPXEQMi0XJbK2pQiv4XbVk9gTdyZ6VlNcyoeoFL5y6S+VKqVSOyF+1lr3dQ+Ooq89csQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Mon, 23 Jan 2023 20:00:38 +0000
MIME-Version: 1.0
Date:   Mon, 23 Jan 2023 20:00:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <cf5d33e3-995f-4346-b02a-b203ed94d9e3@opensource.wdc.com>
References: <cf5d33e3-995f-4346-b02a-b203ed94d9e3@opensource.wdc.com>
 <5171a47a-e508-1433-6975-8da5b27318b8@opensource.wdc.com>
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
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 23, 2023 9:02 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> But I think I got an idea of what is wrong here. Can you try this patch=
:
>=20
>=20diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 18ef14e749a0..cb12054c733f 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -436,7 +436,8 @@ static int __sata_set_spd_needed(struct ata_link
> *link, u32 *scontrol)
> limit &=3D (1 << host_link->sata_spd) - 1;
>=20
>=20if (limit =3D=3D UINT_MAX)
> - target =3D 0;
> + /* Try highest gen 3 limit */
> + target =3D 3;
> else
> target =3D fls(limit);

It doesn't work. I didn't really expect it to work, since manually forcin=
g 3Gbps didn't work either - probably a hardware issue like you said.

I think that the old behaviour (before commit 2dc0b46b5ea30f169b0b272253e=
a846a5a281731) of slowing down sata speed when a connection can't be esta=
blished is in fact the right thing to do. Maybe a longer delay before red=
ucing the link speed would satisfy the random cases that the commit autho=
r reported. Maybe he was just having a loose connector issue - especially=
 since he only reported one case.

Marius Dinu

