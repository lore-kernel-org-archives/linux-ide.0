From: juergen.metzdorf@telelev-dsl.de
Subject: Re: Problem: 2.6.20-rc7 sata_via: SATA-DVD-Writer doesn't work
	properly
Date: Fri, 02 Feb 2007 20:34:44 +0100
Message-ID: <20070202203444.hcnx8efmifswosws@webmail.citykom.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from muemailc.citykom.de ([195.202.32.25]:39783 "EHLO
	muemailc.citykom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423079AbXBBTew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 14:34:52 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Zitat von Alan <alan@lxorguk.ukuu.org.uk>:

> On Thu, 01 Feb 2007 19:22:31 +0100
> juergen.metzdorf@telelev-dsl.de wrote:
>
>> Hello,
>>
>> I'm experiencing problems with an SATA-DVD-Writer (Samsung SH-S183a)
>> connected
>> to a VIA8237 motherboard chipset. As you can see in the attached
>> boot.log, the
>> system is reducing the DMA-Mode from DMA33 to DMA25 then to DMA16 to
>> end up as
>> PIO4. As a result the dvds that are written are corrupt. During the writing
>> process the messages log shows repeating entries like this:
>
> Please try the patch I posted to the kernel list and ide list yesterday
> which allows settle time on DMA changes.
>

Hi,

I've applied your patch and the patch by Jeff Garzik that he posted today.
Unfortunately that hasn't change the problem. Still the drive ends up at PIO4:

<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
<6>ata2: soft resetting port
<4>ATA: abnormal status 0x7F on port 0xB007
<4>ATA: abnormal status 0x7F on port 0xB007
<6>ata2.00: configured for UDMA/33
<6>ata2: EH complete
<4>ata2.00: limiting speed to UDMA/25
<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
<6>ata2: soft resetting port
<4>ATA: abnormal status 0x7F on port 0xB007
<4>ATA: abnormal status 0x7F on port 0xB007
<6>ata2.00: configured for UDMA/25
<6>ata2: EH complete
<3>sr0: CDROM (ioctl) error, command: <6>Read TOC/PMA/ATIP 43 00 00 00 00 00 00
00 0c 40
<6>sr: Current [descriptor]: sense key: Aborted Command
<6>    Additional sense: No additional sense information
<4>ata2.00: limiting speed to UDMA/16
<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
<6>ata2: soft resetting port
<4>ATA: abnormal status 0x7F on port 0xB007
<4>ATA: abnormal status 0x7F on port 0xB007
<6>ata2.00: configured for UDMA/16
<6>ata2: EH complete
<4>ata2.00: limiting speed to PIO4
<3>ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
<3>ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x43 data 12 in
<4>         res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
<6>ata2: soft resetting port
<4>ATA: abnormal status 0x7F on port 0xB007
<4>ATA: abnormal status 0x7F on port 0xB007
<6>ata2.00: configured for PIO4
<6>ata2: EH complete

BTW: In function ata_dev_set_mode in libata_core.c the variable err_mask is not
initialized (line 2386). I changed that and initialized err_mask with 0, but
that did'nt solve my problem. I did'nt expect to :-)

Juergen Metzdorf
