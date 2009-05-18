From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/6] drivers/ide Convert printk(KERN_<foo> to pr_<foo>(
Date: Mon, 18 May 2009 17:48:40 +0200
Message-ID: <200905181748.41172.bzolnier@gmail.com>
References: <cover.1242609803.git.joe@perches.com> <200905181612.43632.bzolnier@gmail.com> <1242661288.1572.82.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:56361 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZERPpS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 11:45:18 -0400
In-Reply-To: <1242661288.1572.82.camel@Joe-Laptop.home>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Monday 18 May 2009 17:41:28 Joe Perches wrote:
> On Mon, 2009-05-18 at 16:12 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 18 May 2009 04:21:08 Joe Perches wrote:
> > > Mostly mechanical conversion of printk's
> > Hmm.. less mechanical conversion using also dev_*() macros where suitable
> > would be much better...
> > How's about fixing pr_devel() which currently doesn't seem to be used
> > by anything inside kernel to not depend on DEBUG in separate pre-patch
> > and then using it instead of pr_debug()?
> 
> How about deferring the "printk(KERN_DEBUG" to something else
> and doing the mechanical conversion to core as a first pass,
> followed by core pr_<foo> to dev_<foo> where appropriate
> as a second pass?

Fine with me.

> What do you think is appropriate for pr_<foo> to dev_<foo>
> conversions?

printk()s using drive->name or hwif->name

Thanks,
Bart
