From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Fri, 20 Feb 2004 19:42:00 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402201942.00232.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402201625.42842.bzolnier@elka.pw.edu.pl> <m2hdxl3a5s.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:63929 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261257AbUBTSf4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Feb 2004 13:35:56 -0500
In-Reply-To: <m2hdxl3a5s.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Friday 20 of February 2004 18:58, Yoshinori Sato wrote:

> > - added #if !defined(__H8300H__) to ide-proc.c
> >   (only place where ->OUTL is used, ->INL is unused in generic IDE code)
>
> "__H8300S__" becomes the same condition, too.

Oh yes, it should be CONFIG_H8300.

> > - __ide_outl() and __ide_inl() removed
> > - redundant includes removed
> > - init driver through initcall (so no need to make changes in ide.c)
>
> It seems to have been overwritten with default_hwif_iops
> setting of h8300_hwif_iops in module_init.

Yep, h8300_ide_init() still should be called from ide.c.
(because ide_register_hw() checks "initialization" flag etc.)

