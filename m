From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Date: Thu, 10 Feb 2005 01:24:21 +0100
Message-ID: <58cb370e050209162437808733@mail.gmail.com>
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>
	 <4206F2E5.7020501@gmail.com>
	 <200502070959.54973.bzolnier@elka.pw.edu.pl>
	 <420AA476.1040406@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.201]:9603 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261985AbVBJAYW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2005 19:24:22 -0500
Received: by wproxy.gmail.com with SMTP id 67so1403412wri
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2005 16:24:22 -0800 (PST)
In-Reply-To: <420AA476.1040406@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@home-tj.org>

Hello Tejun,

On Thu, 10 Feb 2005 09:01:58 +0900, Tejun Heo <htejun@gmail.com> wrote:
>   Hello, Bartlomiej.  Happy new lunar year.
> 
> Bartlomiej Zolnierkiewicz wrote:
> >
> > I would prefer to not teach do_rw_taskfile() about ->tf_{in,out}_flags
> > (and convert all users to use helpers) - it is much simpler this way,
> >
> > ->flags field in ide_task_t is needed anyway (32-bit I/O flag).
> >
> 
>   New lunar year day is one of the biggest holidays here, so I haven't
> got time to work for a few days.  As it's over now, I began to work on
> ide drivers again.  I applied your task->flags patch and am moving my
> patches over it.
> 
>   One problem is that, with ATA_TFLAG_LBA48, whether to use HOB
> registers or not cannot be determined separately for writing and
> reading.  So, when initializing flush tasks, if WIN_FLUSH_CACHE_EXT is
> used, we need to turn on ATA_TFLAG_LBA48 to read error location
> properly, and we end up unnecessarily writing HOB registers.

Yep, good catch.

>   I think we can...
> 
>   1. Just leave it as it is.  It's not that big a deal.
>   2. Use another flag(s) to control LBA48 reading/writing separately.
>   3. do my proposal. :-)
> 
>   I'm currently sticking to #1.  Please let me know what you think.

agreed, #1 is a good choice, it is not that important to make things
more complicated

Thanks,
Bartlomiej
