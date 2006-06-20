From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
Date: Tue, 20 Jun 2006 09:03:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606200903160.5851@p34.internal.lan>
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan>
 <4497F1C7.2070007@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:28363 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750739AbWFTND4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 09:03:56 -0400
In-Reply-To: <4497F1C7.2070007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, 20 Jun 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> 
>> Should someone comment this code out that produces the printk()'s as these 
>> are useless information as there is no problem with the disk?
>
> MMm.. probably "barrier" commands that the drive doesn't like.
> Pity those messages don't also dump the failed opcode.
>
>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 { 
>> DriveStatusError }
>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: error=0x04 { 
>> DriveStatusError }
>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense translation for 
>> status: 0x51
>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: no sense translation for 
>> status: 0x51
>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: no sense translation for 
>> status: 0x51
>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: status=0x51 { DriveReady 
>> SeekComplete Error }
>

Mark, what would be the proper direction to move towards?  Is Jeff or 
another SATA/ATA maintainer going to have to look at this or is there 
something else I can do, or?

Justin.

