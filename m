From: David Greaves <david@dgreaves.com>
Subject: Oops after assertion in drivers/scsi/libata-core.c
Date: Sun, 02 Apr 2006 11:15:11 +0100
Message-ID: <442FA42F.5030603@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:64659 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932272AbWDBKOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 06:14:39 -0400
Received: from localhost.localdomain (i-83-67-36-194.freedom2surf.net [83.67.36.194])
	by mail.ukfsn.org (Postfix) with ESMTP id 30A54E6F31
	for <linux-ide@vger.kernel.org>; Sun,  2 Apr 2006 11:12:15 +0100 (BST)
Received: from [10.0.0.90] (helo=[10.0.0.90])
	by localhost.localdomain with esmtp (Exim 4.50)
	id 1FPzbR-0006QX-Gu
	for linux-ide@vger.kernel.org; Sun, 02 Apr 2006 11:14:37 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I was doing a mdadm --examine /dev/sda trying to get some data to
followup my last posts.

I got this in dmesg
ata1: command 0x25 timeout, stat 0xd0 host_stat 0x1
ata1: translated op=0x28 cmd=0x25 ATA stat/err 0xd0/00 to SCSI
SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
end_request: I/O error, dev sda, sector 390716735
Buffer I/O error on device sda1, logical block 195358336
ATA: abnormal status 0xD0 on port 0xF0804087

and then this:

Assertion failed! qc !=
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2901
<repeated hundreds of times>
Assertion failed! qc !=
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2901
Assertion failed! qc !=
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2901
Unable to handle kernel NULL pointer dereference at virtual address 0000008c
 printing eip:
b02a6292
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: nfs nfsd lockd sunrpc af_packet dm_mod ide_disk
snd_seq_midi snd_seq_midi_event snd_seq sk98lin snd_via82xx
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd evdev skge
via_agp agpgart crc32 soundcore uhci_hcd ehci_hcd usbcore i2c_viapro
i2c_core
CPU:    0
EIP:    0060:[<b02a6292>]    Tainted: G   M  VLI
EFLAGS: 00010297   (2.6.16libataverbose #6)
EIP is at ata_pio_task+0x582/0x800
eax: 0dfbaa1c   ebx: 00000004   ecx: b038405c   edx: 00000002
esi: 00000002   edi: 00000000   ebp: efb1f280   esp: efcfdef8
ds: 007b   es: 007b   ss: 0068
Process ata/0 (pid: 730, threadinfo=efcfc000 task=efedf590)
Stack: <0>efb1f280 b035bfd3 b035bf6f b033da0d 00000b55 efcfdf68 00000002
b012caff
       efcfdf34 00000082 00000000 00000000 efb1f830 efb1f82c efcfc000
efb24e20
       b012c830 efb1f280 efedf6b8 b0381300 efb24e28 efb24e38 00000286
b02a5d10
Call Trace:
 [<b012caff>] worker_thread+0x14f/0x160
 [<b012c830>] run_workqueue+0x90/0x130
 [<b02a5d10>] ata_pio_task+0x0/0x800
 [<b012cad0>] worker_thread+0x120/0x160
 [<b01186d0>] default_wake_function+0x0/0x20
 [<b012ffda>] kthread+0xea/0xf0
 [<b012c9b0>] worker_thread+0x0/0x160
 [<b012fef0>] kthread+0x0/0xf0
 [<b0101005>] kernel_thread_helper+0x5/0x10
Code: 36 b0 89 44 24 04 e8 ae 66 e7 ff 8b 4c 24 20 83 89 8c 00 00 00 04
c7 86 dc 05 00 00 07 00 00 00 8b 95 dc 05 00 00 e9 8f fa ffff <83> 8f 8c
00 00 00 04 ba 03 00 00 00 c7 85 dc 05 00 00 03 00 00


David

-- 

