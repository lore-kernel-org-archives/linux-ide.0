Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD0AC4332F
	for <linux-ide@archiver.kernel.org>; Sun,  4 Dec 2022 21:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLDVO0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 4 Dec 2022 16:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDVOZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Dec 2022 16:14:25 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061541181C
        for <linux-ide@vger.kernel.org>; Sun,  4 Dec 2022 13:14:21 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=6O/Pd4pLjbYzmC2WdS8GZ5BOWKO72HytFcOzxHjcKt0=;
        b=AgV9SbLCYJPukKTvRiqzk5r4qs6MXCcl7z0VrFU/LX20ejdNwXl1Mf8pB//fy3t4Ddriu7ioqOm0ThWLl/e8Q9uHCv89FHY6w+mO2EP62ergUWL8w2tDuCanyUKPDppU4GJJuHFmTJ4btzTXgZTSpPXvJlTfYhim3+G7u5Y0fJIVB25hlMgj18q6ifoOdyueb57HEEW3PVNGsiEKIq7m12QRM1RUUEuBSuK7M9r4ZKAG83XpiUX6YyNMcK
        NVHeQkjzLQTbJkWWJ0bMi5cBRM8KhLwWB8Xa69djIQFys/Sos7B/qZBvKzLeQlGrq1XpTlUBRSTkezE1MLPNvGijyiSQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sun, 4 Dec 2022 21:14:13 +0000
MIME-Version: 1.0
Date:   Sun, 04 Dec 2022 21:14:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <ed1841a08205d417e2e9866479878b29@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "=?utf-8?B?UGFsaSBSb2jDoXI=?=" <pali@kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <20221204102235.n4z2fjmxk5hbjiwd@pali>
References: <20221204102235.n4z2fjmxk5hbjiwd@pali>
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
X-Originating-IP: 84.232.129.15
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

December 4, 2022 12:23 PM, "Pali Roh=C3=A1r" <pali@kernel.org> wrote:

>> What next? Should I contact David Milburn <dmilburn@redhat.com> (the c=
ommit author) and ask for a
>> better fix?
>=20
>=20That is a good idea.

I think I'll wait for an opinion from Damien. Since the same libata-core.=
c works perfectly fine with sata-mv driver, but not ahci-mvebu, the probl=
em might still be in the ahci-mvebu. The comment said: "sata_down_spd_lim=
it should return if driver has not recorded sstatus speed". This probably=
 means that ahci-mvebu does not record the expected "sstatus speed". I do=
n't know what that is, but Damien probably does.

>> @ Pali Rohar:
>> I could't find the errata you mentioned. If you have it, please take a=
 look at the commit above and
>> see if it is affected in any. Thanks.
>=20
>=20I do not have more details than what I already wrote in previous emai=
l.
>=20
>=20Errata documents are in most cases available on Marvell Customer Port=
al.
> You need to register for accessing them. https://www.marvell.com/portal
>=20
>=20Documents which were available publicly without registration are here=
:
> https://www.kernel.org/doc/html/latest/arm/marvell.html
> (errata for a38x was not publicly available)

There is a slim chance that I could understand them. I'm just an amateur.=
 I did some bare-metal programming on MCUs, but the kernel is way too com=
plicated for me.

