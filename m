From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: strange CONFIG_BLK_DEV_IDECS ifdefs
Date: Sun, 16 May 2004 21:38:58 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405162138.58293.bzolnier@elka.pw.edu.pl>
References: <20040516085224.GA15680@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33502 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264805AbUEPThU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 15:37:20 -0400
In-Reply-To: <20040516085224.GA15680@infradead.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Sunday 16 of May 2004 10:52, Christoph Hellwig wrote:
> there's two really strange ifdefs for ide-cs in ide.c:
>
>  - first ide_unregister is resetting hwif->irq only if
>    CONFIG_BLK_DEV_IDECS is not set.  This seems really braindead as
>    apparently the other drivers don't care (otherwise they wouldn't work
>    with CONFIG_BLK_DEV_IDECS), but OTOH I don't see a way ide-cs would
>    care for either variant, too - it doesn't touch the hwif anymore
>    after unregister.
>  - ide_delay_50ms is not sleeping with CONFIG_BLK_DEV_IDECS.  Andre told
>    me this was because the pcmcia code didn't allow sleeping in the
>    probe routine once upon a time - that's not true anymore, in fact
>    ide-cs is calling schedule_timeout just after calling ide_register
>    currently..

Yep, I've also noticed these weirdness.

> Is there someone with ide-cs hardware to test whether killing the ifdefs
> makes any difference?

Anybody?  [ You will get credits in ChangeLog. :-) ]

