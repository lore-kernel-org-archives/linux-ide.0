Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7484C636D3
	for <linux-ide@archiver.kernel.org>; Sun, 12 Feb 2023 13:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBLNOd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 08:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLNOd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 08:14:33 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2C1166E
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 05:14:30 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=3BYe3MxZYF19FD4EUdyEXtuboaohVu5JjW/YqG4NzCc=;
        b=XxvF9/ps9e14dxoIeGTnVIRba/efcm4IslefYBe77rbG/nmqzJXzMFgcNZHEbi1edQQ6KB/hTkk4gLJDCWO1TbiQlbc72OLgPgmhAJTrHB7l2UqNGF3aZdqhHSf5pEjzTcqAv8NdqYmkBt+gTpl6YoXTsMqIV0O6TPMgfaVi9zVeE1q7LOx3blht4cbNJBg1Sn10Mke0M94qRVXpoLxbl3S02nq05CfiUtEuObZ1Gur3Okwo89FklZQTHR
        HnqWCBeG00114vzyrMUlkEk0ZzC9f/Odwfnny5c8fjcsO/fu6vK3JmrYbnuuAT6d4ePpzAGgiKYO8AeRYBoIJ+3x09FQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Sun, 12 Feb 2023 13:14:29 +0000
MIME-Version: 1.0
Date:   Sun, 12 Feb 2023 13:14:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <5ed3c6c0b6ca71ad45d269e615c33622@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <f9781af4-667b-197b-807d-970df77286b6@opensource.wdc.com>
References: <f9781af4-667b-197b-807d-970df77286b6@opensource.wdc.com>
 <023692b9-d980-82fd-26b9-01a734bd649f@opensource.wdc.com>
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
 <235d8863945fb1da23c1e7b74831db38@psihoexpert.ro>
X-Originating-IP: 188.24.148.115
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

February 9, 2023 1:00 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> Thanks. Did you test the other LTS 6.1 kernel too ? The patch was backp=
orted
> there too.
>=20
>=20--
> Damien Le Moal
> Western Digital Research


I tested the patch applied to github tags "v6.1" and "v5.15". They both w=
ork fine.

I build another OpenWrt image and it doesn't work. I don't know why and i=
t's difficult to add modifications into OpenWrt kernel, because the kerne=
l sources don't persist. The build system erases everything, unpacks fres=
h kernel sources and then patches them. To make any modification I have t=
o add .diff files into the patches dir and build again, write the new fir=
mware into the router flash, test, etc. It's very slow.
I think I'm going to leave it as it is and limit the speed from the kerne=
l command line until OpenWrt updates the kernel.

Thank you for your help.
Marius Dinu

