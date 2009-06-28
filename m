From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: porting IDE patches to PATA driver
Date: Mon, 29 Jun 2009 00:33:06 +0400
Message-ID: <4A47D382.2080308@ru.mvista.com>
References: <323951117.20090625100956@web.de>	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>	<14164712.20090625103834@web.de>	<20090625100542.525dba02@lxorguk.ukuu.org.uk>	<951976828.20090625123021@web.de>	<20090625122958.510c28ad@lxorguk.ukuu.org.uk>	<96179821.20090626152440@web.de>	<20090626144639.4bc822b8@lxorguk.ukuu.org.uk>	<792909512.20090626164052@web.de> <20090626172143.3fe6a59c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3489 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752873AbZF1UdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Jun 2009 16:33:08 -0400
In-Reply-To: <20090626172143.3fe6a59c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>> controller switches to a specific DVD-LOADER mode as soon as kernel
>> sends any command to the slave device, so they had to patch sources
>> and add a strange looking command
>>
>> OUT_BYTE((head|drive->select.all) & ~(1<<4), IDE_SELECT_REG);
>>
>> everywhere the slave device is accessed to cheat the controller and
>> let it believe it talks to the master. Slave device remains active
>> because it was already selected but the controller assumes we are
>> talking to the master and does not switch to DVD-LOADER mode.
>>     
>
> That can be done in a libata driver by providing your own exec_command
> functions but again could wait. Try something like
>
> static void my_sff_exec_command(struct ata_port *ap, const struct
> 	ata_taskfile *tf)
> {
> 	iowrite8(tf->command, ap->ioaddr.command_addr);
> 	if (tf->flags & ATA_TFLAG_DEVICE)
> 		iowrite8(tf->device & ~ATA_DEV1, ap->ioaddr.device_addr);
>   

  Note that this possibly violates ATA specs that forbid writing to any 
register with BSY set -- which might well be after wroiting a command, 
despite 400 ns couldn't have passed yet. IOW, I don't advice such 
trickery -- your write may well  be ignored.

> 	ata_sff_pause(ap);
> }

MBR, Sergei


