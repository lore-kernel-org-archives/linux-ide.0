From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: marvell sata status?
Date: Thu, 1 Jan 2009 04:54:11 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0901010444440.427@p34.internal.lan>
References: <20090101051038.GD3386@pimb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:40572 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755532AbZAAJyN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 04:54:13 -0500
In-Reply-To: <20090101051038.GD3386@pimb.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody Belka <lists-lkml@pimb.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>



On Thu, 1 Jan 2009, Jody Belka wrote:

> Hi,
>
> I'm looking at buying some new hard drives within the next few months, and
> along with them an sata card. One of the cards I've spotted is an Adaptec
> that apparently has a Marvell chipset on it (88SX7042), so I was wondering
> what the current state of sata_mv is. Is it stable enough for everyday use,
> or should I look for something using a different chipset?
>
> Please cc me, as not subscribed to lkml, thanks.
>

Hi,

I cannot comment on that Adaptec card but other cards (without fake-raid 
controllers built on-top of them) with that chipset work great:

Starttech/Rosewill come to mind.

01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

Star Tech is the "brand-card" I have.

Works as a regular SATA controller.

Justin.
