From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
Date: Tue, 20 Jun 2006 09:01:59 -0400
Message-ID: <4497F1C7.2070007@rtr.ca>
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:54953 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750747AbWFTNCB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 09:02:01 -0400
In-Reply-To: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Justin Piszcz wrote:
>
> Should someone comment this code out that produces the printk()'s as 
> these are useless information as there is no problem with the disk?

MMm.. probably "barrier" commands that the drive doesn't like.
Pity those messages don't also dump the failed opcode.

> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 { 
> DriveReady SeekComplete Error }
> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 { 
> DriveStatusError }
> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: status=0x51 { 
> DriveReady SeekComplete Error }
> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: error=0x04 { 
> DriveStatusError }
> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense translation 
> for status: 0x51
> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 { 
> DriveReady SeekComplete Error }
> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: no sense translation 
> for status: 0x51
> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: status=0x51 { 
> DriveReady SeekComplete Error }
> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: no sense translation 
> for status: 0x51
> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: status=0x51 { 
> DriveReady SeekComplete Error }

