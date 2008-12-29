From: Tejun Heo <tj@kernel.org>
Subject: Re: [2.6.28-rc] Sata soft reset filling log
Date: Mon, 29 Dec 2008 15:23:09 +0900
Message-ID: <49586CCD.8010207@kernel.org>
References: <494318F5.4060007@gawab.com> <494EFD79.7020008@kernel.org> <494F3AD2.3060201@gawab.com> <494F3E41.60304@kernel.org> <49500BE2.6050106@gawab.com> <49504B8C.8080907@kernel.org> <49568CAD.7050509@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49160 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYL2G00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 01:26:26 -0500
In-Reply-To: <49568CAD.7050509@gawab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Madru <jdm64@gawab.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jeff@garzik.org>

Hello,

Justin Madru wrote:
> I applied the patch and get the following:
> 
> ata2: XXX status=50 after 100 tries
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata2.00: ST_FIRST: !(DRQ|ERR|DF)
> ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
>         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
>         res 50/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata2.00: status: { DRDY }
> ata2: soft resetting link
> ata2.00: configured for UDMA/33
> ata2: EH complete

This is so strange.  :-(

> I tried to git bisect the problem. First time I thought the error
> was between rc2 and rc3, but the bisect gave inconclusive results
> because I couldn't tell for sure a good commit from a bad.  I tried
> again with .27 to .28-rc3, but I was unable to bisect because of
> compile errors (in pre-rc1), and doing git bisect skip, again landed
> on a commit with compile errors.

Thanks for trying.  I can't think of any relevant change which can
cause this and I doubt it's something affecting many machines given
that you're currently the only one reporting this problem.

Any chance it's a hardware fluke?  Can you please make sure it doesn't
happen with 2.6.27?

> Unless you can think of anything else, I'm just going to wait and see if
> a commit in .29 will fix the problem.

Eh... I doubt that will happen.  No scheduled change for SFF HSM
implementation.

Thanks.

-- 
tejun
