From: "Gwendal Grignou" <gwendal@google.com>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 12:25:13 -0700
Message-ID: <e7510f760808261225x6164e1cciaf67ca08b26ef2bf@mail.gmail.com>
References: <20080826072841.GS20055@kernel.dk>
	 <20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
	 <20080826101713.GW20055@kernel.dk> <48B3DE5B.1020607@kernel.org>
	 <e7510f760808261025j189f6436ra2ec044256549cde@mail.gmail.com>
	 <1219772711.6197.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:20901 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbYHZTZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 15:25:44 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out3.google.com with ESMTP id m7QJPFiM016602
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 20:25:16 +0100
Received: from yx-out-2324.google.com (yxg8.prod.google.com [10.190.2.136])
	by zps78.corp.google.com with ESMTP id m7QJPEDR010294
	for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 12:25:14 -0700
Received: by yx-out-2324.google.com with SMTP id 8so1166991yxg.39
        for <linux-ide@vger.kernel.org>; Tue, 26 Aug 2008 12:25:14 -0700 (PDT)
In-Reply-To: <1219772711.6197.11.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>

On Tue, Aug 26, 2008 at 10:45 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Tue, 2008-08-26 at 10:25 -0700, Gwendal Grignou wrote:
>> The current patch  to implement libata-sysfs floating in the mailing
>> list is read-only.
>> For write we must currently go through SCSI midlayer ioctls and use
>> sat. To send commands directly within libata[-sysfs] - for instance
>> writing SControl register of a SATA PM - I need to either implement a
>> queue mechanism over ata_exec_internal() or schedule eh and piggy back
>> on it.
>
> That's not how the other transport classes work, why does the libata one
> need to go through the mid-layer (well, except for the necessary command
> issue stuff, of course).  The design of the transport classes was
> specifically to take all transport knowledge out of the mid layer and
> connect the requisite controls in sysfs directly to the transport
> actions.
I agree. I don't want to use the mid-layer either. I just mentioned
that if I want to send a raw taskfile to a ATA device today, the only
way I found is using ata_task_ioctl() which relies on the mid-layer to
schedule the request; the direct way - through ata_exec_internal() -
assumes only one outstanding command at a time.  I need to implement
something else for the accessing ATA devices in libata-sysfs similar
to smp_execute_task() in libsas.

>
> The (semi)direct analogue of writing SControl of a SATA PM is writing a
> phy control parameter of a SAS expander ... that's all accomplished in
> libsas/scsi_transport_sata without ever going via the mid-layer.
Agree.

Gwendal.
>
>> Once implemented, we could definitely use it in conjunction with udev
>> to tune ATA devices.
>
> James
>
>
>
