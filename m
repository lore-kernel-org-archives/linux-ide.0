From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: hdparm ATA Security Options return errors
Date: Thu, 20 Oct 2005 13:18:30 +0200
Message-ID: <43577D06.5060006@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BEBC@WDSCEXBECL03.sc.wdc.com> <43574C73.4000404@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop.gmx.de ([213.165.64.20]:2532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751479AbVJTLSq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Oct 2005 07:18:46 -0400
In-Reply-To: <43574C73.4000404@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

thomas schorpp wrote:
> Timothy Thelin wrote:
> 
>>>hdparm-6.3 is now out, with working security commands.
>>>
>>>But there is still a bug deep in the IDE taskfile code
>>>that sometimes causes problems.  Someday I might have time
>>>to dig deeper into the kernel and fix that issue.
>>>
>>
>>
>>And what bug is this? (Sorry if you already stated it, I didn't see it while
>>going through the archives of this conversation).  I use taskfile and have a
>>vested interest in getting all taskfile bugs fixed.  FYI there was a bug
>>where pio-out taskfile commands could oops because of a null request
>>pointer; the patch I submitted for that one should be in the 2.6.14 rc
>>series now.
>>
>>Regards,
>>Tim Thelin
>>
>>
> 
> 
> at runlevel 1 i get marks crashes too, first the null pointer (which is
> evertime at same address and hopefully fixed with tims patch) then after
> journal commit intervall (mounted xfs,ext3) panic in irq handler and on
> unmounted drives lost interrupt without system stall.
> 
> (yes i want to be able to seclock down mounted fs drives)
> 

heres the panic log from minicom over serial console with ata security
commands (unlock/disable):
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c03e8235
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: af_packet ide_cd cdrom psmouse pcspkr ns558 floppy
via_agp agpgart via_rhine mii ehci_hcd snd_usb_audio snd_usb_lib
uhci_hcd usbcore dm_mod evdev w83627hf i2c_sensor i2c_isa i2c_viapro
dvb_ttpci dvb_core l64781 saa7146_vv video_buf saa7146 v4l1_compat
v4l2_common videodev ves1820 stv0299 tda8083 stv0297 sp8870
firmware_class crc32 ves1x93 ttpci_eeprom i2c_core snd_via82xx
snd_ac97_codec snd_cmipci gameport snd_pcm_oss snd_mixer_oss snd_pcm
snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore rtc unix
CPU:    0
EIP:    0060:[<c03e8235>]    Not tainted VLI
EFLAGS: 00010096   (2.6.13.4debug)
EIP is at pre_task_out_intr+0xb5/0x100
eax: 00000000   ebx: c05d8be8   ecx: ffff586f   edx: c05bd9c8
esi: 00000000   edi: c05d8be8   ebp: dc89fbbc   esp: dc89fb9c
ds: 007b   es: 007b   ss: 0068
Process hdparm (pid: 3931, threadinfo=dc89e000 task=df74baa0)
Stack: c05d8be8 c03e8070 00001d4c 00000000 00000019 dc89fbbc dc89fdf4
c05d88d0
       dc89fbe8 c03e8ca4 c05d8be8 00000000 e0802f87 0000056e dc89fbe0
dc89fdfc
       dc89fd14 c05d88d0 dc89fdf4 dc89fc0c c03e0a31 c05d8be8 dc89fdf4
4089fc0c
Call Trace:
 [<c0104d7f>] show_stack+0x7f/0xa0
 [<c0104f1b>] show_registers+0x15b/0x1c0
 [<c0105178>] die+0x158/0x2c0
 [<c011bc1d>] do_page_fault+0x37d/0x6b2
 [<c0104867>] error_code+0x4f/0x54
 [<c03e8ca4>] flagged_taskfile+0x154/0x370
 [<c03e0a31>] execute_drive_cmd+0x71/0x270
 [<c03e0dae>] start_request+0x17e/0x270
 [<c03e1124>] ide_do_request+0x254/0x4d0
 [<c03e221a>] ide_do_drive_cmd+0x18a/0x2f0
 [<c03e8326>] ide_diag_taskfile+0xa6/0xe0
 [<c03e852e>] ide_taskfile_ioctl+0x19e/0x430
 [<c03deb6f>] generic_ide_ioctl+0x2df/0x730
 [<c03ee5cc>] idedisk_ioctl+0x3c/0x40
 [<c03ccf49>] blkdev_driver_ioctl+0x49/0x80
 [<c03cd01c>] blkdev_ioctl+0x9c/0x1a0
 [<c018eb5b>] block_ioctl+0x2b/0x30
 [<c019cb7d>] do_ioctl+0x7d/0x90
 [<c019cd12>] vfs_ioctl+0x62/0x1c0
 [<c019ced1>] sys_ioctl+0x61/0x90
 [<c0103d69>] syscall_call+0x7/0xb
Code: c3 80 bb 8e 00 00 00 00 75 01 fa c7 44 24 0c 00 00 00 00 c7 44 24
08 4c 1d 00 00 c7 44 24 04 70 80 3e c0 89 1c 24 e8 3b b2 ff ff <8b> 46
2c 85 c0 74 07 c7 46 44 00 00 00 00 8b 43 6c 8b 80 68 06
 <4>hdf: lost interrupt
Unable to handle kernel paging request at virtual address 6b6b6b7b
 printing eip:
c03e7f0f
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: af_packet ide_cd cdrom psmouse pcspkr ns558 floppy
via_agp agpgart via_rhine mii ehci_hcd snd_usb_audio snd_usb_lib
uhci_hcd usbcore dm_mod evdev w83627hf i2c_sensor i2c_isa i2c_viapro
dvb_ttpci dvb_core l64781 saa7146_vv video_buf saa7146 v4l1_compat
v4l2_common videodev ves1820 stv0299 tda8083 stv0297 sp8870
firmware_class crc32 ves1x93 ttpci_eeprom i2c_core snd_via82xx
snd_ac97_codec snd_cmipci gameport snd_pcm_oss snd_mixer_oss snd_pcm
snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore rtc unix
CPU:    0
EIP:    0060:[<c03e7f0f>]    Not tainted VLI
EFLAGS: 00010002   (2.6.13.4debug)
EIP is at task_end_request+0x1f/0x70
eax: 6b6b6b6b   ebx: c05d8be8   ecx: 00000000   edx: dc89fd14
esi: 00000050   edi: c05d8be8   ebp: c057be98   esp: c057be84
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c057a000 task=c04e3c60)
Stack: c16d6be4 c16d6bc0 00000000 c05d88d0 dc89fd14 c057bebc c03e8163
c05d8be8
       dc89fd14 00000050 00000086 c057a000 c16d6bc0 c05d8be8 c057befc
c03e1d5a
       c05d8be8 00000001 c057bf84 c057befc c057a000 00000101 c057a000
c057bef4
Call Trace:
 [<c0104d7f>] show_stack+0x7f/0xa0
 [<c0104f1b>] show_registers+0x15b/0x1c0
 [<c0105178>] die+0x158/0x2c0
 [<c011bc1d>] do_page_fault+0x37d/0x6b2
 [<c0104867>] error_code+0x4f/0x54
 [<c03e8163>] task_out_intr+0xf3/0x110
 [<c03e1d5a>] ide_intr+0x2ba/0x5c0
 [<c0152733>] handle_IRQ_event+0x33/0x70
 [<c015289a>] __do_IRQ+0x12a/0x390
 [<c01066b7>] do_IRQ+0x37/0x70
 [<c010479e>] common_interrupt+0x1a/0x20
 [<c0101107>] cpu_idle+0x57/0x60
 [<c010027b>] rest_init+0x3b/0x40
 [<c057c867>] start_kernel+0x187/0x1d0
 [<c0100199>] 0xc0100199
Code: b6 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 14 8b 55 0c 89
5d f8 89 75 fc 8b 5d 08 0f b6 75 10 f6 42 0a 02 74 0a 8b 42 68 <66> 83
78 10 00 75 1f 8b 42 24 89 1c 24 c7 44 24 04 01 00 00 00
 <0>Kernel panic - not syncing: Fatal exception in interrupt

