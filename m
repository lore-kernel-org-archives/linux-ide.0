From: Mark Lord <liml@rtr.ca>
Subject: Re: IOMEGA IDE ZIP (ATAPI) drive
Date: Fri, 16 Mar 2007 10:37:25 -0400
Message-ID: <45FAABA5.1000700@rtr.ca>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F7E34B.6020206@gmail.com> <45F7F90B.6070709@rtr.ca> <45F7FD13.2070907@gmail.com> <45F9C4B2.20906@rtr.ca> <45FAAA22.7060000@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:3728 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965316AbXCPOh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:37:27 -0400
In-Reply-To: <45FAAA22.7060000@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Stanislav Brabec <sbrabec@novell.com>, jeff@garzik.org, bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Albert Lee wrote:
> Mark Lord wrote:
>..
>> (1) When ejecting a disk, either with the "eject /dev/sdc" command
>> or using the front-panel soft-eject button on the drive,
>> I get the following in syslog from libata:
>>
>> sdc: Spinning up disk...<3>ata4.00: exception Emask 0x0 SAct 0x0 SErr
>> 0x0 action 0x2
>>         res 00/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
>> ata4: soft resetting port
>> ATA: abnormal status 0x7F on port 0x00010177
>> ATA: abnormal status 0x7F on port 0x00010177
>> ata4.00: configured for PIO2
>> ata4: EH complete
> 
> The device status of 0x00 looks strange.

Not to me.  The device likely generated an unsolicitied interrupt,
and status==0x00 is correct for a few seconds here:  the drive is
not busy with a command, not in an error state, and not ready
for a new command since it is busy ejecting a disc.

> Could you please apply the attached debugging patch for 
> clue about what caused the HSM violation, thanks.

I'll unpack the drive and hook it up again.

Cheers
