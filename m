From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: overriding ioops
Date: Sat, 5 Jun 2004 22:42:19 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406052242.19060.bzolnier@elka.pw.edu.pl>
References: <20040605201953.GA14917@buici.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41380 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261904AbUFEUii
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 16:38:38 -0400
In-Reply-To: <20040605201953.GA14917@buici.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org

On Saturday 05 of June 2004 22:19, Marc Singer wrote:
> I know that you me to do this differently that I did in 2.6.4.  I need
> to override the hwif->OUTB (et, all) functions.  Do I implement my own
> version of the default_hwif_ function?

No, arch specific code shouldn't touch generic one.
Your host driver should take care of this.

If you need some changes in generic code please describe them
and I'll try to fix/enhance it.

[ I know about polling but this is really non trivial change as i.e.
  we have 4 versions of IDE PIO code (!) - I'm cleaning this mess now. ]

Thanks,
Bartlomiej

