From: David Greaves <david@dgreaves.com>
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
Date: Tue, 20 Jun 2006 15:23:38 +0100
Message-ID: <449804EA.8030908@dgreaves.com>
References: <Pine.LNX.4.64.0606200808250.5851@p34.internal.lan> <4497F1C7.2070007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:36830 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751093AbWFTOXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 10:23:40 -0400
In-Reply-To: <4497F1C7.2070007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Mark Lord wrote:
> MMm.. probably "barrier" commands that the drive doesn't like.
> Pity those messages don't also dump the failed opcode.
For me:
smartctl -data -o on /dev/sda
produces this on 2.6.17-rc5

(I thought the opcode patch went into 2.6.17...)

ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

David

>
>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 {
>> DriveReady SeekComplete Error }
>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 {
>> DriveStatusError }
>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: status=0x51 {
>> DriveReady SeekComplete Error }
>> Jun 20 03:20:27 p34 kernel: [4339823.900000] ata3: error=0x04 {
>> DriveStatusError }
>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense
>> translation for status: 0x51
>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 {
>> DriveReady SeekComplete Error }
>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: no sense
>> translation for status: 0x51
>> Jun 20 03:41:04 p34 kernel: [4341061.844000] ata3: status=0x51 {
>> DriveReady SeekComplete Error }
>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: no sense
>> translation for status: 0x51
>> Jun 20 03:46:27 p34 kernel: [4341384.974000] ata3: status=0x51 {
>> DriveReady SeekComplete Error }

