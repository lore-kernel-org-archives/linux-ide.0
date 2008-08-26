From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 12:45:11 -0500
Message-ID: <1219772711.6197.11.camel@localhost.localdomain>
References: <20080826072841.GS20055@kernel.dk>
	 <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
	 <20080826101713.GW20055@kernel.dk> <48B3DE5B.1020607@kernel.org>
	 <e7510f760808261025j189f6436ra2ec044256549cde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:39588 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757239AbYHZRpP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 13:45:15 -0400
In-Reply-To: <e7510f760808261025j189f6436ra2ec044256549cde@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>

On Tue, 2008-08-26 at 10:25 -0700, Gwendal Grignou wrote:
> The current patch  to implement libata-sysfs floating in the mailing
> list is read-only.
> For write we must currently go through SCSI midlayer ioctls and use
> sat. To send commands directly within libata[-sysfs] - for instance
> writing SControl register of a SATA PM - I need to either implement a
> queue mechanism over ata_exec_internal() or schedule eh and piggy back
> on it.

That's not how the other transport classes work, why does the libata one
need to go through the mid-layer (well, except for the necessary command
issue stuff, of course).  The design of the transport classes was
specifically to take all transport knowledge out of the mid layer and
connect the requisite controls in sysfs directly to the transport
actions.

The (semi)direct analogue of writing SControl of a SATA PM is writing a
phy control parameter of a SAS expander ... that's all accomplished in
libsas/scsi_transport_sata without ever going via the mid-layer.

> Once implemented, we could definitely use it in conjunction with udev
> to tune ATA devices.

James


