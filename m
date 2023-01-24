Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59812C54EED
	for <linux-ide@archiver.kernel.org>; Tue, 24 Jan 2023 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjAXRIK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjAXRH5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 12:07:57 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C04C0E4
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 09:06:42 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=fdjfAblv6ZSdASbRo1SLmDklBZTes1EJxcz4n4PFFzA=;
        b=APAAIVTGrv18QcF7f3r9Yp9AXJtjRxFrHQyI4antJrwzg1UikbFZH70ovRePaj2tihBQOG2ltvQ7RV2SPkd611nDcZ4GEQSey6/jNepW0cR+ycas2gX3V1OOF9kWxQZtLrtE2zolY7ZZ0hs7cq8hSCeEbVOEMdyXRBr9QGJBQjEm4nRwqSdCe8tjpVbWJ/6Ht+tS5cDWzOWFuQpcH4ovZk+RLtsE9wBp13Hp2NNof3UUtufvldy8KrWvlX
        SwTmBg6DUp+ISd5Y8rLtUvyCITR7zMFTLiDAltpFOSNPiENXw3TEU5STbFp65QLZUY3er2999R0cQtaxIh3arroaVUSw==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 24 Jan 2023 17:06:22 +0000
MIME-Version: 1.0
Date:   Tue, 24 Jan 2023 17:06:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <1b8e19c35328d8dffb80fe20c6797525@psihoexpert.ro>
Subject: Bug report for sata_via driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <7521d86e-a83e-7972-a4cc-55dd7155fa43@opensource.wdc.com>
References: <7521d86e-a83e-7972-a4cc-55dd7155fa43@opensource.wdc.com>
 <1b1f8ab0-9a2d-93e3-66f0-18597e80b790@opensource.wdc.com>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi. It's me again.

May I bother you with another bug? (^_^;)

The machine is a Lenovo X61 Tablet, a tablet PC with Intel GM965 / ICH8-M=
.
It has a cardbus slot (32bit PCI), Ricoh RL5C476 II (VEN_1180 DEV_0476).
The card is a VIA VT6421 (VEN_1106 DEV_3249) SATA/PATA controller.
The card has 2 SATA ports and no PATA.

---- CARD INSERTED ----
[ 68.118063] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted =
into slot 0
[ 68.121922] pci 0000:06:00.0: [1106:3249] type 00 class 0x010400
[ 68.121972] pci 0000:06:00.0: reg 0x10: [io 0x0af0-0x0aff]
[ 68.121996] pci 0000:06:00.0: reg 0x14: [io 0x0a70-0x0a7f]
[ 68.122018] pci 0000:06:00.0: reg 0x18: [io 0x01f0-0x01ff]
[ 68.122039] pci 0000:06:00.0: reg 0x1c: [io 0x0170-0x017f]
[ 68.122059] pci 0000:06:00.0: reg 0x20: [io 0xcc00-0xcc1f]
[ 68.122080] pci 0000:06:00.0: reg 0x24: [io 0x8c00-0x8cff]
[ 68.122419] pci 0000:06:00.0: BAR 5: assigned [io 0x4000-0x40ff]
[ 68.122438] pci 0000:06:00.0: BAR 4: assigned [io 0x4400-0x441f]
[ 68.122451] pci 0000:06:00.0: BAR 0: assigned [io 0x4420-0x442f]
[ 68.122465] pci 0000:06:00.0: BAR 1: assigned [io 0x4430-0x443f]
[ 68.122478] pci 0000:06:00.0: BAR 2: assigned [io 0x4440-0x444f]
[ 68.122491] pci 0000:06:00.0: BAR 3: assigned [io 0x4450-0x445f]
[ 68.122639] sata_via 0000:06:00.0: version 2.6
[ 68.122662] sata_via 0000:06:00.0: enabling device (0000 -> 0001)
[ 68.122879] sata_via 0000:06:00.0: routed to hard irq line 0
[ 68.122903] [79] sata_via:svia_configure:635: sata_via 0000:06:00.0: ena=
bling SATA hotplug (0x0)
[ 68.124012] scsi host6: sata_via
[ 68.126042] scsi host7: sata_via
[ 68.128757] scsi host8: sata_via
[ 68.128927] ata6: SATA max UDMA/133 port i16@0x4420 bmdma 0x4400 irq 16
[ 68.128938] ata7: SATA max UDMA/133 port i16@0x4430 bmdma 0x4408 irq 16
[ 68.128944] ata8: PATA max UDMA/133 port i16@0x4440 bmdma 0x4410 irq 16
[ 68.129071] hardreset, Online=3D>Offline
[ 68.130162] resume, do loop
[ 68.348135] resume, after do loop
[ 68.353240] debounce, SCR=3D0x0
[ 68.358342] debounce, SCR=3D0x0
...
[ 68.455069] debounce, SCR=3D0x0
[ 68.460159] debounce, SCR=3D0x0
[ 68.460166] resume, return at end of function
[ 68.460171] hardreset, ata_phys_link_offline check failed
[ 68.470148] [2358] libata:ata_wait_idle:2049: ata6: abnormal Status 0x7F
[ 68.472385] ata6: SATA link down (SStatus 0 SControl 310)
[ 68.482547] hardreset, Online=3D>Offline
[ 68.483633] resume, do loop
[ 68.698036] resume, after do loop
[ 68.703129] debounce, SCR=3D0x0
[ 68.708218] debounce, SCR=3D0x0
...
[ 68.804763] debounce, SCR=3D0x0
[ 68.809851] debounce, SCR=3D0x0
[ 68.809858] resume, return at end of function
[ 68.809863] hardreset, ata_phys_link_offline check failed
[ 68.819838] [2360] libata:ata_wait_idle:2049: ata7: abnormal Status 0x7F
[ 68.822067] ata7: SATA link down (SStatus 0 SControl 310)
[ 69.008039] [2363] libata:ata_wait_idle:2049: ata8: abnormal Status 0x8

---- EXTERNAL HDD CONNECTED ----
[ 118.683511] irq 16: nobody cared (try booting with the "irqpoll" option=
)
[ 118.684531] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc8-M95D+ #=
1
[ 118.684538] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 =
) 03/22/2011
[ 118.684542] Call Trace:
[ 118.684547] <IRQ>
[ 118.684550] dump_stack_lvl+0x34/0x44
[ 118.684561] __report_bad_irq+0x30/0xa2
[ 118.684569] note_interrupt.cold+0xb/0x61
[ 118.684575] handle_irq_event+0x65/0x70
[ 118.684581] handle_fasteoi_irq+0x8b/0x1c0
[ 118.684588] __common_interrupt+0x5a/0xf0
[ 118.684596] common_interrupt+0x9f/0xc0
[ 118.684601] </IRQ>
[ 118.684604] <TASK>
[ 118.684606] asm_common_interrupt+0x22/0x40
[ 118.684614] RIP: 0010:cpuidle_enter_state+0xbb/0x280
[ 118.684625] Code: e8 ea 91 3d ff 31 ff 49 89 c5 e8 90 09 3d ff 45 84 f6=
 74 12 9c 58 f6 c4 02 0f
85 b7 01 00 00 31 ff e8 a9 fc 40 ff fb 45 85 ff <0f> 88 b6 00 00 00 49 63=
 d7 4c 2b 2c 24 48 8d 04
52 48 8d 04 82 49
[ 118.684630] RSP: 0018:ffffffff82e03e50 EFLAGS: 00000202
[ 118.684636] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000=
000000
[ 118.684640] RDX: 0000000000000002 RSI: 000000000000db43 RDI: 00000000ff=
ffffff
[ 118.684644] RBP: ffff88810032bc00 R08: 0000000000000000 R09: 0000000000=
000008
[ 118.684647] R10: 0000000000000002 R11: 0000000000000002 R12: ffffffff82=
eba020
[ 118.684651] R13: 0000001ba2166ad8 R14: 0000000000000001 R15: 0000000000=
000002
[ 118.684656] cpuidle_enter+0x24/0x40
[ 118.684664] do_idle+0x1ac/0x230
[ 118.684669] cpu_startup_entry+0x14/0x20
[ 118.684674] rest_init+0xb6/0xc0
[ 118.684680] arch_call_rest_init+0x5/0x33
[ 118.684689] start_kernel+0x6c6/0x6f6
[ 118.684695] secondary_startup_64_no_verify+0xce/0xdb
[ 118.684701] </TASK>
[ 118.684704] handlers:
[ 118.685717] [<0000000065d27af3>] i965_irq_handler
[ 118.686730] [<00000000377926d6>] yenta_interrupt
[ 118.687754] [<000000005c02c4d7>] usb_hcd_irq
[ 118.688785] [<00000000440e256d>] vt642x_interrupt
[ 118.689790] Disabling IRQ #16

---- EJECT CARD ----
[ 136.498083] pcmcia_socket pcmcia_socket0: pccard: card ejected from slo=
t 0
[ 136.498159] hardreset, Online=3D>Offline
[ 136.500751] Reconfig spd
[ 136.500807] hardreset, Online=3D>Offline
[ 136.500815] Reconfig spd
[ 136.501858] resume, do loop
[ 136.501968] resume, do loop
[ 136.718048] resume, do loop
[ 136.718089] resume, do loop
[ 136.938104] resume, do loop
[ 136.938115] resume, do loop
[ 137.158076] resume, do loop
[ 137.158108] resume, do loop
[ 137.378105] resume, do loop
[ 137.378115] resume, do loop
[ 137.598082] resume, after do loop
[ 137.598086] ata6: failed to resume link (SControl FFFFFFFF)
[ 137.599831] hardreset, ata_phys_link_offline check failed
[ 137.599872] ata6: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 137.599897] resume, after do loop
[ 137.599900] ata7: failed to resume link (SControl FFFFFFFF)
[ 137.599965] ------------[ cut here ]------------
[ 137.601620] hardreset, ata_phys_link_offline check failed
[ 137.601618] WARNING: CPU: 1 PID: 79 at drivers/ata/libata-core.c:5910 a=
ta_host_detach+0x1c7/0x1d0
[ 137.601661] ata7: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 137.603368] CPU: 1 PID: 79 Comm: pccardd Not tainted 6.1.0-rc8-M95D+ #1
[ 137.603375] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 =
) 03/22/2011
[ 137.603378] RIP: 0010:ata_host_detach+0x1c7/0x1d0
[ 137.603385] Code: c0 74 11 48 89 f9 48 85 c9 0f 85 fd fe ff ff e9 70 ff=
 ff ff 49 8b 8c 24 80 35
00 00 48 85 c9 0f 84 5f ff ff ff e9 e2 fe ff ff <0f> 0b e9 b7 fe ff ff 66=
 90 48 8b bf 40 01 00 00
e9 24 fe ff ff 0f
[ 137.603391] RSP: 0018:ffff88810115fdf0 EFLAGS: 00010246
[ 137.603397] RAX: 00000000fffffffd RBX: 0000000000000000 RCX: 0000000000=
000000
[ 137.603401] RDX: ffff888102b07000 RSI: 0000000000000246 RDI: 00000000ff=
ffffff
[ 137.603405] RBP: ffff8881056df300 R08: 0000000000000000 R09: 0000000000=
000000
[ 137.603409] R10: 0000000000000002 R11: 0000000000000000 R12: ffff888105=
e00000
[ 137.603412] R13: 0000000000000286 R14: 0000000000000080 R15: 0000000000=
000000
[ 137.603416] FS: 0000000000000000(0000) GS:ffff888137d00000(0000) knlGS:=
0000000000000000
[ 137.603421] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 137.603425] CR2: 00007ffcdef7bd50 CR3: 0000000002e0a000 CR4: 0000000000=
0006e0
[ 137.603429] Call Trace:
[ 137.603437] <TASK>
[ 137.603440] pci_device_remove+0x2c/0x90
[ 137.603451] device_release_driver_internal+0x1a1/0x220
[ 137.603458] pci_stop_bus_device+0x63/0x80
[ 137.603467] pci_stop_and_remove_bus_device+0x9/0x20
[ 137.603475] cb_free+0x31/0x50
[ 137.603481] socket_shutdown+0xab/0x100
[ 137.603486] pccardd.cold+0x8/0x67
[ 137.603493] ? pcmcia_socket_dev_complete+0x70/0x70
[ 137.603498] kthread+0xe0/0x110
[ 137.603506] ? kthread_exit+0x30/0x30
[ 137.603513] ret_from_fork+0x1f/0x30
[ 137.603520] </TASK>
[ 137.603522] ---[ end trace 0000000000000000 ]---

---- CONNECT CARD WITH HDD ALREADY ATTACHED ----
[ 168.768069] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted=
 into slot 0
[ 168.771207] pci 0000:06:00.0: [1106:3249] type 00 class 0x010400
[ 168.771256] pci 0000:06:00.0: reg 0x10: [io 0x0af0-0x0aff]
[ 168.771280] pci 0000:06:00.0: reg 0x14: [io 0x0a70-0x0a7f]
[ 168.771302] pci 0000:06:00.0: reg 0x18: [io 0x01f0-0x01ff]
[ 168.771322] pci 0000:06:00.0: reg 0x1c: [io 0x0170-0x017f]
[ 168.771343] pci 0000:06:00.0: reg 0x20: [io 0xcc00-0xcc1f]
[ 168.771363] pci 0000:06:00.0: reg 0x24: [io 0x8c00-0x8cff]
[ 168.771695] pci 0000:06:00.0: BAR 5: assigned [io 0x4000-0x40ff]
[ 168.771713] pci 0000:06:00.0: BAR 4: assigned [io 0x4400-0x441f]
[ 168.771727] pci 0000:06:00.0: BAR 0: assigned [io 0x4420-0x442f]
[ 168.771742] pci 0000:06:00.0: BAR 1: assigned [io 0x4430-0x443f]
[ 168.771756] pci 0000:06:00.0: BAR 2: assigned [io 0x4440-0x444f]
[ 168.771769] pci 0000:06:00.0: BAR 3: assigned [io 0x4450-0x445f]
[ 168.771908] sata_via 0000:06:00.0: enabling device (0000 -> 0001)
[ 168.772137] sata_via 0000:06:00.0: routed to hard irq line 0
[ 168.772162] [79] sata_via:svia_configure:635: sata_via 0000:06:00.0: en=
abling SATA hotplug (0x0)
[ 168.773265] scsi host6: sata_via
[ 168.775256] scsi host7: sata_via
[ 168.788766] scsi host8: sata_via
[ 168.788866] ata9: SATA max UDMA/133 port i16@0x4420 bmdma 0x4400 irq 16
[ 168.788872] ata10: SATA max UDMA/133 port i16@0x4430 bmdma 0x4408 irq 1=
6
[ 168.788875] ata11: PATA max UDMA/133 port i16@0x4440 bmdma 0x4410 irq 1=
6
[ 168.788961] hardreset, Online=3D>Offline
[ 168.790037] resume, do loop
[ 169.008036] resume, after do loop
[ 169.013116] debounce, SCR=3D0x1
[ 169.018189] debounce, SCR=3D0x1
...
[ 170.054131] debounce, SCR=3D0x1
[ 170.059209] debounce, SCR=3D0x1
[ 170.062091] irq 16: nobody cared (try booting with the "irqpoll" option=
)
[ 170.062095] CPU: 0 PID: 2356 Comm: tee Tainted: G W 6.1.0-rc8-M95D+ #1
[ 170.062100] Hardware name: LENOVO 776702U/776702U, BIOS 7SET39WW (1.25 =
) 03/22/2011
[ 170.062102] Call Trace:
[ 170.062107] <IRQ>
[ 170.062109] dump_stack_lvl+0x34/0x44
[ 170.062117] __report_bad_irq+0x30/0xa2
[ 170.062123] note_interrupt.cold+0xb/0x61
[ 170.062128] handle_irq_event+0x65/0x70
[ 170.062133] handle_fasteoi_irq+0x8b/0x1c0
[ 170.062138] __common_interrupt+0x5a/0xf0
[ 170.062144] common_interrupt+0x9f/0xc0
[ 170.062148] </IRQ>
[ 170.062150] <TASK>
[ 170.062151] asm_common_interrupt+0x22/0x40
[ 170.062157] RIP: 0010:cfb_imageblit+0x3e8/0x800
[ 170.062163] Code: 0f 84 4c fe ff ff 48 8b 5c 24 40 48 01 5c 24 10 4c 8b=
 6c 24 10 03 6c 24 04 83
e5 1f 49 83 e5 fc e9 32 fe ff ff 44 89 44 24 18 <45> 89 f1 e9 a9 fc ff ff=
 48 8b 83 28 03 00 00 46
8b 2c a8 46 8b 24
[ 170.062167] RSP: 0018:ffff8881011b7918 EFLAGS: 00000246
[ 170.062171] RAX: 0000000000000000 RBX: ffff888100e2b800 RCX: 0000000000=
0dc000
[ 170.062174] RDX: 0000000000000000 RSI: ffff8881011b7a70 RDI: 0000000000=
000000
[ 170.062177] RBP: 0000000000000000 R08: 0000000000000028 R09: 0000000000=
000001
[ 170.062179] R10: ffff888100ec0f24 R11: 0000000000000007 R12: ffff888101=
1b7a70
[ 170.062182] R13: ffff888100050800 R14: 0000000000000020 R15: 0000000000=
000000
[ 170.062186] ? asm_common_interrupt+0x22/0x40
[ 170.062191] drm_fb_helper_cfb_imageblit+0xd/0x30
[ 170.062198] bit_putcs+0x261/0x500
[ 170.062202] ? preempt_schedule_notrace+0x11/0x80
[ 170.062208] ? asm_common_interrupt+0x22/0x40
[ 170.062212] fbcon_putcs+0xff/0x140
[ 170.062218] ? bit_clear+0xe0/0xe0
[ 170.062221] fbcon_redraw.constprop.0+0xf5/0x220
[ 170.062227] fbcon_scroll+0x167/0x1b0
[ 170.062232] con_scroll+0x14d/0x200
[ 170.062236] lf+0x7f/0x90
[ 170.062239] do_con_trol+0x9b/0x1450
[ 170.062243] ? fbcon_cursor+0xef/0x160
[ 170.062248] do_con_write+0x1b3/0x9e0
[ 170.062252] ? prb_read_valid+0x12/0x20
[ 170.062258] con_write+0xb/0x20
[ 170.062261] do_output_char+0x184/0x1e0
[ 170.062266] n_tty_write+0x1c1/0x4e0
[ 170.062270] ? wait_woken+0x60/0x60
[ 170.062274] file_tty_write.constprop.0+0x15e/0x2e0
[ 170.062278] ? n_tty_check_unthrottle+0xc0/0xc0
[ 170.062282] vfs_write+0x289/0x3b0
[ 170.062289] ksys_write+0x4a/0xc0
[ 170.062294] do_syscall_64+0x35/0x80
[ 170.062297] entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 170.062301] RIP: 0033:0x7f011120d1b0
[ 170.062304] Code: 40 00 48 8b 15 71 2c 0d 00 f7 d8 64 89 02 48 c7 c0 ff=
 ff ff ff eb b7 0f 1f 00
80 3d 31 b4 0d 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58=
 c3 0f 1f 80 00 00 00 00
48 83 ec 28 48 89
[ 170.062307] RSP: 002b:00007ffe3ba2c688 EFLAGS: 00000202 ORIG_RAX: 00000=
00000000001
[ 170.062311] RAX: ffffffffffffffda RBX: 0000000000000441 RCX: 00007f0111=
20d1b0
[ 170.062314] RDX: 0000000000000441 RSI: 00007ffe3ba2c7a0 RDI: 0000000000=
000001
[ 170.062317] RBP: 00007ffe3ba2c7a0 R08: 0000000000000004 R09: 0000000000=
000001
[ 170.062319] R10: 0000555b9b571aa8 R11: 0000000000000202 R12: 0000000000=
000441
[ 170.062321] R13: 00007f01112e1760 R14: 0000000000000441 R15: 00007f0111=
2dca00
[ 170.062325] </TASK>
[ 170.062326] handlers:
[ 170.062328] [<0000000065d27af3>] i965_irq_handler
[ 170.062333] [<00000000377926d6>] yenta_interrupt
[ 170.062339] [<000000005c02c4d7>] usb_hcd_irq
[ 170.062345] [<00000000440e256d>] vt642x_interrupt
[ 170.062351] Disabling IRQ #16
[ 170.064500] debounce, SCR=3D0x1
[ 170.071741] debounce, SCR=3D0x1
...
[ 171.003692] debounce, SCR=3D0x1
[ 171.008787] debounce, SCR=3D0x1
[ 171.008797] resume, return at end of function
[ 171.008803] hardreset, ata_phys_link_offline check failed
[ 171.018773] [2380] libata:ata_wait_idle:2049: ata9: abnormal Status 0x8=
0
[ 171.021255] ata9: SATA link down (SStatus 1 SControl 310)
[ 171.031441] hardreset, Online=3D>Offline
[ 171.032544] resume, do loop
[ 171.258055] resume, after do loop
[ 171.263153] debounce, SCR=3D0x0
[ 171.268253] debounce, SCR=3D0x0
...
[ 171.365137] debounce, SCR=3D0x0
[ 171.370224] debounce, SCR=3D0x0
[ 171.370232] resume, return at end of function
[ 171.370236] hardreset, ata_phys_link_offline check failed
[ 171.380213] [2382] libata:ata_wait_idle:2049: ata10: abnormal Status 0x=
7F
[ 171.382584] ata10: SATA link down (SStatus 0 SControl 310)
[ 171.578086] [2385] libata:ata_wait_idle:2049: ata11: abnormal Status 0x=
8
...

The same hardware setup works fine in Windows XP SP3.

Thanks again for your help.
Marius Dinu

