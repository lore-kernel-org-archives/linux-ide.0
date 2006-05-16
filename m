From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 19:53:57 -0400
Message-ID: <446A6615.6050701@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37786 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750828AbWEPXyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 19:54:00 -0400
In-Reply-To: <446A63F6.5030706@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
> Hmmm.. The drive is issuing SDB FIS which completes already completed 
> tags.  This could be dangerous.  Depending on timing, it might end up 
> finishing a command which occupied the slot which hasn't been processed 
> yet.  If a drive does this, NCQ shouldn't be enabled for it.  Can you 
> post full boot dmesg?

I'm not sure the data supports that conclusion?  PORT_IRQ_SDB_FIS is 
quite normal and expected during NCQ operation, if that interrupt is 
enabled.  Just normal SDB:Entry and SDB:SetIntr states.

Side note:  looking at those states reminds me that ATAPI devices that 
support Asynchronous Notification (an end to CD-ROM polling) will soon 
be appearing on the market.  We'll need to make note of the Notification 
bit, if present...

	Jeff


