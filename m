From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 06:45:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10408310643290.26528-100000@master.linux-ide.org>
References: <1093952715.32684.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:28432
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S268498AbUHaNtZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2004 09:49:25 -0400
In-Reply-To: <1093952715.32684.12.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org


Rogier,

Because the command layer states to execute retries, regardless.
Modern drives now convert read-once to retry.
You need special opcodes to revert to desired status.

Media forensics is not a cake walk.

Andre Hedrick
LAD Storage Consulting Group

On Tue, 31 Aug 2004, Alan Cox wrote:

> On Llu, 2004-08-30 at 17:39, Rogier Wolff wrote:
> > We encounter "bad" drives with quite a lot more regularity than other
> > people (look at the Email address). We're however, wondering why the
> > IDE code still retries a bad block 8 times? By the time the drive
> > reports "bad block" it has already tried it several times, including a
> > bunch of "recalibrates" etc etc. For comparison, the Scsi-disk driver
> > doesn't do any retrying.
> 
> It helps for some things like magneto-opticals. For generic hard drives
> its only relevant for older devices.
> 
> > (*) Note: Tested last month: The driver still works for MFM
> > drives. However, the initialization apparently is not enough
> > anymore. The drive did not work when the BIOS didn't think there was a
> > drive.
> 
> Please file a bug report if 2.6 also shows that problem.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

