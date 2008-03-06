From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_ram driver
Date: Fri, 07 Mar 2008 08:55:36 +0900
Message-ID: <47D08478.8010700@gmail.com>
References: <20080222200951.GI16995@parisc-linux.org>	 <47BF3E54.9050609@rtr.ca>  <47CFA9A6.2040506@gmail.com> <1204817301.3062.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:63312 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302AbYCFXzo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 18:55:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so164449wah.23
        for <linux-ide@vger.kernel.org>; Thu, 06 Mar 2008 15:55:43 -0800 (PST)
In-Reply-To: <1204817301.3062.3.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mark Lord <liml@rtr.ca>, Matthew Wilcox <matthew@wil.cx>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

James Bottomley wrote:
>> It's because of the sequence of events.  Currently, driver unload
>> sequence is the same as when the device is hot unplugged.  libata
>> detects that the device is gone and disables it and report it to SCSI
>> layer.  SCSI layer takes over and tries to kill the SCSI device and tell
>> sd to shutdown and sd issues START_STOP to shutdown which fails w/
>> DID_BAD_TARGET because the matching ATA device is already gone.  I've
>> left it that way because I'm not sure whether spinning down the drive on
>> driver unload is the correct thing to do.  The message is annoying tho.
> 
> Um, it's not supposed to happen that way.  Your signal that a disk is
> gone is slave destroy ... and we don't call that until after the target
> has been processed.  Devices are supposed to stay online (if possible)
> from slave alloc to slave destroy.

Currently, it's like the following.

* Explicit unplug request via sysfs or whatever: ATA device stays online
till slave_destroy finishes.

* Hot unplugging: Nothing much libata can do.  ATA device is yanked out
by the user.

* Driver unload: Dealt the same way as hot unplugging.

Making driver unload like explicit unplug request is possible but it
will mean that drives will be spun down on driver unload, which can be
annoying to developers.  In addition, the code path is shared with
controller hot unplug in which case it's probably best not to issue any
new command.  So, I've been reluctant to make the change.  If the change
is required, I think it can be done by adding a few lines at the top of
ata_port_detach().  Jeff, what do you think?

-- 
tejun
