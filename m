From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Hang during boot, bisected to commit 96d60303fd
Date: Thu, 03 Jun 2010 21:42:03 -0600
Message-ID: <4C08760B.8050002@gmail.com>
References: <AANLkTiktNufXK_pn6mP2-zyowAIbHlUy5TGu3AtpALv-@mail.gmail.com>	<20100603020006.GB19123@srcf.ucam.org> <AANLkTikpv86r5BBPCEOHujpm8uCgY0DxghSKjBufBWiM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54222 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab0FDDmG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2010 23:42:06 -0400
In-Reply-To: <AANLkTikpv86r5BBPCEOHujpm8uCgY0DxghSKjBufBWiM@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, garzik@redhat.com

On 06/03/2010 07:21 PM, Marc Dionne wrote:
> On Wed, Jun 2, 2010 at 10:00 PM, Matthew Garrett<mjg59@srcf.ucam.org>  wrote:
>> On Wed, Jun 02, 2010 at 09:49:27PM -0400, Marc Dionne wrote:
>>>     Since somewhere early in the 2.6.35 merge window I've been seeing a hang
>>>     during boot.  The hang last roughly 30 seconds and is followed by this:
>>>
>>>     ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
>>>     ata4.00: failed command: READ FPDMA QUEUED
>>>     ata4.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
>>>              res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>>>     ata4.00: status: { DRDY }
>>>     ata4: hard resetting link
>>>     ahci_is_device_present: status is: 80
>>>     ahci_is_device_present: status(2) is: 3
>>>     ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>>     ata4.00: configured for UDMA/133
>>>     ata4.00: device reported invalid CHS sector 0
>>>     ata4: EH complete
>>>
>>>     The system works normally once booted.  I had some time to do a bisect
>>>     today and it cleanly ended up pointing to this commit:
>>>         96d60303fd: ahci: Turn off DMA engines when there's no device attached
>>>
>>>     Reverting the commit makes the system boot cleanly as before.  System has
>>>     an Intel ICH10 based board, in AHCI mode, disk is an Intel X25M SSD.
>>
>> Hm, interesting. Jeff, any immediate ideas? I don't see this behaviour
>> on my ICH10. Is there actually a device on ata4?
>>
>> --
>> Matthew Garrett | mjg59@srcf.ucam.org
>
> If it's helpful, attached are the dmesg output following a normal boot
> and one with the hang.
>
> The only difference in the kernel used for those two boots is that the
> return statement in ahci_start_engine following the call to
> ahci_is_device_present is commented out for the normal boot case.
> When the return statement is active, the 30 second hang occurs.

Can you try and put a printk in where it's returning out of the 
ahci_start_engine method? I wonder if that's getting triggered somewhere 
unexpected..
