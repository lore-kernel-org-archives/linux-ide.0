Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CAC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 15 Nov 2022 07:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiKOH2r (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Nov 2022 02:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiKOH2n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2022 02:28:43 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C7D190
        for <linux-ide@vger.kernel.org>; Mon, 14 Nov 2022 23:28:40 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=n5UClgSx+1p3hPU7wyb8rN+fZWCwtZXhv1goqxjg5DU=;
        b=OulRrJO2QQ/Ki8PBBaTuj2OQ1SOXzIVf/x8C6ROwTdIlILQSFcbaWff+Qv+e2d6sntCwj3ozQEI2XC0fQXzp36WW7V+L3cHEW645eYSW8prhNjdFVpHnuQRJbHAyXR50avNnDiSkFNdyn1i7Ca7zVuFbacVFmcWqS56S7HoMb8i/jQxo6cenK9CSEUMtx3pwBtZCgIUp3ccYhw47vWBdulummA19H2JdDSBYfj0VMrg21EOd2w/H3EmwU+
        v+MwirLl6CHAcxBVRQeR06YGgljawVfcDSIhVsYmPcM14xssz0yzBtWf0eeDjUha4Go3uAfP6KBYhWg0QTh66wTDR4sQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 15 Nov 2022 07:28:38 +0000
MIME-Version: 1.0
Date:   Tue, 15 Nov 2022 07:28:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
References: <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
X-Originating-IP: 86.122.18.201
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

November 15, 2022 5:02 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> So something is going on at the hardware level here. The register value=
 is
> not stable... You could try playing with the sleep interval (unsigned l=
ong
> interval =3D params[0];) and duration (unsigned long duration =3D param=
s[1];)
> to see if anything changes. Especially try reducing and increasing inte=
rval.
> --
> Damien Le Moal
> Western Digital Research

What are the defaults? Are these defaults the same for all sata/ahci cont=
rollers? How much can I increase them? Will anything break?

What could be the cause of this? sata cable? Power source?
BTW, while doing the testing, I saw the same error with the laptop HDD. I=
 disconnected the cable and then reconnected it, and the second time it w=
as detected OK. Unfortunately, I wasn't capturing serial messages and I c=
ouldn't make it happen again.

Marius Dinu

