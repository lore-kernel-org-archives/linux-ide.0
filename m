From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fix memory leak when flush command is issued
Date: Tue, 21 Jul 2009 20:25:01 -0700 (PDT)
Message-ID: <20090721.202501.228023805.davem@davemloft.net>
References: <1247761972.8418.46.camel@sakura.staff.proxad.net>
	<200907171605.55502.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35522
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756294AbZGVDYz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 23:24:55 -0400
In-Reply-To: <200907171605.55502.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: mbizon@freebox.fr, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Fri, 17 Jul 2009 16:05:54 +0200

> On Thursday 16 July 2009 18:32:52 Maxime Bizon wrote:
>> 
>> Hi David, Bartlomiej
>> 
>> I'm using ide on 2.6.30.1 with xfs filesystem. I noticed a kernel memory
>> leak after writing lots of data, the kmalloc-96 slab cache keeps
>> growing. It seems the struct ide_cmd kmalloced by idedisk_prepare_flush
>> is never kfreed.
>> 
>> Commit a09485df9cda49fbde2766c86eb18a9cae585162 and
>> f505d49ffd25ed062e76ffd17568d3937fcd338c cause this regression, cmd->rq
>> must now be set for ide_complete_cmd to honor the IDE_TFLAG_DYN flag.
>> 
>> Candidate for stable I think, thanks !
>> 
>> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> 
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied and queued up for -stable, thanks.
