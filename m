From: "Winstel, Drew" <DWinstel@Miltope.com>
Subject: RE: PDC20269: Limit on number of controllers?
Date: Wed, 23 Feb 2005 14:58:28 -0600
Message-ID: <66F9227F7417874C8DB3CEB057727417044FA0@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Received: from firewall.miltope.com ([208.12.184.221]:55138 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261584AbVBWU63 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 15:58:29 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Hello again,

>With 2.6.10 + pdc20269, there is a known problem on ATAPI DMA.
>Please use 2.6.11 to test ATAPI.
Easier said than done.  Using 2.6.11-rc4-bk9, I get an oops 
(see below) with any drives attached.  This occurs whether I 
use one or four controllers.  

How might I get to working around this?  I'll try the next 
snapshot that includes the latest round of libata fixes to 
see if it helps.

Thanks again,

Drew

SCSI device sda: drive cache: write back
 sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde=00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<00000000>]   Not tainted VLI
EFLAGS: 00010093      (2.6.11-rc4-bk9)
EIP is at 0x0           c13071bc
eax: c044c1c0     ebx: c13071bc     ecx: c13bd880     edx: 00000032
esi: 00000000     edi: c1307688     ebp: c13928e0     esp: c04b7f90
ds: 007b   es: 0007b   ss:0068
Process swapper (pid: 0, threadinfo=c04b7000 task=c03dbb20)
Stack: c02c54f6 c13071bc c0484fa0 c0484fa0 00000282 00000000 c13bd880 00000000
       c0484fa0 0000000b c012be20 0000000b c13928e0 c0484fa0 00000000 0000000b
       c0483cc0 c13bd880 c0484fa0 c012bf0b 0000000b c0483a00 00000001 c0484f90
Call Trace:
 [<c02c54f6>] ata_interrupt+0x76/0x110
 [<c012be20>] handle_IRQ_event+0x30/0x70
 [<c012bf0b>] __do_IRQ_event+0xab/0x120
 [<c0104162>] do_IRQ+0x42/0x70
 ========================
 [<c0100570>] default_idle+0x0/0x30
 [<c010283e>] common_interrupt+0x1a/0x20
 [<c0100570>] default_idle+0x0/0x30
 [<c0100594>] default_idle+0x24/0x30
 [<c010062c>] cpu_idle+0x4c/0x60
 [<c048575c>] start_kernel+0x13c/0x160
 [<c0485330>] unknown_bootoption+0x0/0x1e0
Code: Bad EIP value.
 <0>Kernel panic - not syncing: Fatal exception in interrupt



