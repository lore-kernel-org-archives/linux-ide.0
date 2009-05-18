From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/6] drivers/ide: Convert printk(KERN_NOTICE to
 pr_notice(
Date: Mon, 18 May 2009 06:32:35 -0700
Message-ID: <1242653555.1572.13.camel@Joe-Laptop.home>
References: <cover.1242609803.git.joe@perches.com>
	 <3ff9e9c7a8918f4d5f7bab5590f46073a196a4bf.1242609804.git.joe@perches.com>
	 <4A11343C.5070809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1430 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZERNc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 May 2009 09:32:59 -0400
In-Reply-To: <4A11343C.5070809@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Mon, 2009-05-18 at 14:11 +0400, Sergei Shtylyov wrote:
>   This patch creates lines > 80 chars long, co no ACK this time.

It makes grepping for log messages easier.
http://lkml.org/lkml/2009/4/8/607

> > -				printk(KERN_NOTICE PFX "%s: %d bytes block size"
> > -				       " not supported\n", drive->name, length);
> > +				pr_notice(PFX "%s: %d bytes block size not supported\n",
[]
> > -					printk(KERN_NOTICE PFX "%s: Warning: "
> > -					       "non 512 bytes block size not "
> > -					       "fully supported\n",
> > -					       drive->name);
> > +					pr_notice(PFX "%s: Warning: non 512 bytes block size not fully supported\n",
[]
> > -		printk(KERN_NOTICE "ide-tape: %s: Unsupported request in "
> > -			"request queue (%d)\n", drive->name, rq->cmd_type);
> > +		pr_notice("ide-tape: %s: Unsupported request in request queue (%d)\n",

cheers, Joe

