Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D03EC636CC
	for <linux-ide@archiver.kernel.org>; Wed,  8 Feb 2023 12:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBHMR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Feb 2023 07:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBHMR6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2023 07:17:58 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D128A5C
        for <linux-ide@vger.kernel.org>; Wed,  8 Feb 2023 04:17:57 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=Pbm4T0ADHxtDHcPexGMufwQz61HT9iJ7PERXFYiIkmA=;
        b=ZNo4wH+pI3OEXf7Du6lcy4pUppJerUA17BBuz3SVxLT1bk7P7DjzDJJo29Or+Li/3XRKfkFBKnzS1mwEoa0ZVPGa0VNrRWg+pLxSTJ+TimRu74mKcGSKRYc690esrE53wSP3+DkK9g1w2UTR75fbNSp1ke3BveofQ1EZTqCZOFy6GyKD026f+M7aHZE7JfduU9ZbZxhuzXPdp8N2+QrW8ALtYI7RHis99Ey5qCqeM3UzgKqA8yucbaen98
        kzGaSi/X8yfOLfr2uaH2UBsHVUjgWa09OIuYSM4yqvP/dzIBc61yWXB09TyjdXoQ15rjOEqaX6H+IP2fsTTWAhD4qUGQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Wed, 8 Feb 2023 12:17:55 +0000
MIME-Version: 1.0
Date:   Wed, 08 Feb 2023 12:17:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <235d8863945fb1da23c1e7b74831db38@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <023692b9-d980-82fd-26b9-01a734bd649f@opensource.wdc.com>
References: <023692b9-d980-82fd-26b9-01a734bd649f@opensource.wdc.com>
 <1e069565-a391-0f33-0714-ba9cc3792a42@opensource.wdc.com>
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
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
 <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
X-Originating-IP: 188.24.148.115
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

February 8, 2023 1:40 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> On 2023/02/08 3:40, marius@psihoexpert.ro wrote:
>
>> [ 173.591831] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 port=
s, feat 0xf/0x1f
>> [ 173.600838] ahci-mvebu f10a8000.sata: FBS is enabled
>> [ 173.605977] ata2.00: hard resetting link
>> [ 173.937078] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [ 173.943563] ata2.01: hard resetting link
>> [ 174.277073] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [ 174.283555] ata2.02: hard resetting link
>> [ 174.617075] ata2.02: SATA link down (SStatus 0 SControl 300)
>> [ 174.622787] ata2.03: hard resetting link
>> [ 174.957074] ata2.03: SATA link down (SStatus 0 SControl 300)
>> [ 174.962785] ata2.04: hard resetting link
>> [ 175.297075] ata2.04: SATA link down (SStatus 0 SControl 300)
>> [ 175.302784] ata2.05: hard resetting link
>> [ 175.637072] ata2.05: SATA link down (SStatus 0 SControl 300)
>> [ 175.642781] ata2.06: hard resetting link
>> [ 175.977071] ata2.06: SATA link down (SStatus 0 SControl 300)
>> [ 175.982781] ata2.07: hard resetting link
>> [ 176.317063] ata2.07: SATA link down (SStatus 0 SControl 300)
>=20
>=20That is weird too. No point in repeatedly resetting if the link is up=
. So the
> patch really screwed up something for 5.15.

Nothing weird here. There is one reset for each logical port. Only two po=
rts are used.

I'm going to insert the debug messages in this kernel version too and tes=
t again.

