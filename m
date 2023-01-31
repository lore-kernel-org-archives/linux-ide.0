Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24274C636CC
	for <linux-ide@archiver.kernel.org>; Tue, 31 Jan 2023 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAaHVK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAaHVJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2023 02:21:09 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4AF2BF04
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 23:21:00 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=1XqxIWjdf5GC4f+By2KUG4i+s+Og9prkocgvmumvsGI=;
        b=b9aaKD4dO+GL+rgsKK4ZrjAb5i0wBbaLOlapiEw31loKIV65gHvTVqtVScOccG3vM+VB0YmGS2cn1Gp+fBQui/uEmHDxmRvybYSgB75S57liYjVf75y8fQk8uztUylebXLxSmNOUUPkSJ12R8lCrf1U5sM6yUcCLlUEBJrax2Y4Gvtk1Q2ub83W7RuztN4jF9s+7slMUrRKKITUK6GSSnxiocrQml9DkdXZqi47aVpF5hC2EZMA9JShj4w
        3xdx1gP/5k8J3drOXg84ODjW/tQ2aF50OTwWVoAI4uQPzXC92g9JMMzR6e6pqg0VVSbCoRNA/zYqgGZpEJIA1OPhPhlA==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 31 Jan 2023 07:20:58 +0000
MIME-Version: 1.0
Date:   Tue, 31 Jan 2023 07:20:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <1831eb01-5c84-54f1-7950-9b8e9bf0a046@opensource.wdc.com>
References: <1831eb01-5c84-54f1-7950-9b8e9bf0a046@opensource.wdc.com>
 <3c508c6e-5377-bb2d-64df-407f73a8170a@opensource.wdc.com>
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
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
X-Originating-IP: 188.24.142.89
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 31, 2023 1:22 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:
>=20
>=20I sent the official patch and CC-ed you. Can I add your
> "Tested-by: Marius Dinu <marius@psihoexpert.ro>" tag to the patch and q=
ueue it ?
>=20
>=20--
> Damien Le Moal
> Western Digital Research

Yes, I was planning to reply myself, but I'm not done testing yet. At thi=
s point I can only say it's working on mvebu / Armada 385. I plan to back=
port to v5.15 and test with the other router that I have (mvebu / Armada =
XP), a laptop and two x86_64 desktops, one of which has various PATA and =
SATA controllers in all sorts of weird configurations. I hope to do it al=
l this weekend.
Thank you for the patch!

Marius Dinu

