From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: sata_sx4: DIMM ECC initialization takes 5 min
Date: Sun, 20 Jul 2008 05:25:55 +0400
Message-ID: <48829423.5040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:8344 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbYGTB0A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jul 2008 21:26:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so392550fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 19 Jul 2008 18:25:59 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Jeff

Is it possible to initialize it faster?

[10853.618984] sata_sx4 0000:05:01.0: version 0.12
[10853.618984] ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 19 (level,
low) -> IRQ 19
[10853.618984] pdc20621_dimm_init: Time Period Register (0x40): 0xffffffff
[10857.105665] pdc20621_dimm_init: Time Counter Register (0x44): 0xf58f6257
[10857.105669] pdc20621_dimm_init: Num counters 0xa709da8 (175152552)
[10857.105671] pdc20621_dimm_init: 10 * Internal clk = 0x247 (583)
[10857.105673] pdc20621_dimm_init: 10 * Internal clk * 33 = 0x4b27 (19239)
[10857.105675] pdc20621_dimm_init: PLL F Param: 0x46 (70)
[10857.105677] pdc20621_dimm_init: pci_status: 0x8a461824
[10857.105800] pdc20621_dimm_init: Local DIMM Speed = 100
[10857.106191] pdc20621_dimm_init: Local DIMM Size = 512MB
[10857.106191] Local DIMM ECC Enabled
[10857.207422] 0, 0,
[10857.207435] 55, aa, Promise Not Yet Defined 1.1098
[10857.207455] 55, aa, Promise Not Yet Defined 1.1098
[10857.207576] pdc20621_dimm_init: Start ECC initialization
[10922.102473] BUG: soft lockup - CPU#0 stuck for 61s! [modprobe:2156]
[10922.102473] Modules linked in: sata_sx4(+) ossusb hdaudio envy24ht
osscore fglrx(P) usb_storage intel_agp agpgart [last unloaded: sata_sx4]
[10922.102473]
[10922.102473] Pid: 2156, comm: modprobe Tainted: P          (2.6.26 #3)
[10922.102473] EIP: 0060:[<f9c2d2a6>] EFLAGS: 00000246 CPU: 0
[10922.102473] EIP is at pdc20621_put_to_dimm+0xab/0x14a [sata_sx4]
[10922.102473] EAX: 00000004 EBX: f9d40000 ECX: f9d40484 EDX: 00000000
[10922.102473] ESI: e30dcdac EDI: f9c41a2c EBP: 00000afb ESP: e30dcc64
[10922.102473]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[10922.102473] CR0: 8005003b CR2: 0805bc3c CR3: 1e93a000 CR4: 000006d0
[10922.102473] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[10922.102473] DR6: ffff0ff0 DR7: 00000400
[10922.102473]  [<f9c2e191>] ? pdc20621_dimm_init+0x4b0/0x50d [sata_sx4]
[10922.102473]  [<c0112da4>] ? change_page_attr_set_clr+0x17c/0x186
[10922.102473]  [<c023a3ac>] ? vscnprintf+0xc/0x17
[10922.102473]  [<c023a3ac>] ? vscnprintf+0xc/0x17
[10922.102473]  [<c02a5612>] ? ata_port_desc+0x59/0x65
[10922.102473]  [<f9c2e39a>] ? pdc_sata_init_one+0x1ac/0x234 [sata_sx4]
[10922.102473]  [<c0241465>] ? pci_device_probe+0x36/0x55
[10922.102473]  [<c028136a>] ? driver_probe_device+0x9d/0x12f
[10922.102473]  [<c0281433>] ? __driver_attach+0x37/0x55
[10922.102473]  [<c0280deb>] ? bus_for_each_dev+0x35/0x5c
[10922.102473]  [<c028121d>] ? driver_attach+0x11/0x13
[10922.102473]  [<c02813fc>] ? __driver_attach+0x0/0x55
[10922.102473]  [<c028086e>] ? bus_add_driver+0x91/0x1a7
[10922.102473]  [<c0281599>] ? driver_register+0x7d/0xd6
[10922.102473]  [<c024161d>] ? __pci_register_driver+0x32/0x5d
[10922.102473]  [<c0137c78>] ? sys_init_module+0x175e/0x18f1
[10922.102473]  [<c012a5d6>] ? autoremove_wake_function+0x0/0x2d
[10922.102473]  [<c029c3e2>] ? ata_port_start+0x0/0x29
[10922.102473]  [<c0102aa5>] ? sysenter_past_esp+0x6a/0x91
[10922.102473]  [<c0330000>] ? quirk_disable_msi+0x2e/0x33
[10922.102473]  =======================
<...>
[11235.333118] pdc20621_dimm_init: Finish ECC initialization


        pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
                          PDC_DIMM_SPD_TYPE, &spd0);
        if (spd0 == 0x02) {
                VPRINTK("Start ECC initialization\n");
                addr = 0;
                length = size * 1024 * 1024;
                while (addr < length) {
                        pdc20621_put_to_dimm(host, (void *) &tmp, addr,
                                             sizeof(u32));
                        addr += sizeof(u32);
                }
                VPRINTK("Finish ECC initialization\n");
        }


If I understand correctly FreeBSD does not initialize ECC at all,
but I do not know how this card works there.

        if (ctlr->chip->cfg2 == PRSX4X) {
            struct ata_promise_sx4 *hpkt;
            u_int32_t dimm = ATA_INL(ctlr->r_res2, 0x000c0080);

            if (bus_teardown_intr(dev, ctlr->r_irq, ctlr->handle) ||
                bus_setup_intr(dev, ctlr->r_irq, ATA_INTR_FLAGS, NULL,
                               ata_promise_sx4_intr, ctlr, &ctlr->handle)) {
                device_printf(dev, "unable to setup interrupt\n");
                goto failnfree;
            }

            /* print info about cache memory */
            device_printf(dev, "DIMM size %dMB @ 0x%08x%s\n",
                          (((dimm >> 16) & 0xff)-((dimm >> 24) &
0xff)+1) << 4,
                          ((dimm >> 24) & 0xff),
                          ATA_INL(ctlr->r_res2, 0x000c0088) & (1<<16) ?
                          " ECC enabled" : "" );

            /* adjust cache memory parameters */
            ATA_OUTL(ctlr->r_res2, 0x000c000c,
                     (ATA_INL(ctlr->r_res2, 0x000c000c) & 0xffff0000));

            /* setup host packet controls */
            hpkt = malloc(sizeof(struct ata_promise_sx4),
                          M_TEMP, M_NOWAIT | M_ZERO);
            mtx_init(&hpkt->mtx, "ATA promise HPKT lock", NULL, MTX_DEF);
            TAILQ_INIT(&hpkt->queue);
            hpkt->busy = 0;
            device_set_ivars(dev, hpkt);
            ctlr->allocate = ata_promise_mio_allocate;
            ctlr->reset = ata_promise_mio_reset;
            ctlr->dmainit = ata_promise_mio_dmainit;
            ctlr->setmode = ata_promise_setmode;
            ctlr->channels = 4;
            return 0;
        }
