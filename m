From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 15:55:04 -0500
Message-ID: <1219784104.6197.29.camel@localhost.localdomain>
References: <20080826072841.GS20055@kernel.dk>
	 <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
	 <20080826101713.GW20055@kernel.dk> <48B3DE5B.1020607@kernel.org>
	 <e7510f760808261025j189f6436ra2ec044256549cde@mail.gmail.com>
	 <1219772711.6197.11.camel@localhost.localdomain>
	 <e7510f760808261225x6164e1cciaf67ca08b26ef2bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:35970 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018AbYHZUzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 16:55:08 -0400
In-Reply-To: <e7510f760808261225x6164e1cciaf67ca08b26ef2bf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>

On Tue, 2008-08-26 at 12:25 -0700, Gwendal Grignou wrote:
> On Tue, Aug 26, 2008 at 10:45 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Tue, 2008-08-26 at 10:25 -0700, Gwendal Grignou wrote:
> >> The current patch  to implement libata-sysfs floating in the mailing
> >> list is read-only.
> >> For write we must currently go through SCSI midlayer ioctls and use
> >> sat. To send commands directly within libata[-sysfs] - for instance
> >> writing SControl register of a SATA PM - I need to either implement a
> >> queue mechanism over ata_exec_internal() or schedule eh and piggy back
> >> on it.
> >
> > That's not how the other transport classes work, why does the libata one
> > need to go through the mid-layer (well, except for the necessary command
> > issue stuff, of course).  The design of the transport classes was
> > specifically to take all transport knowledge out of the mid layer and
> > connect the requisite controls in sysfs directly to the transport
> > actions.
> I agree. I don't want to use the mid-layer either. I just mentioned
> that if I want to send a raw taskfile to a ATA device today, the only
> way I found is using ata_task_ioctl() which relies on the mid-layer to
> schedule the request; the direct way - through ata_exec_internal() -
> assumes only one outstanding command at a time.  I need to implement
> something else for the accessing ATA devices in libata-sysfs similar
> to smp_execute_task() in libsas.

Actually, no ... if you're sending a SATA task, then you're right, you
need to use the mid-layer inputs.  scsi_execute() is the way transport
classes use this (see scsi_transport_spi ... it does exactly this for
domain validation).  ata_task_ioctl() does it exactly this way.

You don't want something like smp_execute_task because that's an
internal libsas API for doing out of band management tasks ... ATA has
no concept of anything like this.  Even our publicly exposed frame
in/frame out interfaces for performing SMP tasks go via a special API
stream in the transport class framework so they can be issued on all SAS
hosts.  Mechanistically, they're different from normal SCSI commands
because they don't count against the queuing quota or have ordinary
tags.  If your commands come out again as standard ATA commands, I 
suspect they have to go through the standard ATA quota machinery.

SAS is very different from SATA in that we have tons of addressable
ports sitting off the devices, each addressable by predefined protocols,
so what smp_execute_task is doing is addressing the SMP port ... this is
completely out of band as far as the normal SSP/STP protocols see
things.  With port multipliers, you're more or less stuck with an
in-band type of packet.

James


