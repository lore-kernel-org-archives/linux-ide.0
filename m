From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Sun, 22 Feb 2004 18:28:18 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402221828.18830.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <m2llmv9iwi.wl%ysato@users.sourceforge.jp> <200402221808.06615.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41470 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261703AbUBVRVr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Feb 2004 12:21:47 -0500
In-Reply-To: <200402221808.06615.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Sunday 22 of February 2004 18:08, Bartlomiej Zolnierkiewicz wrote:

> > I corrected it to initialize it with ide_init_default_hwifs.
> > A correction of ide.c becomes needless.
>
> NO!!!  ide_init_default_hwifs() should DIE!
> The same goes for ide_default_{irq,io_base}().
>
> They are not needed - you have driver(s) for H8/300 IDE controllers!

It should be like that:

You should have host drivers for your IDE controllers,
not inline functions for ide.c and ide-probe.c.

