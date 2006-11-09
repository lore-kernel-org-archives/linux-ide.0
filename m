From: "Monty Montgomery" <monty@xiph.org>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Date: Thu, 9 Nov 2006 15:09:22 -0500
Message-ID: <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
	 <20061030114503.GW4563@kernel.dk>
	 <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
	 <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org>
	 <45533468.1060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:23263 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965559AbWKIUJY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Nov 2006 15:09:24 -0500
Received: by py-out-1112.google.com with SMTP id a29so150625pyi
        for <linux-ide@vger.kernel.org>; Thu, 09 Nov 2006 12:09:23 -0800 (PST)
In-Reply-To: <45533468.1060400@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Jens Axboe <jens.axboe@oracle.com>, Gregor Jasny <gjasny@googlemail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Douglas Gilbert <dougg@torque.net>

On 11/9/06, Tejun Heo <htejun@gmail.com> wrote:

> drivers/scsi/sg.c interprets SG_DXFER_TO_FROM_DEV as read while
> block/scsi_ioctl.c interprets it as write.  I guess this is historic
> thing (scsi/sg.c updated but block/scsi_ioctl.c is forgotten).

Not historic; Jens accidentally implemented it backwards.  No one
noticed for a long time.  I submitted a patch for this a few months
ago.

> This works for most PATA ATAPI devices.  Most devices detect reversed
> transfer and terminate the command promptly.

No.  The rejection is *not* in hardware; it is in software.
block/scsi_ioctl.c, at least up to 2.6.16, rejected the TO_FROM_DEVICE
request when verifying the command for sanity after setting the
transfer direction incorrectly.  As far as the *device* can see,
TO_FROM_DEVICE and FROM_DEVICE are identical.  The difference only
applies inside the kernel mid-level driver where TO_FROM_DEVICE
prefills the transfer buffer as a way of working around having no
other detection path for short DMA transfers.

>  But this doesn't seem to
> be true for SATA device.

Then the driver is broken and needs to be fixed.  And I'll need to
find a workaround for broken kernels that doesn't cause a boom.

> Jens, I think we need to match block sg's behavior to SCSI's.  Monty,
> the timeout and hard lock up are due to hardware restrictions.

No., the kernel setting the transfer direction incorrectly.  I don't
set the transfer direction, the kernel does.

In your case, I pass in "SGIO_TO_FROM_DEVICE" and the kernel says
"that's a write".  The kernel is wrong.  It is a read.  The original
description of what TO_FROM_DEVICE is for is explicit on this point.

>  Kernel
> and libata can't do much about it.  So, please find other way to detect
> interface.

Just to be clear-- it is the kernel at fault here, and the kernel can
do something about it-- but only if the kernel gets fixed.  Also to be
clear, given this brokenness, yes I need to find another way.

Dammit, dammit, dammit, one step forward, two steps back :-(

Monty
