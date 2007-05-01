From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 01 May 2007 08:55:25 -0400
Message-ID: <463738BD.2090308@rtr.ca>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <46373873.6060704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3585 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031680AbXEAMz1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 08:55:27 -0400
In-Reply-To: <46373873.6060704@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

Mark Lord wrote:
> Tejun Heo wrote:
> ..
>>>>> scsi1 : ata_piix
>>>>> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
> ..
>> The err_mask is AC_ERR_DEV indicating that the device raised aborted the
>> IDENTIFY command.  I wonder what's going on.
>>
>> Can you change "#undef ATA_DEBUG" in include/linux/libata.h to "#define
>> ATA_DEBUG" and report the resulting dmesg?  There will be a LOT of
>> messages so you probably want to increase printk buffer size and detach
>> other devices if possible.  It would be best if your root device isn't
>> driven by libata so that you can just insert the module and store the
>> resulting dmesg.
> 
> If the command really was "IDENTIFY", then of course it failed.
> This is an ATAPI device, and it wants "PACKET_IDENTIFY".
> 
> Maybe libata somehow thinks it's ATA rather than ATAPI?

And this is the second one today where it would be very useful
to see a tf dump.  It's time to add one to that code patch, methinks.
