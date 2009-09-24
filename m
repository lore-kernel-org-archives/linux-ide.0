From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Strange .31 freeze - ata related
Date: Thu, 24 Sep 2009 17:54:54 -0600
Message-ID: <4ABC06CE.6040404@gmail.com>
References: <200909241834.53852.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47752 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbZIYACv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2009 20:02:51 -0400
In-Reply-To: <200909241834.53852.edt@aei.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ed Tomlinson <edt@aei.ca>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 09/24/2009 04:34 PM, Ed Tomlinson wrote:
> Hi,
>
> I just had a strange freeze with 2.6.31.1-rc1.  Looking at the console log from startup I see that ata4&  ata5 have nothing connected.
> Later while working the box stalled.  Checking the serial console I say messages from ata4&  ata5...  There really is nothing plugged
> into the connectors.  Any ideas on what might have happened?
>
> Thanks
> Ed
>
>  From startup:

Missing the part that says which driver this is. Can you post the full 
boot log?

>
> [    2.138060] ata4: SATA link down (SStatus 0 SControl 300)
> [    2.138064] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.138417] ata5: SATA link down (SStatus 0 SControl 300)
> [    2.138818] ata3.00: ATA-8: WDC WD10EADS-00L5B1, 01.01A01, max UDMA/133
> [    2.138820] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [    2.140637] ata3.00: configured for UDMA/133
> [    2.142441] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.153147] ata2.00: ATA-7: WDC WD3200KS-00PFB0, 21.00M21, max UDMA/133
> [    2.153150] ata2.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 1)
> [    2.153878] ata2.00: configured for UDMA/133
> [    2.198790] ata6: SATA link down (SStatus 0 SControl 300)
> [    2.545040] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.556880] ata1.00: ATA-7: Maxtor 6L250S0, BACE1G10, max UDMA/133
> [    2.566684] ata1.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [    2.580221] ata1.00: configured for UDMA/133
>
> Last messages before it stalled:
>
> [49844.950401] ata4: exception Emask 0x73 SAct 0x0 SErr 0xffffffff action 0xe frozen
> [49844.950630] ata5: exception Emask 0x73 SAct 0x0 SErr 0xffffffff action 0xe frozen
> [49844.950677] ata5: irq_stat 0xffffffff, unknown FIS 00000000 00000000 00000000 00000000, host bus
> [49844.950725] ata5: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC
> [49844.950863] ata5: hard resett

The registers returning all ones suggests the hardware somehow went away 
or stopped responding to reads properly..
