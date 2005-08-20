From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [SUMMARY] libata EH
Date: Sat, 20 Aug 2005 21:02:48 +0100
Message-ID: <1124568170.14518.13.camel@localhost.localdomain>
References: <20050820023351.GA690@htj.dyndns.org>
	 <4306B62F.7090509@pobox.com>  <430768E2.60808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:53950 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751012AbVHTTwV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Aug 2005 15:52:21 -0400
In-Reply-To: <430768E2.60808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, mlord@pobox.com, lkosewsk@gmail.com, luben_tuikov@adaptec.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <axboe@suse.de>

On Sul, 2005-08-21 at 02:31 +0900, Tejun Heo wrote:
>   My preference is toward unifying into single path as long as 
> performance penalty is acceptable for the sake of simplicity.

I don't think it is a big issue for ATA. The drive tends to take 10-15
seconds before it goes and whines at us, and it is hopefully not a fast
path.

> >>     * SCSI EH entrance is not synchronized with polling tasks.
> > 
> > 
> > Yes, this definitely needs fixing.
> > 
> > Luckily the polling task is very rarely used, by normal users.

The old IDE has this bug on reset paths too - and people do eventually
hit it.

> > - DMA errors should be handled by hueristics:  If more than $N (3?) DMA 
> > errors happen in 15 minutes,
> > * decrease SATA PHY speed.  if speed cannot be decreased,
> > * decrease UDMA xfer speed.  if at UDMA0, switch to PIO4
> > * decrease PIO xfer speed.  if at PIO3, complain, but continue

Remember this means issuing a command to the drive before re-issuing the
failed command. The old IDE also has serious problems with this as it
ends up trying to issue a polling command from an IRQ racing its own
timeout code. One good reason for the EH approach scsi takes of
quiescing first and running in task context.


