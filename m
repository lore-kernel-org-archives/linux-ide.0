From: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 15:56:38 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030806155638.1fdd0a30.akpm@osdl.org>
References: <200308062052.10752.fsdeveloper@yahoo.de>
	<200308062129.47113.fsdeveloper@yahoo.de>
	<20030806150434.53c4fa8c.akpm@osdl.org>
	<200308070044.41198.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:12474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265922AbTHFWyu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2003 18:54:50 -0400
In-Reply-To: <200308070044.41198.fsdeveloper@yahoo.de>
List-Id: linux-ide@vger.kernel.org
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, gardiol@libero.it

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
> But I've captured a few other interesting things in the syslog.
> After doing a
> $ hdparm -c1 -u1 -d1 -X69 /dev/hda
> I saw this in my syslog:
> 
> Aug  7 00:32:05 lfs kernel: blk: queue c049195c, I/O limit 4095Mb (mask 0xffffffff)
> Aug  7 00:32:05 lfs kernel: hda: Speed warnings UDMA 3/4/5 is not functional.
> 
> The onboard IDE controller is a UDMA-100 controller
> and the disks do run in this mode, too.

and

>   149 ide_outbsync                              11,4615

it does seem that ide has gone bad.  Perhaps you can run `hdaprm -X udma2'
or whatever the `-X' argument is to force it into UDMA2 mode.

But the driver should have done that for itself.
