From: Willem Riede <wrlk@riede.org>
Subject: Re: [PATCH] remove dead ATAPI multi-lun support (used for ide-scsi)
Date: Fri, 20 Feb 2004 18:58:47 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040220235847.GY4957@serve.riede.org>
References: <200402202247.02345.bzolnier@elka.pw.edu.pl>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.202.56]:31437 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261437AbUBTX6u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Feb 2004 18:58:50 -0500
Content-Disposition: inline
In-Reply-To: <200402202247.02345.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, Feb 20, 2004 at 16:47:02 -0500)
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On 2004.02.20 16:47, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Not a big issue but maybe you know something more...
> 
> Cheers.
> 
> 
> [IDE] remove dead ATAPI multi-lun support (used for ide-scsi)
> 
> ChangeSet@1.889.69.2 03-01-23 14:51:03-05:00  adam@yggdrasil.com
> |  The following changes to ide-scsi.c are a recovery of the
> | changes that I had in ide-scsi.c in the stock kernel's before
> | Martin Dalecki's IDE tree was reverted and a few other changes.
> ...
> 
> broke it.
> 
> Before this change drive->id->last_id & 0x7 was used as shost->max_lun
> and "hdXlun=" kernel parameter could be used to override it.
> 
> It was needed probably only for some rare ATAPI PD-CD drives
> (http://www.geocrawler.com/archives/3/58/1999/11/50/2877161/).
> 
> However it was far from optimal:
> - people played with "hdXlun=" and then complained about multiple instances
>   of the same device (most ATAPI drives respond to each LUN)
> - probably some devices return 7 not 0 in id->last_id (=> 7 x same device)
> 
> This patch cleans things up, multi-lun will be fixed if needed in ide-scsi.
> I think that this may work but can't verify it:
> 
> 	if (id->last_lun && id->last_lun != 7)
> 		shost->max_lun = id->last_lun + 1;
> 	else
> 		shost->max_lun = 1;

I have two different multi-lun ATAPI drives, so I can - and will - test.
When done, I'll report my findings.

Regards, Willem Riede.
