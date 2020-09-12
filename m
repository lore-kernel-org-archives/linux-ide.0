Return-Path: <SRS0=DfDP=CV=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5002C433E2
	for <linux-ide@archiver.kernel.org>; Sat, 12 Sep 2020 10:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9221A21D7E
	for <linux-ide@archiver.kernel.org>; Sat, 12 Sep 2020 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kTCD1jtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILKvz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 12 Sep 2020 06:51:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:48153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgILKvx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 12 Sep 2020 06:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599907905;
        bh=SuZQc4F1e50rQLUc+N9sxG+irJvw7Qea6IpD11Cajgk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=kTCD1jtQn8s+OqLBE4Xxgk3ttI0jKDVxlwaBp5IJO7M68uQuezlsFJO3/pqsj5N1M
         pgE8aIUZirnhuu3XMZP/Q/PlkcMMJ9SV0l4UJgWZuQ5NzdbJfroQy35jqDx46iExNl
         REUYRAo+/Zz8fEA3pc+C1b0H+7NQccUeTi0Ep1mE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.134.185]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1k04Tj3MX4-00IGvG; Sat, 12
 Sep 2020 12:51:45 +0200
Date:   Sat, 12 Sep 2020 12:51:43 +0200
From:   Helge Deller <deller@gmx.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH] ata: pata_ns87415.c: Driver works on parisc with superio chip
Message-ID: <20200912105143.GA28477@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:Ybu7Xv23dKbjvX7adwSRR7TxxEs0uGjyYuudEcU9u8hPhBwaFLm
 YRy9B9tAo2zgr4JlAbLNDhdK3ILOODLereOCr4jHbhmVZofb4oLhIXvJHe5H++wEyLF00ft
 PgHcjIp69YNSfpFKA3f5buSjC+t9Vr1xX+bLRFnlEOj/xLvXcJa74Wv3njI70i21FNOcgnY
 oZGXe/EZTgdZchPCPP+kA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NtNyMhJge4E=:zOfek3GMjPfhSWw5jkaMSQ
 FIeCsWBIkTmtsAEEzqSgrOJsNkLgYawk+P8n8HExf71eZbMCx2O8xQYhN7whdBA7zZtTZEfoB
 eeVfjLDpX8V6BG8UJfUyyd5kFRlezrBJKWnB77vP7UoKs0WI0lwOwm7Qerse7xbmdjN9iy7cb
 2kaYA7wldo8n5k9t3KXDtsUuz4WdXBbi2OfHYCYtTS6paV7tyLTDty3uVOLpWZyUwNLuKl/aV
 4+GiM9dRxFeqtKOYVcA+UlCyCOaXkDmYMbOkFDXYhdgAmDk7hXlu6r/4zufyvHJov4qro8hF9
 AHWJol9XDxUcQETgTOIDfiGzBQ1YbwMdqda9UXUFfZZ9Ea9gMJCeq5Zw+t3Osvu+/tIMKKRCC
 npbGphn7fSVde95TUITWAMhflKHk/Y6P3nqlo/xQywX5vMb+xwG5wpx8KGSmGsGQOCbBgMxMA
 X7v4V76ABgKdek5TRzutu0DWUPqhuZ1BCRS14/jX9v9mprJhN4DaWvCUhxaAeqjwVBKAio0dp
 g+F3PK9NqqwbwukKA0lqbbkV3GhM53V03ZnQ7S2hFkVoaYe1wsP3Pe0fpWhcZxqgO8y40kRdk
 tcLbhv4MLyZYAOx27KuSEstFNycUUzsK85t8cqJv6z/6O9638sDaqCtXuTbULa/l59szb0riq
 4kvl6jeyvp4nFeiMM7KMxYTPtSqFVPHLHCVzS4dLsEtZcnxSSj1mV9SzM6SYFC8zDpGzPWyZW
 PrZhcgFW5NCavQHwS9Pr3CuXA7h+Gdi8VClFWMm+4rZYaVXHbT+f8T9HJOxotna/7qWIXibm8
 wfldNSPNvucQTOug9x90G7/K2q5wRbkkiziWM7yKRCMhovV+ew33xTcvk7PLUGmWtxyfZtXOE
 kyjwzKyc715QJS1FYMwdJAE6GCSRX+O5rEip2tpiCI8FkpYUOBSnNYE1gDrogjUZiq2AhFICu
 Rv5CRCBdlMtUDF/gTwpO3kSSV6e7y/Ap3+8+vp5yg2ce2LgMbMyBiwXKk6qtBSIxaNkmOoH0p
 E8Pk5DMuICh2xUCZu/ImXssPZP2PbHg5opZLmUzdunB8Ryw+ordrVrVEY2k1GuqHQMVjStLEK
 7+rg2qv9Xs62NE4oSLJ68jizcNvvqPUo5nRpENedSpnAZBhW/+a1Dn+/JPLmmjUpPmA5mjfml
 7BL1uovYmsG5DQlG4BjoYggOA6Rug79llM54Y6kaIeHAnn/OOk2qzD8KepJVzN7zIxASw6RCn
 Ot5yyabTuT59hWcVY
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

I tested this driver on my HP PA-RISC C3000 workstation, and it works
with the built-in TEAC CD-532E-B CD-ROM drive.
So drop the TODO item and adjust the file header.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 4b2ba813dcab..1532b2e3c672 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *    pata_ns87415.c - NS87415 (non PARISC) PATA
+ *    pata_ns87415.c - NS87415 (and PARISC SUPERIO 87560) PATA
  *
  *	(C) 2005 Red Hat <alan@lxorguk.ukuu.org.uk>
  *
@@ -16,7 +16,6 @@
  *    systems. This has its own special mountain of errata.
  *
  *    TODO:
- *	Test PARISC SuperIO
  *	Get someone to test on SPARC
  *	Implement lazy pio/dma switching for better performance
  *	8bit shared timing.
