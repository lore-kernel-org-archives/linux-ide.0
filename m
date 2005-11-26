From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Q: IDE->SATA adaptor
Date: Sat, 26 Nov 2005 23:32:58 +1100
Message-ID: <438855FA.6050100@eyal.emu.id.au>
References: <438826A2.2020204@eyal.emu.id.au> <20051126112844.GA10006@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:62011
	"EHLO mail-ihug.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S1750854AbVKZMdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Nov 2005 07:33:03 -0500
In-Reply-To: <20051126112844.GA10006@midnight.suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Vojtech Pavlik wrote:
> On Sat, Nov 26, 2005 at 08:10:58PM +1100, Eyal Lebedinsky wrote:
>
>>I am still looking for a working setup for adding more SATA
>>disks to my machine. I acquired a small PCB that plugs into
>>the IDE socket on the mobo and provides two SATA sockets.
>>
>>It worked out of the box, except that it only does udma2. Not
>>what I want.
>>
>>If I try to set it to a higher mode I get the message
>>	hdc: Speed warnings UDMA 3/4/5 is not functional.
>>
>>After some digging into the ide code I identified the problem
>>as 'id->hw_config' being zero. In two places it is checked
>>before allowing higher udma modes. One bit seems to be related
>>to the 80c (which has no meaning here and should probably
>>be hardwired on the board) and the other I am not sure.
>
>
> What IDE controller are you using?

I do not think that it matters. ide0 sees its disks just
fine. ide1 had no problems in the past. It is only when the
adaptor is plugged in that this problem is seen. Nevertheless,
this is an ICH5:

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)

>>I patched ide-iops.c to not check hw_config in the two funcs
>>where it does so:
>>	eighty_ninty_three
>>	ide_ata66_check
>>
>>
>>BTW my .config says:
>>	CONFIG_BLK_DEV_IDEDMA=y
>>	CONFIG_IDEDMA_IVB=y
>>	CONFIG_IDEDMA_AUTO=y
>>
>>but the IVB is not enough here.
>>
>>
>>Does anyone know what is the correct way to get this adapter going without
>>a patch?
>
> I think specifying "ide0=ata66" on the kernel command line could help.

I added 'ide1=ata66' and it did not help. I also got the messages:

Kernel command line: BOOT_IMAGE=2.6.14.3 ro root=306 console=ttyS0,38400 console=tty0 irqpoll ide1=ata66 single
ide_setup: ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
