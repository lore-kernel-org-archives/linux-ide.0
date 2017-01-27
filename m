From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Thu, 26 Jan 2017 22:01:01 -0500
Message-ID: <CAP8WD_b2PXXXQgTQ_-a=8Z7ppNMa5xGuhsEvJGDT_WvT1EFwog@mail.gmail.com>
References: <CAP8WD_agt=peX28+d_oTXhEOd_9ogMScO7h8xd1hTTsHzWz_Vg@mail.gmail.com>
 <20161222192256.GE31216@htj.duckdns.org> <20170103173442.00a514cc@lxorguk.ukuu.org.uk>
 <CAP8WD_bS61spyQkd7cvktFf_dPc0wgNZ8qEa7GVrXgUobHQdvw@mail.gmail.com>
 <20170119213737.GB25133@mtj.duckdns.org> <CAP8WD_Y1HmuMots4HcQ06gQfs0fCh1W_y=Qa0As3MX1YA+LEKg@mail.gmail.com>
 <20170120191946.GA9280@mtj.duckdns.org> <20170120193828.GB9280@mtj.duckdns.org>
 <CAMHSBOVS+ehZkHG7nnUS9qQoDXKmsiBUEhBbPb=3qA2-ZaQ2Ow@mail.gmail.com>
 <CAP8WD_aya3junhovXtc=iUaaX43=Y1s8-eya_LvN_BQjXGLbew@mail.gmail.com> <20170124161937.GE12281@htj.duckdns.org>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33235 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbdA0DB3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2017 22:01:29 -0500
Received: by mail-yw0-f174.google.com with SMTP id u68so7697587ywg.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2017 19:01:23 -0800 (PST)
In-Reply-To: <20170124161937.GE12281@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Gwendal Grignou <gwendal@google.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun and Gwendal,
  here is the patched output:

[   39.991201] pata_legacy: unknown parameter 'ignore_ports' ignored
[   40.046194] XXX kobject_get(pata_legacy.0): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.053193] XXX kobject_get(ata1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tport_add)
[   40.055348] XXX kobject_get(ata1): ref=2++
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.061192] XXX kobject_get(pata_legacy.0): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.062719] XXX kobject_get(pata_legacy.0): ref=5++
(kobject_add:device_add:ata_tport_add)
[   40.072187] XXX kobject_get(ata1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   40.073713] XXX kobject_put(ata1): ref=4--
(ata_tport_add:ata_host_register:ata_host_activate)
[   40.077187] XXX kobject_get(ata1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   40.079618] XXX kobject_get(ata1): ref=4++
(kobject_add:get_device_parent:device_add)
[   40.101187] XXX kobject_get(ata1): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.103143] XXX kobject_get(link1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   40.108187] XXX kobject_get(link1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.109736] XXX kobject_get(ata1): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.111386] XXX kobject_get(ata1): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   40.124186] XXX kobject_get(link1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   40.126633] XXX kobject_put(link1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.132182] XXX kobject_get(link1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   40.134662] XXX kobject_get(link1): ref=4++
(kobject_add:get_device_parent:device_add)
[   40.149183] XXX kobject_get(link1): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.151480] XXX kobject_get(dev1.0): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   40.158178] XXX kobject_get(dev1.0): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.159613] XXX kobject_get(link1): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.161235] XXX kobject_get(link1): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   40.168177] XXX kobject_get(dev1.0): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   40.170398] XXX kobject_put(dev1.0): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.176178] XXX kobject_get(dev1.0): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   40.178417] XXX kobject_get(dev1.0): ref=4++
(kobject_add:get_device_parent:device_add)
[   40.199176] XXX kobject_get(link1): ref=8++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.201542] XXX kobject_get(dev1.1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   40.206171] XXX kobject_get(dev1.1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.212164] XXX kobject_get(link1): ref=9++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.213618] XXX kobject_get(link1): ref=10++
(kobject_add:device_add:ata_tlink_add)
[   40.220168] XXX kobject_get(dev1.1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   40.222323] XXX kobject_put(dev1.1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   40.227163] XXX kobject_get(dev1.1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   40.229391] XXX kobject_get(dev1.1): ref=4++
(kobject_add:get_device_parent:device_add)
[   40.255170] scsi host0: pata_legacy
[   40.257165] XXX kobject_get(ata1): ref=8++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   40.259517] XXX kobject_get(ata1): ref=9++
(kobject_add:device_add:scsi_add_host_with_dma)
[   40.274162] XXX kobject_get(ata1): ref=10++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   40.302150] ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[   40.463135] ata1.00: ATA-4: QUANTUM FIREBALL CR8.4A, A5U.1200, max UDMA/66
[   40.464335] ata1.00: 16514064 sectors, multi 0: LBA
[   40.465312] ata1.00: configured for PIO
[   40.490131] scsi 0:0:0:0: Direct-Access     ATA      QUANTUM
FIREBALL 1200 PQ: 0 ANSI: 5
[   40.573144] sd 0:0:0:0: [sda] 16514064 512-byte logical blocks:
(8.46 GB/7.87 GiB)
[   40.589111] sd 0:0:0:0: [sda] Write Protect is off
[   40.590325] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   40.602112] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   40.607107] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   40.768078]  sda: sda1 sda2 sda3 sda4
[   40.971053] sd 0:0:0:0: [sda] Attached SCSI disk
[   41.049044] XXX kobject_get(pata_legacy.1): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.076039] XXX kobject_get(ata2): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tport_add)
[   41.094037] XXX kobject_get(ata2): ref=2++
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.112037] XXX kobject_get(pata_legacy.1): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.114184] XXX kobject_get(pata_legacy.1): ref=5++
(kobject_add:device_add:ata_tport_add)
[   41.172020] XXX kobject_get(ata2): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   41.174175] XXX kobject_put(ata2): ref=4--
(ata_tport_add:ata_host_register:ata_host_activate)
[   41.198017] XXX kobject_get(ata2): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   41.212022] XXX kobject_get(ata2): ref=4++
(kobject_add:get_device_parent:device_add)
[   41.257012] XXX kobject_get(ata2): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.270036] XXX kobject_get(link2): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   41.284089] XXX kobject_get(link2): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.291005] XXX kobject_get(ata2): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.293024] XXX kobject_get(ata2): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   41.309004] XXX kobject_get(link2): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   41.311453] XXX kobject_put(link2): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.326995] XXX kobject_get(link2): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   41.333998] XXX kobject_get(link2): ref=4++
(kobject_add:get_device_parent:device_add)
[   41.364989] XXX kobject_get(link2): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.370994] XXX kobject_get(dev2.0): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   41.381992] XXX kobject_get(dev2.0): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.383603] XXX kobject_get(link2): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.385239] XXX kobject_get(link2): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   41.402993] XXX kobject_get(dev2.0): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   41.405381] XXX kobject_put(dev2.0): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.416984] XXX kobject_get(dev2.0): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   41.423992] XXX kobject_get(dev2.0): ref=4++
(kobject_add:get_device_parent:device_add)
[   41.454981] XXX kobject_get(link2): ref=8++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.465976] XXX kobject_get(dev2.1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   41.476971] XXX kobject_get(dev2.1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.478472] XXX kobject_get(link2): ref=9++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.480093] XXX kobject_get(link2): ref=10++
(kobject_add:device_add:ata_tlink_add)
[   41.501976] XXX kobject_get(dev2.1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   41.504329] XXX kobject_put(dev2.1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   41.519969] XXX kobject_get(dev2.1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   41.527970] XXX kobject_get(dev2.1): ref=4++
(kobject_add:get_device_parent:device_add)
[   41.569968] scsi host1: pata_legacy
[   41.575957] XXX kobject_get(ata2): ref=8++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   41.577985] XXX kobject_get(ata2): ref=9++
(kobject_add:device_add:scsi_add_host_with_dma)
[   41.611960] XXX kobject_get(ata2): ref=10++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   41.649951] ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
[   41.881913] XXX kobject_put(ata2): ref=11--
(device_del:scsi_remove_host:ata_host_detach)
[   41.883945] XXX kobject_put(ata2): ref=10--
(scsi_remove_host:ata_host_detach:legacy_init [pata_legacy])
[   41.951907] XXX kobject_put(dev2.0): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   41.953908] XXX kobject_put(dev2.0): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   41.971902] XXX kobject_put(dev2.0): ref=3-- (klist_put:klist_del:device_del)
[   41.977899] XXX kobject_put(link2): ref=11--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   41.979885] XXX kobject_put(link2): ref=10--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   41.985899] XXX kobject_put(dev2.0): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   41.987926] XXX kobject_put(dev2.0): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   41.989276] XXX kobject_cleanup(dev2.0): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   41.991118]  dev2.0: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   41.992454]  dev2.0: XXX device_release: devres_release_all() done
[   41.992853] XXX kobject_put(link2): ref=9--
(ata_tdev_release:device_release:kobject_cleanup)
[   42.036899] XXX kobject_put(dev2.1): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   42.038501] XXX kobject_put(dev2.1): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   42.051895] XXX kobject_put(dev2.1): ref=3-- (klist_put:klist_del:device_del)
[   42.057892] XXX kobject_put(link2): ref=8--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   42.060305] XXX kobject_put(link2): ref=7--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   42.069876] XXX kobject_put(dev2.1): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   42.071959] XXX kobject_put(dev2.1): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   42.073338] XXX kobject_cleanup(dev2.1): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   42.075102]  dev2.1: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   42.076439]  dev2.1: XXX device_release: devres_release_all() done
[   42.076841] XXX kobject_put(link2): ref=6--
(ata_tdev_release:device_release:kobject_cleanup)
[   42.125877] XXX kobject_put(link2): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   42.128309] XXX kobject_put(link2): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   42.141876] XXX kobject_put(link2): ref=3-- (klist_put:klist_del:device_del)
[   42.147875] XXX kobject_put(ata2): ref=9--
(device_del:ata_tlink_delete:ata_tport_delete)
[   42.149986] XXX kobject_put(ata2): ref=8--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   42.155874] XXX kobject_put(link2): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   42.158417] XXX kobject_put(link2): ref=1--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   42.160026] XXX kobject_cleanup(link2): rel=device_release
(put_device:ata_tlink_delete:ata_tport_delete)
[   42.161461]  link2: XXX device_release: drel=ata_tlink_release
trel=  (null) cdrel=  (null)
[   42.163103]  link2: XXX device_release: devres_release_all() done
[   42.164063] XXX kobject_put(ata2): ref=7--
(ata_tlink_release:device_release:kobject_cleanup)
[   42.207865] XXX kobject_put(ata2): ref=6--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   42.209822] XXX kobject_put(ata2): ref=5--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   42.216864] XXX kobject_put(ata2): ref=4-- (klist_put:klist_del:device_del)
[   42.218177] XXX kobject_put(pata_legacy.1): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   42.220050] XXX kobject_put(pata_legacy.1): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   42.229860] XXX kobject_put(ata2): ref=3--
(attribute_container_release:device_release:kobject_cleanup)
[   42.231811] XXX kobject_put(ata2): ref=2--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   42.239860] XXX kobject_put(pata_legacy.1): ref=4--
(klist_put:klist_del:device_del)
[   42.248860] XXX kobject_put(pata_legacy.1): ref=3--
(klist_devices_put:klist_put:klist_del)
[   42.269858] XXX kobject_put(pata_legacy.1): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   42.320845] XXX kobject_get(pata_legacy.2): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.328847] XXX kobject_get(ata3): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tport_add)
[   42.341846] XXX kobject_get(ata3): ref=2++
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.349845] XXX kobject_get(pata_legacy.2): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.352101] XXX kobject_get(pata_legacy.2): ref=5++
(kobject_add:device_add:ata_tport_add)
[   42.372838] XXX kobject_get(ata3): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   42.375229] XXX kobject_put(ata3): ref=4--
(ata_tport_add:ata_host_register:ata_host_activate)
[   42.384853] XXX kobject_get(ata3): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   42.397823] XXX kobject_get(ata3): ref=4++
(kobject_add:get_device_parent:device_add)
[   42.438832] XXX kobject_get(ata3): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.444829] XXX kobject_get(link3): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   42.453826] XXX kobject_get(link3): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.463827] XXX kobject_get(ata3): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.466036] XXX kobject_get(ata3): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   42.478824] XXX kobject_get(link3): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   42.481283] XXX kobject_put(link3): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.495823] XXX kobject_get(link3): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   42.503819] XXX kobject_get(link3): ref=4++
(kobject_add:get_device_parent:device_add)
[   42.538815] XXX kobject_get(link3): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.545814] XXX kobject_get(dev3.0): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   42.552812] XXX kobject_get(dev3.0): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.554087] XXX kobject_get(link3): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.555430] XXX kobject_get(link3): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   42.568807] XXX kobject_get(dev3.0): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   42.570302] XXX kobject_put(dev3.0): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.585806] XXX kobject_get(dev3.0): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   42.598800] XXX kobject_get(dev3.0): ref=4++
(kobject_add:get_device_parent:device_add)
[   42.623809] XXX kobject_get(link3): ref=8++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.639876] XXX kobject_get(dev3.1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   42.646794] XXX kobject_get(dev3.1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.648249] XXX kobject_get(link3): ref=9++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.649862] XXX kobject_get(link3): ref=10++
(kobject_add:device_add:ata_tlink_add)
[   42.655797] XXX kobject_get(dev3.1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   42.658043] XXX kobject_put(dev3.1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   42.662792] XXX kobject_get(dev3.1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   42.664844] XXX kobject_get(dev3.1): ref=4++
(kobject_add:get_device_parent:device_add)
[   42.719788] scsi host2: pata_legacy
[   42.721787] XXX kobject_get(ata3): ref=8++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   42.723406] XXX kobject_get(ata3): ref=9++
(kobject_add:device_add:scsi_add_host_with_dma)
[   42.758793] XXX kobject_get(ata3): ref=10++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   42.790775] ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
[   43.045774] XXX kobject_put(ata3): ref=11--
(device_del:scsi_remove_host:ata_host_detach)
[   43.051965] XXX kobject_put(ata3): ref=10--
(scsi_remove_host:ata_host_detach:legacy_init [pata_legacy])
[   43.157723] XXX kobject_put(dev3.0): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   43.160135] XXX kobject_put(dev3.0): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   43.187717] XXX kobject_put(dev3.0): ref=3-- (klist_put:klist_del:device_del)
[   43.192724] XXX kobject_put(link3): ref=11--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   43.195158] XXX kobject_put(link3): ref=10--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   43.202721] XXX kobject_put(dev3.0): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   43.205150] XXX kobject_put(dev3.0): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   43.206846] XXX kobject_cleanup(dev3.0): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   43.208666]  dev3.0: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   43.209974]  dev3.0: XXX device_release: devres_release_all() done
[   43.210942] XXX kobject_put(link3): ref=9--
(ata_tdev_release:device_release:kobject_cleanup)
[   43.246712] XXX kobject_put(dev3.1): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   43.249147] XXX kobject_put(dev3.1): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   43.264709] XXX kobject_put(dev3.1): ref=3-- (klist_put:klist_del:device_del)
[   43.270710] XXX kobject_put(link3): ref=8--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   43.273093] XXX kobject_put(link3): ref=7--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   43.281705] XXX kobject_put(dev3.1): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   43.283940] XXX kobject_put(dev3.1): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   43.285672] XXX kobject_cleanup(dev3.1): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   43.287247]  dev3.1: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   43.288827]  dev3.1: XXX device_release: devres_release_all() done
[   43.289759] XXX kobject_put(link3): ref=6--
(ata_tdev_release:device_release:kobject_cleanup)
[   43.332691] XXX kobject_put(link3): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   43.335064] XXX kobject_put(link3): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   43.354687] XXX kobject_put(link3): ref=3-- (klist_put:klist_del:device_del)
[   43.359694] XXX kobject_put(ata3): ref=9--
(device_del:ata_tlink_delete:ata_tport_delete)
[   43.362203] XXX kobject_put(ata3): ref=8--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   43.417679] XXX kobject_put(link3): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   43.419878] XXX kobject_put(link3): ref=1--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   43.421245] XXX kobject_cleanup(link3): rel=device_release
(put_device:ata_tlink_delete:ata_tport_delete)
[   43.422985]  link3: XXX device_release: drel=ata_tlink_release
trel=  (null) cdrel=  (null)
[   43.424635]  link3: XXX device_release: devres_release_all() done
[   43.424635] XXX kobject_put(ata3): ref=7--
(ata_tlink_release:device_release:kobject_cleanup)
[   43.525666] XXX kobject_put(ata3): ref=6--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   43.527976] XXX kobject_put(ata3): ref=5--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   43.570660] XXX kobject_put(ata3): ref=4-- (klist_put:klist_del:device_del)
[   43.583663] XXX kobject_put(pata_legacy.2): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   43.585654] XXX kobject_put(pata_legacy.2): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   43.611650] XXX kobject_put(ata3): ref=3--
(attribute_container_release:device_release:kobject_cleanup)
[   43.613871] XXX kobject_put(ata3): ref=2--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   43.655645] XXX kobject_put(pata_legacy.2): ref=4--
(klist_put:klist_del:device_del)
[   43.673641] XXX kobject_put(pata_legacy.2): ref=3--
(klist_devices_put:klist_put:klist_del)
[   43.707640] XXX kobject_put(pata_legacy.2): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   43.829624] XXX kobject_get(pata_legacy.3): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.855618] XXX kobject_get(ata4): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tport_add)
[   43.872614] XXX kobject_get(ata4): ref=2++
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.895613] XXX kobject_get(pata_legacy.3): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.897562] XXX kobject_get(pata_legacy.3): ref=5++
(kobject_add:device_add:ata_tport_add)
[   43.946597] XXX kobject_get(ata4): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   43.948847] XXX kobject_put(ata4): ref=4--
(ata_tport_add:ata_host_register:ata_host_activate)
[   43.978592] XXX kobject_get(ata4): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   43.995591] XXX kobject_get(ata4): ref=4++
(kobject_add:get_device_parent:device_add)
[   44.046587] XXX kobject_get(ata4): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.066583] XXX kobject_get(link4): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   44.081582] XXX kobject_get(link4): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.102584] XXX kobject_get(ata4): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.104839] XXX kobject_get(ata4): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   44.141572] XXX kobject_get(link4): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   44.143717] XXX kobject_put(link4): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.147579] XXX kobject_get(link4): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   44.150028] XXX kobject_get(link4): ref=4++
(kobject_add:get_device_parent:device_add)
[   44.174566] XXX kobject_get(link4): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.176960] XXX kobject_get(dev4.0): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   44.209557] XXX kobject_get(dev4.0): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.211137] XXX kobject_get(link4): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.212782] XXX kobject_get(link4): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   44.218586] XXX kobject_get(dev4.0): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   44.220774] XXX kobject_put(dev4.0): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.236560] XXX kobject_get(dev4.0): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   44.238937] XXX kobject_get(dev4.0): ref=4++
(kobject_add:get_device_parent:device_add)
[   44.283558] XXX kobject_get(link4): ref=8++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.340772] XXX kobject_get(dev4.1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   44.356589] XXX kobject_get(dev4.1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.358638] XXX kobject_get(link4): ref=9++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.359978] XXX kobject_get(link4): ref=10++
(kobject_add:device_add:ata_tlink_add)
[   44.378534] XXX kobject_get(dev4.1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   44.380483] XXX kobject_put(dev4.1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   44.383529] XXX kobject_get(dev4.1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   44.406525] XXX kobject_get(dev4.1): ref=4++
(kobject_add:get_device_parent:device_add)
[   44.483528] scsi host3: pata_legacy
[   44.484974] XXX kobject_get(ata4): ref=8++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   44.486951] XXX kobject_get(ata4): ref=9++
(kobject_add:device_add:scsi_add_host_with_dma)
[   44.527514] XXX kobject_get(ata4): ref=10++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   44.597505] ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
[   44.912457] XXX kobject_put(ata4): ref=11--
(device_del:scsi_remove_host:ata_host_detach)
[   44.914077] XXX kobject_put(ata4): ref=10--
(scsi_remove_host:ata_host_detach:legacy_init [pata_legacy])
[   44.938489] XXX kobject_put(dev4.0): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   44.940442] XXX kobject_put(dev4.0): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   44.963444] XXX kobject_put(dev4.0): ref=3-- (klist_put:klist_del:device_del)
[   44.968513] XXX kobject_put(link4): ref=11--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   44.970635] XXX kobject_put(link4): ref=10--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   44.977447] XXX kobject_put(dev4.0): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   44.979429] XXX kobject_put(dev4.0): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   44.980910] XXX kobject_cleanup(dev4.0): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   44.982694]  dev4.0: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   44.987578]  dev4.0: XXX device_release: devres_release_all() done
[   44.988509] XXX kobject_put(link4): ref=9--
(ata_tdev_release:device_release:kobject_cleanup)
[   45.014436] XXX kobject_put(dev4.1): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   45.017387] XXX kobject_put(dev4.1): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   45.041431] XXX kobject_put(dev4.1): ref=3-- (klist_put:klist_del:device_del)
[   45.043705] XXX kobject_put(link4): ref=8--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   45.048956] XXX kobject_put(link4): ref=7--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   45.068485] XXX kobject_put(dev4.1): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   45.070377] XXX kobject_put(dev4.1): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   45.071744] XXX kobject_cleanup(dev4.1): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   45.073554]  dev4.1: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   45.074878]  dev4.1: XXX device_release: devres_release_all() done
[   45.075833] XXX kobject_put(link4): ref=6--
(ata_tdev_release:device_release:kobject_cleanup)
[   45.109427] XXX kobject_put(link4): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   45.115436] XXX kobject_put(link4): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   45.127424] XXX kobject_put(link4): ref=3-- (klist_put:klist_del:device_del)
[   45.129606] XXX kobject_put(ata4): ref=9--
(device_del:ata_tlink_delete:ata_tport_delete)
[   45.131711] XXX kobject_put(ata4): ref=8--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   45.133372] XXX kobject_put(link4): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   45.134769] XXX kobject_put(link4): ref=1--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   45.139565] XXX kobject_cleanup(link4): rel=device_release
(put_device:ata_tlink_delete:ata_tport_delete)
[   45.141395]  link4: XXX device_release: drel=ata_tlink_release
trel=  (null) cdrel=  (null)
[   45.142703]  link4: XXX device_release: devres_release_all() done
[   45.143646] XXX kobject_put(ata4): ref=7--
(ata_tlink_release:device_release:kobject_cleanup)
[   45.183419] XXX kobject_put(ata4): ref=6--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   45.185423] XXX kobject_put(ata4): ref=5--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   45.191409] XXX kobject_put(ata4): ref=4-- (klist_put:klist_del:device_del)
[   45.194413] XXX kobject_put(pata_legacy.3): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   45.195905] XXX kobject_put(pata_legacy.3): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   45.197763] XXX kobject_put(ata4): ref=3--
(attribute_container_release:device_release:kobject_cleanup)
[   45.199619] XXX kobject_put(ata4): ref=2--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   45.201386] XXX kobject_put(pata_legacy.3): ref=4--
(klist_put:klist_del:device_del)
[   45.203674] XXX kobject_put(pata_legacy.3): ref=3--
(klist_devices_put:klist_put:klist_del)
[   45.229401] XXX kobject_put(pata_legacy.3): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   45.293400] genirq: Flags mismatch irq 8. 00000000
(platform[pata_legacy.4]) vs. 00000080 (rtc0)
[   45.339394] XXX kobject_put(pata_legacy.4): ref=3--
(klist_put:klist_del:device_del)
[   45.358483] XXX kobject_put(pata_legacy.4): ref=2--
(klist_devices_put:klist_put:klist_del)
[   45.399372] XXX kobject_put(pata_legacy.4): ref=1--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
[   45.401859] XXX kobject_cleanup(pata_legacy.4): rel=device_release
(put_device:platform_device_unregister:legacy_init [pata_legacy])
[   45.403918] platform pata_legacy.4: XXX device_release:
drel=platform_device_release trel=  (null) cdrel=  (null)
[   45.405670] platform pata_legacy.4: XXX device_release:
devres_release_all() done
[   45.601350] XXX kobject_get(pata_legacy.5): ref=3++
(ata_tport_add:ata_host_register:ata_host_activate)
[   45.632345] XXX kobject_get(ata5): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tport_add)
[   45.661340] XXX kobject_get(ata5): ref=2++
(ata_tport_add:ata_host_register:ata_host_activate)
[   45.682333] XXX kobject_get(pata_legacy.5): ref=4++
(ata_tport_add:ata_host_register:ata_host_activate)
[   45.684390] XXX kobject_get(pata_legacy.5): ref=5++
(kobject_add:device_add:ata_tport_add)
[   45.756331] XXX kobject_get(ata5): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   45.758629] XXX kobject_put(ata5): ref=4--
(ata_tport_add:ata_host_register:ata_host_activate)
[   45.795316] XXX kobject_get(ata5): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   45.826312] XXX kobject_get(ata5): ref=4++
(kobject_add:get_device_parent:device_add)
[   45.910302] XXX kobject_get(ata5): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   45.930298] XXX kobject_get(link5): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   45.952295] XXX kobject_get(link5): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   45.972294] XXX kobject_get(ata5): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   45.974244] XXX kobject_get(ata5): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   46.040282] XXX kobject_get(link5): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   46.042361] XXX kobject_put(link5): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.086272] XXX kobject_get(link5): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   46.111266] XXX kobject_get(link5): ref=4++
(kobject_add:get_device_parent:device_add)
[   46.209257] XXX kobject_get(link5): ref=5++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.231257] XXX kobject_get(dev5.0): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   46.247255] XXX kobject_get(dev5.0): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.267250] XXX kobject_get(link5): ref=6++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.268783] XXX kobject_get(link5): ref=7++
(kobject_add:device_add:ata_tlink_add)
[   46.325247] XXX kobject_get(dev5.0): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   46.327468] XXX kobject_put(dev5.0): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.349234] XXX kobject_get(dev5.0): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   46.364234] XXX kobject_get(dev5.0): ref=4++
(kobject_add:get_device_parent:device_add)
[   46.414223] XXX kobject_get(link5): ref=8++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.422225] XXX kobject_get(dev5.1): ref=1++
(attribute_container_add_device:transport_setup_device:ata_tlink_add)
[   46.435220] XXX kobject_get(dev5.1): ref=2++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.447215] XXX kobject_get(link5): ref=9++
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.448509] XXX kobject_get(link5): ref=10++
(kobject_add:device_add:ata_tlink_add)
[   46.463231] XXX kobject_get(dev5.1): ref=3++
(klist_node_init:klist_add_tail:device_add)
[   46.465362] XXX kobject_put(dev5.1): ref=4--
(ata_tlink_add:ata_tport_add:ata_host_register)
[   46.481216] XXX kobject_get(dev5.1): ref=3++
(attribute_container_add_class_device:transport_add_class_device:attribute_container_device_trigger)
[   46.494212] XXX kobject_get(dev5.1): ref=4++
(kobject_add:get_device_parent:device_add)
[   46.566197] scsi host4: pata_legacy
[   46.568205] XXX kobject_get(ata5): ref=8++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   46.569732] XXX kobject_get(ata5): ref=9++
(kobject_add:device_add:scsi_add_host_with_dma)
[   46.614194] XXX kobject_get(ata5): ref=10++
(scsi_add_host_with_dma:ata_scsi_add_hosts:ata_host_register)
[   46.649192] ata5: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12
[   46.875155] XXX kobject_put(ata5): ref=11--
(device_del:scsi_remove_host:ata_host_detach)
[   46.877102] XXX kobject_put(ata5): ref=10--
(scsi_remove_host:ata_host_detach:legacy_init [pata_legacy])
[   46.919145] XXX kobject_put(dev5.0): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   46.921532] XXX kobject_put(dev5.0): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   46.931148] XXX kobject_put(dev5.0): ref=3-- (klist_put:klist_del:device_del)
[   46.934151] XXX kobject_put(link5): ref=11--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   46.935685] XXX kobject_put(link5): ref=10--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   46.937315] XXX kobject_put(dev5.0): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   46.939100] XXX kobject_put(dev5.0): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   46.940475] XXX kobject_cleanup(dev5.0): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   46.942299]  dev5.0: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   46.943635]  dev5.0: XXX device_release: devres_release_all() done
[   46.944590] XXX kobject_put(link5): ref=9--
(ata_tdev_release:device_release:kobject_cleanup)
[   46.959138] XXX kobject_put(dev5.1): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   46.961728] XXX kobject_put(dev5.1): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   46.971142] XXX kobject_put(dev5.1): ref=3-- (klist_put:klist_del:device_del)
[   46.973304] XXX kobject_put(link5): ref=8--
(device_del:ata_tdev_delete:ata_tlink_delete)
[   46.975117] XXX kobject_put(link5): ref=7--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   46.976474] XXX kobject_put(dev5.1): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   46.978331] XXX kobject_put(dev5.1): ref=1--
(ata_tdev_delete:ata_tlink_delete:ata_tport_delete)
[   46.979686] XXX kobject_cleanup(dev5.1): rel=device_release
(put_device:ata_tdev_delete:ata_tlink_delete)
[   46.981483]  dev5.1: XXX device_release: drel=ata_tdev_release
trel=  (null) cdrel=  (null)
[   46.983086]  dev5.1: XXX device_release: devres_release_all() done
[   46.983086] XXX kobject_put(link5): ref=6--
(ata_tdev_release:device_release:kobject_cleanup)
[   47.000131] XXX kobject_put(link5): ref=5--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   47.002478] XXX kobject_put(link5): ref=4--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   47.012135] XXX kobject_put(link5): ref=3-- (klist_put:klist_del:device_del)
[   47.013550] XXX kobject_put(ata5): ref=9--
(device_del:ata_tlink_delete:ata_tport_delete)
[   47.015311] XXX kobject_put(ata5): ref=8--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   47.016612] XXX kobject_put(link5): ref=2--
(attribute_container_release:device_release:kobject_cleanup)
[   47.018423] XXX kobject_put(link5): ref=1--
(ata_tlink_delete:ata_tport_delete:ata_host_detach)
[   47.019754] XXX kobject_cleanup(link5): rel=device_release
(put_device:ata_tlink_delete:ata_tport_delete)
[   47.021482]  link5: XXX device_release: drel=ata_tlink_release
trel=  (null) cdrel=  (null)
[   47.023082]  link5: XXX device_release: devres_release_all() done
[   47.023082] XXX kobject_put(ata5): ref=7--
(ata_tlink_release:device_release:kobject_cleanup)
[   47.041124] XXX kobject_put(ata5): ref=6--
(kobject_cleanup:kobject_put:cleanup_glue_dir)
[   47.043468] XXX kobject_put(ata5): ref=5--
(attribute_container_class_device_del:transport_remove_classdev:attribute_container_device_trigger)
[   47.049130] XXX kobject_put(ata5): ref=4-- (klist_put:klist_del:device_del)
[   47.051263] XXX kobject_put(pata_legacy.5): ref=6--
(device_del:ata_tport_delete:ata_host_detach)
[   47.053076] XXX kobject_put(pata_legacy.5): ref=5--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   47.054603] XXX kobject_put(ata5): ref=3--
(attribute_container_release:device_release:kobject_cleanup)
[   47.056389] XXX kobject_put(ata5): ref=2--
(ata_tport_delete:ata_host_detach:legacy_init [pata_legacy])
[   47.059123] XXX kobject_put(pata_legacy.5): ref=4--
(klist_put:klist_del:device_del)
[   47.061079] XXX kobject_put(pata_legacy.5): ref=3--
(klist_devices_put:klist_put:klist_del)
[   47.073144] XXX kobject_put(pata_legacy.5): ref=2--
(platform_device_unregister:legacy_init [pata_legacy]:do_one_initcall)
