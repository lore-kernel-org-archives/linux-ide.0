From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Fri, 20 Jan 2017 12:08:10 -0500
Message-ID: <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
References: <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org> <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
 <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
 <20161222163711.GB29161@htj.duckdns.org> <CAP8WD_ay1uKc0JLPr8MWQKT2N=rdqeH+hKkOCVMt76NcmK4hAA@mail.gmail.com>
 <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org> <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com> <20170119213737.GB25133@mtj.duckdns.org>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34577 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdATRIe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 12:08:34 -0500
Received: by mail-yb0-f195.google.com with SMTP id w194so8242794ybe.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 09:08:31 -0800 (PST)
In-Reply-To: <20170119213737.GB25133@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org

Tejun,
  here is the relevant output:

[   39.868755] XXX kobject_get(pata_legacy.0): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   39.875762] XXX kobject_get(pata_legacy.0): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   39.877885] XXX kobject_get(pata_legacy.0): ref=5++
(kobject_add:device_add:ata_tport_add)
[   39.971742] scsi host0: pata_legacy
[   39.999736] ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[   40.157745] ata1.00: ATA-4: QUANTUM FIREBALL CR8.4A, A5U.1200, max UDMA/66
[   40.159149] ata1.00: 16514064 sectors, multi 0: LBA
[   40.160111] ata1.00: configured for PIO
[   40.236700] scsi 0:0:0:0: Direct-Access     ATA      QUANTUM
FIREBALL 1200 PQ: 0 ANSI: 5
[   40.337686] sd 0:0:0:0: [sda] 16514064 512-byte logical blocks:
(8.46 GB/7.87 GiB)
[   40.346688] sd 0:0:0:0: [sda] Write Protect is off
[   40.348681] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   40.365678] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   40.367688] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   40.540654]  sda: sda1 sda2 sda3 sda4
[   40.916596] sd 0:0:0:0: [sda] Attached SCSI disk
[   40.956594] XXX kobject_get(pata_legacy.1): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.968587] XXX kobject_get(pata_legacy.1): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.971139] XXX kobject_get(pata_legacy.1): ref=5++
(kobject_add:device_add:ata_tport_add)
[   41.152561] scsi host1: pata_legacy
[   41.227549] ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
[   41.690486] XXX kobject_put(pata_legacy.1): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   41.692548] XXX kobject_put(pata_legacy.1): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   41.719476] XXX kobject_put(pata_legacy.1): ref=4--
(klist_put:klist_del:device_del)
[   41.725471] XXX kobject_put(pata_legacy.1): ref=3--
(klist_devices_put:klist_put:klist_del)
[   41.745472] XXX kobject_put(pata_legacy.1): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   41.793466] XXX kobject_get(pata_legacy.2): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.807475] XXX kobject_get(pata_legacy.2): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.809848] XXX kobject_get(pata_legacy.2): ref=5++
(kobject_add:device_add:ata_tport_add)
[   41.991431] scsi host2: pata_legacy
[   42.036428] ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
[   42.357388] XXX kobject_put(pata_legacy.2): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   42.359786] XXX kobject_put(pata_legacy.2): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   42.447367] XXX kobject_put(pata_legacy.2): ref=4--
(klist_put:klist_del:device_del)
[   42.470362] XXX kobject_put(pata_legacy.2): ref=3--
(klist_devices_put:klist_put:klist_del)
[   42.510357] XXX kobject_put(pata_legacy.2): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   42.583346] XXX kobject_get(pata_legacy.3): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.592340] XXX kobject_get(pata_legacy.3): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.594415] XXX kobject_get(pata_legacy.3): ref=5++
(kobject_add:device_add:ata_tport_add)
[   42.815304] scsi host3: pata_legacy
[   42.881302] ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
[   43.292234] XXX kobject_put(pata_legacy.3): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   43.294228] XXX kobject_put(pata_legacy.3): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   43.340228] XXX kobject_put(pata_legacy.3): ref=4--
(klist_put:klist_del:device_del)
[   43.370225] XXX kobject_put(pata_legacy.3): ref=3--
(klist_devices_put:klist_put:klist_del)
[   43.411220] XXX kobject_put(pata_legacy.3): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   43.599193] genirq: Flags mismatch irq 8. 00000000
(platform[pata_legacy.4]) vs. 00000080 (rtc0)
[   43.645179] XXX kobject_put(pata_legacy.4): ref=3--
(klist_put:klist_del:device_del)
[   43.685178] XXX kobject_put(pata_legacy.4): ref=2--
(klist_devices_put:klist_put:klist_del)
[   43.733174] XXX kobject_put(pata_legacy.4): ref=1--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   43.736259] XXX kobject_cleanup(pata_legacy.4): rel=device_release
(put_device:platform_device_unregister:legacy_init [pata_legacy])
[   43.738417] platform pata_legacy.4: XXX device_release:
drel=platform_device_release trel=  (null) cdrel=  (null)
[   43.740160] platform pata_legacy.4: XXX device_release:
devres_release_all() done
[   43.950138] XXX kobject_get(pata_legacy.5): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.973137] XXX kobject_get(pata_legacy.5): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.975360] XXX kobject_get(pata_legacy.5): ref=5++
(kobject_add:device_add:ata_tport_add)
[   44.338072] scsi host4: pata_legacy
[   44.389071] ata5: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12
[   44.699020] XXX kobject_put(pata_legacy.5): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   44.701270] XXX kobject_put(pata_legacy.5): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   44.714021] XXX kobject_put(pata_legacy.5): ref=4--
(klist_put:klist_del:device_del)
[   44.731015] XXX kobject_put(pata_legacy.5): ref=3--
(klist_devices_put:klist_put:klist_del)
[   44.750009] XXX kobject_put(pata_legacy.5): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)

...

[  252.348369] genirq: Flags mismatch irq 10. 00000000 (3c515) vs.
00000000 (platform[pata_legacy.3])
[  252.379341] genirq: Flags mismatch irq 10. 00000000 (3c515) vs.
00000000 (platform[pata_legacy.3])

- Matthew
