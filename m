From: Doug McLain <nostar@comcast.net>
Subject: Re: [Fwd: Re: sata_sil problems (lockup at boottime)]
Date: Tue, 08 Feb 2005 17:04:47 +0000
Message-ID: <4208F12F.3020705@comcast.net>
References: <4208483C.2060808@comcast.net> <200502081136.05737.rme@image.dk> <420859A7.2000407@comcast.net> <200502081539.35528.rme@image.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from sccrmhc13.comcast.net ([204.127.202.64]:4234 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261532AbVBHWEQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Feb 2005 17:04:16 -0500
In-Reply-To: <200502081539.35528.rme@image.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rme@image.dk
Cc: linux-ide@vger.kernel.org

These things were the first things I did when I encountered this 
problem:  I am running current BIOS version 1008 with sil 3112A bios 
version 4.2.27.  I have done 'Load Setup Defaults' after upgrading the 
bios, and tried various settings with no luck. After finding other posts 
with the same problem, I finally came to this list.

I happened to catch an oops this time, here it is:

sata_sil version 0.8
ata1: SATA max UDMA/100 cmd 0xE09FC080 ctl 0xE09FC08A bmdma 0xE09FC000 
irq 11
ata2: SATA max UDMA/100 cmd 0xE09FC0C0 ctl 0xE09FC0CA bmdma 0xE09FC008 
irq 11
irq 11: nobody cared!
  [<c012fbea>] __report_bad_irq+0x2a/0x90
  [<c012f5a0>] handle_IRQ_event+0x30/0x70
  [<c012fcdc>] note_interrupt+0x6c/0xd0
  [<c012f710>] __do_IRQ+0x130/0x160
  [<c01042b9>] do_IRQ+0x19/0x30
  [<c010289a>] common_interrupt+0x1a/0x20
  [<c0117830>] __do_softirq+0x30/0x90
  [<c01178b6>] do_softirq+0x26/0x30
  [<c012f564>] irq_exit+0x34/0x40
  [<c01042be>] do_IRQ+0x1e/0x30
  [<c010289a>] common_interrupt+0x1a/0x20
  [<c01005f0>] default_idle+0x0/0x30
  [<c0100613>] default_idle+0x23/0x30
  [<c010068a>] cpu_idle+0x3a/0x60
  [<c03ca767>] start_kernel+0x147/0x160
  [<c03ca360>] unknown_bootoption+0x0/0x1b0
handlers:
[<c0273770>] (usb_hcd_irq+0x0/0x70)
[<e0975580>] (snd_ice1712_interrupt+0x0/0x250 [snd_ice1712])
[<e0a65460>] (ata_interrupt+0x0/0x1c0 [libata])
Disabling IRQ #11
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA, max UDMA/100, 390721968 sectors: lba48


Rasmus Melgaard wrote:
> Well I had no problems in windows either! ... try loading bios setup defaults 
> settings or/and upgrade bios.
> 
> /rasmus
> 
> On Tuesday 08 February 2005 07:18, Doug McLain wrote:
> 
>>In my case the MB is an A7N8X, and that option is nowhere to be found in
>>my bios.  My hardware lockup only occurs in linux, and the drive works
>>fine in windows.  Also, if I load the sil_sata driver with the drive not
>>attatched, it loads fine, as reported by the others as well. Only if the
>>drive is attatched, does a hard lock occur after a modprobe.
>>
>>Thanks anyway
>>
>>Rasmus Melgaard wrote:
>>
>>>Hi,
>>>
>>>I had problems with the sata_sil (pci sil3112) at boot time, the problem
>>>was bios settings for the PCI bus. I disabled 'BYTE MERGE' on my Asus A7V
>>>board and i worked.
>>>
>>>Rasmus
>>>
>>>On Tuesday 08 February 2005 06:03, Doug McLain wrote:
>>>
>>>>Any word on this? It's been reported here a few times now.
>>>>
>>>>I am having exactly the same problem, the only difference being the
>>>>model of drive.  Mine is a WD2000.  The sata_sil module loads ok though,
>>>>if the drive is not connected.  If it is connected, hard lock.  Tested
>>>>on 2.4.25, 2.6.9, 2.6.10.
>>>>
>>>>Doug
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>Encapsulated message
>>>>
>>>>
>>>>Re: sata_sil problems (lockup at boottime)
>>>>
>>>>
>>>>From:
>>>>Doug McLain <nostar@comcast.net>
>>>>
>>>>
>>>>To:
>>>>Gerald Hopf <gerald.hopf@nv-systems.net>, linux-kernel@vger.kernel.org
>>>>
>>>>
>>>>Date:
>>>>2005-01-10 16:34
>>>>
>>>>Gerald Hopf wrote:
>>>>
>>>>>Hello everyone,
>>>>>
>>>>>i'm having some really strange problems with the sata_sil driver.
>>>>>
>>>>>My hardware:
>>>>>Asus A7N8X Deluxe Rev 1.x with onboard Sil3112 Controller
>>>>>- Samsung SP1614C SATA Harddrive
>>>>>- for further testing : PATA to SATA Adapter that came with an ABIT
>>>>>Mainboard
>>>>>
>>>>>What i'm trying to accomplish: i'm trying to use this Samsung SATA
>>>>>harddrive in my Linux Fileserver:
>>>>>
>>>>>When the Silicon Image Controller is enabled (it can be disabled by a
>>>>>jumper) and no harddrive is connected, everything boots fine.
>>>>>If i connect a harddrive, i get the following message (exact messages
>>>>>change slightly) while booting:
>>>>>
>>>>>- - - - -  START  - - - - -
>>>>>======================
>>>>>[<c0102716>] common_interrupt+0x1a/0x20
>>>>>[<c0117d70>] __do_softirq+0x30/0x90
>>>>>[<c0104261>] do_softirq+0x41/0x50
>>>>>======================
>>>>>[<c012d0a4>] irq_exit+0x34/0x40
>>>>>[<c0104165>] do_IRQ+9x45/0x60
>>>>>[<c0102716>] common_interrupt+0x1a/0x20
>>>>>[<c010c674>] delay_tsc+0x14/0x20
>>>>>[<c025efd2>] __delay+0x12/0x20
>>>>>[<c02d7290>] ata_pio_complet+0xe0/0x1f0
>>>>>[<c02d7a95>] ata_pio_test+0x95/0xb0
>>>>>[<c01229bc>] worker_thread+0x1cc/0x290
>>>>>[<c02d7a00>] ata_pio_task+0x0/0xb0
>>>>>[<c0110160>] default_wake_function+0x0/0x20
>>>>>[<c0110160>] default_wake_function+0x0/0x20
>>>>>[<c01227f0>] worker_thread+0x0/0x290
>>>>>[<c0126ca5>] kthread+0xa5/0xb0
>>>>>[<c0126c00>] kthread+0x0/0xb0
>>>>>[<c01006f1>] kernel_thread_helper+0x5/0x14
>>>>>handlers:
>>>>>[<c02d82b0>] (ata_interrupt+0x0/0x1c0)
>>>>>Disabling IRQ #11
>>>>>ata: dev 0 ATA, max UDMA/100, 361882080 sectors: lba 48
>>>>>_
>>>>>- - - - -  END - - - - -
>>>>>
>>>>>This happens with both the Samsung SP1614C "native" SATA drive, as well
>>>>>as with an IBM 180GB PATA drive, using a PATA-to-SATA Adapter.
>>>>>So i'm not sure whether this is harddrive dependent, but at least it
>>>>>doesn't look like it...
>>>>>
>>>>>This problem has been there in all of the latest 2.6.X kernel revisions.
>>>>>I'm currently using 2.6.10-rc3 (which came out today), but i've allready
>>>>>had this problem in 2.6.9 and 2.6.8 and probably even 2.6.7 if i
>>>>>remember correctly.
>>>>>
>>>>>I tried quite a lot to get rid of those problems, including:
>>>>>- Flashing a new/different Bios (even with different versions of the
>>>>>Silicon Image SATA Bios part: 4.2.47 and 4.2.50)
>>>>>- Disabling APIC in the Bios, compiling Kernel with or without APIC
>>>>>- Changing the IRQ of the Controller by reserving IRQ#11 in the Bios
>>>>>- Disabling allmost every other onboard device i could, including
>>>>>serial/parallel/usb/firewire/3com lan (and there are no PCI/Addon cards
>>>>>besides an nvidia geforce2mx agp card installed in this pc anyway!)
>>>>>- Connecting drives to both ports
>>>>>
>>>>>I found the following discussions which might be related to what i'm
>>>>>experiencing, but noone seems to have a solution. Some seem to suggest
>>>>>it worked fine till 2.6.5:
>>>>>(The first two seem to be most related, i'm not so sure of the third
>>>>>one) http://www.fedoraforum.org/forum/archive/index.php/t-26543.html
>>>>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128180
>>>>>http://www.fedoraforum.org/forum/archive/index.php/t-23028.html
>>>>>
>>>>>Screenshots of the error messages can be found here:
>>>>>http://www.nv-systems.net/pics/lkml/sata_sil1.jpg <-- the one from above
>>>>>http://www.nv-systems.net/pics/lkml/sata_sil2.jpg <-- with samsung
>>>>>instead of ibm
>>>>>http://www.nv-systems.net/pics/lkml/sata_sil3.jpg <-- the screen just
>>>>>before the problem
>>>>>
>>>>>Is there ANYTHING i can do (except buying a promise controller) ?
>>>>>
>>>>>Yours sincerely,
>>>>>                   Gerald
>>>>
>>>>I am having exactly the same problem, the only difference being the
>>>>model of drive.  Mine is a WD2000.  The sata_sil module loads ok though,
>>>>if the drive is not connected.  If it is connected, hard lock.  Tested
>>>>on 2.4.25, 2.6.9, 2.6.10.
>>>>
>>>>Doug
>>>>
>>>>--
>>>>http://nostar.net/
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>>>in the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>End of encapsulated message
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
http://nostar.net/
