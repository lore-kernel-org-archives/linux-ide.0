From: tedheadster <tedheadster@gmail.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Mon, 19 Dec 2016 21:12:49 -0500
Message-ID: <CAP8WD_ZoJgrdsDZNR4uN8HWESO5MyuNc1xN_F2an8GfP8nKcLA@mail.gmail.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
 <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com> <20161130145322.252f7403@lxorguk.ukuu.org.uk>
 <CAP8WD_boGwPZCEPE8hA-AhQnHChrbaM+74LTUy-9__s6ex56Sg@mail.gmail.com>
 <20161130202201.GA15989@htj.duckdns.org> <CAP8WD_bZWeLBhLXqJG5uDwBe+zBubw+A+ecSuaihOuwvw9QoCQ@mail.gmail.com>
 <20161202170705.GB6033@htj.duckdns.org> <CAP8WD_bUW9cAAQpvenL73sxvpoxNYwZdRqpj92YWEyanK51+0g@mail.gmail.com>
 <20161205192310.GA30331@mtj.duckdns.org> <CAP8WD_becq+h2=-g7t-6Pp1psmkCCvdB0YUcg+wYPocUP4dYdw@mail.gmail.com>
 <20161212170154.GA13864@htj.duckdns.org> <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
Reply-To: whiteheadm@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34171 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbcLTCNL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2016 21:13:11 -0500
Received: by mail-yw0-f196.google.com with SMTP id a10so9815519ywa.1
        for <linux-ide@vger.kernel.org>; Mon, 19 Dec 2016 18:13:11 -0800 (PST)
In-Reply-To: <CAP8WD_YMtnsuYmJHGz1eLmrQNemsB1Z6Soyb6f72brAfMNUNeg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org
Cc: Matthew Whitehead <whiteheadm@acm.org>

Tejun,
  apologies this took a while. Here is the patch I _think_ you were
asking me to test:

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8c..bfa63d1 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -1008,12 +1008,15 @@ static __init int legacy_init_one(struct
legacy_probe *probe)
        if (!ata_dev_absent(dev)) {
            legacy_host[probe->slot] = host;
            ld->platform_dev = pdev;
+                       devres_remove_group(&pdev->dev, legacy_init_one);
            return 0;
        }
    }
        ata_host_detach(host);
 fail:
          platform_device_unregister(pdev);
+       devres_release_group(&pdev->dev, legacy_init_one);
+       printk("XXX pata_legacy: unregistering platform dev %p\n", pdev);
    return ret;
 }

The /proc/interrupts entry is still bad:

           CPU0
  0:      95630    XT-PIC  timer
  1:       1028    XT-PIC  i8042
  2:          0    XT-PIC  cascade
  5:          0    XT-PIC  pnp0-3c509-0
  6:          3    XT-PIC  floppy
  7:          0    XT-PIC  eisa0-3c59x-0
  8:          0    XT-PIC  rtc0
  9:          7    XT-PIC  aha1542
 10:          0    XT-PIC  platform[pata_legacy.3]
 11:          0    XT-PIC  platform[pata_legacy.2]
 12:          0    XT-PIC  platform[pata_legacy.5]
 14:      66786    XT-PIC  platform[pata_legacy.0]
 15:          0    XT-PIC  platform[pata_legacy.1]

and we have several backtraces :

[   20.757765] SCSI subsystem initialized
[   21.025769] libata version 3.00 loaded.
[   21.925805] Floppy drive(s): fd0 is 1.44M
[   21.950114] FDC 0 is a post-1991 82077
[   23.625932] scsi host0: pata_legacy
[   23.645903] ata1: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[   23.815254] ata1.00: ATA-4: QUANTUM FIREBALL CR8.4A, A5U.1200, max UDMA/66
[   23.815254] ata1.00: 16514064 sectors, multi 0: LBA
[   23.815254] ata1.00: configured for PIO
[   23.822027] scsi 0:0:0:0: Direct-Access     ATA      QUANTUM
FIREBALL 1200 PQ: 0 ANSI: 5
[   23.877945] sd 0:0:0:0: [sda] 16514064 512-byte logical blocks:
(8.46 GB/7.87 GiB)
[   23.885910] sd 0:0:0:0: [sda] Write Protect is off
[   23.885910] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   23.885910] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   24.009948]  sda: sda1 sda2 sda3 sda4
[   24.117952] sd 0:0:0:0: [sda] Attached SCSI disk
[   24.117952] ------------[ cut here ]------------
[   24.117952] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:629
devres_remove_group+0xaf/0xc0
[   24.117952] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   24.117952] CPU: 0 PID: 131 Comm: modprobe Not tainted 4.9.0-rc6-tejun4+ #15
[   24.117952]  c2afbc48 c101c9f8 c15c0f5a 00000000 c2afbc50 c123e756
c2afbc84 c1048326
[   24.117952]  c15a3c80 00000000 00000083 c15dc5e0 00000275 c134088f
c134088f 00000275
[   24.117952]  c2aa5d48 c4a07f20 c2afbcb8 c2afbc98 c104836a 00000009
00000000 00000000
[   24.117952] Call Trace:
[   24.117952]  [<c101c9f8>] show_stack+0x28/0x50
[   24.117952]  [<c123e756>] dump_stack+0x16/0x20
[   24.117952]  [<c1048326>] __warn+0xe6/0x100
[   24.117952]  [<c134088f>] ? devres_remove_group+0xaf/0xc0
[   24.117952]  [<c134088f>] ? devres_remove_group+0xaf/0xc0
[   24.117952]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   24.117952]  [<c134088f>] devres_remove_group+0xaf/0xc0
[   24.117952]  [<c49322ec>] legacy_init_one+0x2ec/0x2ee [pata_legacy]
[   24.117952]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   24.117952]  [<c1000410>] do_one_initcall+0x40/0x140
[   24.117952]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   24.117952]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   24.117952]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   24.117952]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   24.117952]  [<c10a61d7>] do_init_module+0x57/0x200
[   24.117952]  [<c10a90f5>] load_module+0x1085/0x12b0
[   24.117952]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   24.117952]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   24.117952]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   24.117952]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   24.117952]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   24.117952] ---[ end trace 5aa726e4811c5039 ]---
[   24.213926] scsi host1: pata_legacy
[   24.237957] ata2: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
[   24.449955] ------------[ cut here ]------------
[   24.449955] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:667
devres_release_group+0x97/0xa0
[   24.449955] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   24.449955] CPU: 0 PID: 131 Comm: modprobe Tainted: G        W
 4.9.0-rc6-tejun4+ #15
[   24.449955]  c2afbc50 c101c9f8 c15c0f5a 00000000 c2afbc58 c123e756
c2afbc8c c1048326
[   24.449955]  c15a3c80 00000000 00000083 c15dc5e0 0000029b c13407d7
c13407d7 0000029b
[   24.449955]  c4932000 c4a07f38 c2afbcb8 c2afbca0 c104836a 00000009
00000000 00000000
[   24.449955] Call Trace:
[   24.449955]  [<c101c9f8>] show_stack+0x28/0x50
[   24.449955]  [<c123e756>] dump_stack+0x16/0x20
[   24.449955]  [<c1048326>] __warn+0xe6/0x100
[   24.449955]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   24.449955]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   24.449955]  [<c4932000>] ? 0xc4932000
[   24.449955]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   24.449955]  [<c13407d7>] devres_release_group+0x97/0xa0
[   24.449955]  [<c133f0c4>] ? platform_device_put+0x14/0x20
[   24.449955]  [<c49322aa>] legacy_init_one+0x2aa/0x2ee [pata_legacy]
[   24.449955]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   24.449955]  [<c1000410>] do_one_initcall+0x40/0x140
[   24.449955]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   24.449955]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   24.449955]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   24.449955]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   24.449955]  [<c10a61d7>] do_init_module+0x57/0x200
[   24.449955]  [<c10a90f5>] load_module+0x1085/0x12b0
[   24.449955]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   24.449955]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   24.449955]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   24.449955]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   24.449955]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   24.449955] ---[ end trace 5aa726e4811c503a ]---
[   24.455942] XXX pata_legacy: unregistering platform dev c2aeea00
[   24.553972] scsi host2: pata_legacy
[   24.577962] ata3: PATA max PIO4 cmd 0x1e8 ctl 0x3ee irq 11
[   24.790171] ------------[ cut here ]------------
[   24.790171] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:667
devres_release_group+0x97/0xa0
[   24.790171] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   24.790171] CPU: 0 PID: 131 Comm: modprobe Tainted: G        W
 4.9.0-rc6-tejun4+ #15
[   24.790171]  c2afbc50 c101c9f8 c15c0f5a 00000000 c2afbc58 c123e756
c2afbc8c c1048326
[   24.790171]  c15a3c80 00000000 00000083 c15dc5e0 0000029b c13407d7
c13407d7 0000029b
[   24.790171]  c4932000 c4a07f50 c2afbcb8 c2afbca0 c104836a 00000009
00000000 00000000
[   24.790171] Call Trace:
[   24.790171]  [<c101c9f8>] show_stack+0x28/0x50
[   24.790171]  [<c123e756>] dump_stack+0x16/0x20
[   24.790171]  [<c1048326>] __warn+0xe6/0x100
[   24.790171]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   24.790171]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   24.790171]  [<c4932000>] ? 0xc4932000
[   24.790171]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   24.790171]  [<c13407d7>] devres_release_group+0x97/0xa0
[   24.790171]  [<c133f0c4>] ? platform_device_put+0x14/0x20
[   24.790171]  [<c49322aa>] legacy_init_one+0x2aa/0x2ee [pata_legacy]
[   24.790171]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   24.790171]  [<c1000410>] do_one_initcall+0x40/0x140
[   24.790171]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   24.790171]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   24.790171]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   24.790171]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   24.790171]  [<c10a61d7>] do_init_module+0x57/0x200
[   24.790171]  [<c10a90f5>] load_module+0x1085/0x12b0
[   24.790171]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   24.790171]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   24.790171]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   24.790171]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   24.790171]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   24.790171] ---[ end trace 5aa726e4811c503b ]---
[   24.794770] XXX pata_legacy: unregistering platform dev c2623c00
[   24.881963] scsi host3: pata_legacy
[   24.905987] ata4: PATA max PIO4 cmd 0x168 ctl 0x36e irq 10
[   25.122003] ------------[ cut here ]------------
[   25.122003] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:667
devres_release_group+0x97/0xa0
[   25.122003] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   25.122003] CPU: 0 PID: 131 Comm: modprobe Tainted: G        W
 4.9.0-rc6-tejun4+ #15
[   25.122003]  c2afbc50 c101c9f8 c15c0f5a 00000000 c2afbc58 c123e756
c2afbc8c c1048326
[   25.122003]  c15a3c80 00000000 00000083 c15dc5e0 0000029b c13407d7
c13407d7 0000029b
[   25.122003]  c4932000 c4a07f68 c2afbcb8 c2afbca0 c104836a 00000009
00000000 00000000
[   25.122003] Call Trace:
[   25.122003]  [<c101c9f8>] show_stack+0x28/0x50
[   25.122003]  [<c123e756>] dump_stack+0x16/0x20
[   25.122003]  [<c1048326>] __warn+0xe6/0x100
[   25.122003]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.122003]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.122003]  [<c4932000>] ? 0xc4932000
[   25.122003]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   25.122003]  [<c13407d7>] devres_release_group+0x97/0xa0
[   25.122003]  [<c133f0c4>] ? platform_device_put+0x14/0x20
[   25.122003]  [<c49322aa>] legacy_init_one+0x2aa/0x2ee [pata_legacy]
[   25.122003]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   25.122003]  [<c1000410>] do_one_initcall+0x40/0x140
[   25.122003]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   25.122003]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   25.122003]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   25.122003]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   25.122003]  [<c10a61d7>] do_init_module+0x57/0x200
[   25.122003]  [<c10a90f5>] load_module+0x1085/0x12b0
[   25.122003]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   25.122003]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   25.122003]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   25.122003]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   25.122003]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   25.122003] ---[ end trace 5aa726e4811c503c ]---
[   25.126150] XXX pata_legacy: unregistering platform dev c2623e00
[   25.138001] genirq: Flags mismatch irq 8. 00000000
(platform[pata_legacy.4]) vs. 00000080 (rtc0)
[   25.146001] ------------[ cut here ]------------
[   25.146001] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:667
devres_release_group+0x97/0xa0
[   25.146001] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   25.146001] CPU: 0 PID: 131 Comm: modprobe Tainted: G        W
 4.9.0-rc6-tejun4+ #15
[   25.146001]  c2afbc50 c101c9f8 c15c0f5a 00000000 c2afbc58 c123e756
c2afbc8c c1048326
[   25.146001]  c15a3c80 00000000 00000083 c15dc5e0 0000029b c13407d7
c13407d7 0000029b
[   25.146001]  c4932000 c4a07f80 c4a08010 c2afbca0 c104836a 00000009
00000000 00000000
[   25.146001] Call Trace:
[   25.146001]  [<c101c9f8>] show_stack+0x28/0x50
[   25.146001]  [<c123e756>] dump_stack+0x16/0x20
[   25.146001]  [<c1048326>] __warn+0xe6/0x100
[   25.146001]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.146001]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.146001]  [<c4932000>] ? 0xc4932000
[   25.146001]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   25.146001]  [<c13407d7>] devres_release_group+0x97/0xa0
[   25.146001]  [<c133f0c4>] ? platform_device_put+0x14/0x20
[   25.146001]  [<c49322aa>] legacy_init_one+0x2aa/0x2ee [pata_legacy]
[   25.146001]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   25.146001]  [<c1000410>] do_one_initcall+0x40/0x140
[   25.146001]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   25.146001]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   25.146001]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   25.146001]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   25.146001]  [<c10a61d7>] do_init_module+0x57/0x200
[   25.146001]  [<c10a90f5>] load_module+0x1085/0x12b0
[   25.146001]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   25.146001]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   25.146001]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   25.146001]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   25.146001]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   25.146001] ---[ end trace 5aa726e4811c503d ]---
[   25.151917] XXX pata_legacy: unregistering platform dev c2aee400
[   25.237998] scsi host4: pata_legacy
[   25.265989] ata5: PATA max PIO4 cmd 0x160 ctl 0x366 irq 12
[   25.478021] ------------[ cut here ]------------
[   25.478021] WARNING: CPU: 0 PID: 131 at drivers/base/devres.c:667
devres_release_group+0x97/0xa0
[   25.478021] Modules linked in: pata_legacy(+) sd_mod ext4 jbd2
crc16 ext2 mbcache floppy vfat msdos fat nls_cp437 ata_piix libata
scsi_mod uhci_hcd usbcore usb_common virtio_blk virtio_ring virtio
3c515 3c59x 3c509 mii
[   25.478021] CPU: 0 PID: 131 Comm: modprobe Tainted: G        W
 4.9.0-rc6-tejun4+ #15
[   25.478021]  c2afbc50 c101c9f8 c15c0f5a 00000000 c2afbc58 c123e756
c2afbc8c c1048326
[   25.478021]  c15a3c80 00000000 00000083 c15dc5e0 0000029b c13407d7
c13407d7 0000029b
[   25.478021]  c4932000 c4a07f98 c2afbcb8 c2afbca0 c104836a 00000009
00000000 00000000
[   25.478021] Call Trace:
[   25.478021]  [<c101c9f8>] show_stack+0x28/0x50
[   25.478021]  [<c123e756>] dump_stack+0x16/0x20
[   25.478021]  [<c1048326>] __warn+0xe6/0x100
[   25.478021]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.478021]  [<c13407d7>] ? devres_release_group+0x97/0xa0
[   25.478021]  [<c4932000>] ? 0xc4932000
[   25.478021]  [<c104836a>] warn_slowpath_null+0x2a/0x30
[   25.478021]  [<c13407d7>] devres_release_group+0x97/0xa0
[   25.478021]  [<c133f0c4>] ? platform_device_put+0x14/0x20
[   25.478021]  [<c49322aa>] legacy_init_one+0x2aa/0x2ee [pata_legacy]
[   25.478021]  [<c493291c>] legacy_init+0x62e/0xd12 [pata_legacy]
[   25.478021]  [<c1000410>] do_one_initcall+0x40/0x140
[   25.478021]  [<c49322ee>] ? legacy_init_one+0x2ee/0x2ee [pata_legacy]
[   25.478021]  [<c14c7e24>] ? preempt_schedule_common+0x14/0x20
[   25.478021]  [<c14c7e9a>] ? _cond_resched+0x1a/0x30
[   25.478021]  [<c10a61a9>] ? do_init_module+0x29/0x200
[   25.478021]  [<c10a61d7>] do_init_module+0x57/0x200
[   25.478021]  [<c10a90f5>] load_module+0x1085/0x12b0
[   25.478021]  [<c10a58e0>] ? do_free_init+0x20/0x20
[   25.478021]  [<c10a9491>] ? SyS_init_module+0x91/0x130
[   25.478021]  [<c10a94ef>] SyS_init_module+0xef/0x130
[   25.478021]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[   25.478021]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[   25.478021] ---[ end trace 5aa726e4811c503e ]---
[   25.482482] XXX pata_legacy: unregistering platform dev c2aee600
[   26.990075] scsi host5: Adaptec AHA-1542 (SCSI-ID 7) at IO 0x330,
IRQ 9, DMA 5
[   27.014108] scsi host5: Adaptec 1542
[   27.062096] bounce: isa pool size: 16 pages
[   27.846164] random: crng init done
[   30.086292] device-mapper: uevent: version 1.0.3
[   30.094299] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
initialised: dm-devel@redhat.com
[   30.618797] EXT4-fs (sda4): mounting ext3 file system using the
ext4 subsystem
[   30.762317] EXT4-fs (sda4): mounted filesystem with ordered data
mode. Opts: (null)
[   40.082846] udev[255]: starting version 164
[   42.478972] 3c509 3c509.0 isa0-3c509-0: renamed from eth3
[   44.055092] 3c509 00:02.00 pnp0-3c509-0: renamed from eth0
[   44.751104] 3c579 00:06 eisa0-3c509-0: renamed from eth4
[   44.823115] 3c579 00:07 eisa0-3c509-1: renamed from eth5
[   45.351161] 3c59x 00:08 eisa0-3c59x-0: renamed from eth2
[   47.343318] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   56.759801] Error: Driver 'pcspkr' is already registered, aborting...
[   78.345031] Adding 124924k swap on /dev/sda2.  Priority:-1
extents:1 across:124924k
[   78.841040] EXT4-fs (sda4): re-mounted. Opts: (null)
[   81.189191] EXT4-fs (sda4): re-mounted. Opts: errors=remount-ro
[   89.245655] loop: module loaded
[  110.430862] eisa0-3c59x-0: first available media type: 100baseTX
[  110.430862] eisa0-3c59x-0:  setting half-duplex.
[  115.299125] pnp0-3c509-0: Setting 3c5x9/3c5x9B half-duplex mode
if_port: 0, sw_info: 3f31
[  116.283187] genirq: Flags mismatch irq 10. 00000000 (3c515) vs.
00000000 (platform[pata_legacy.3])
[  116.287197] ------------[ cut here ]------------
[  116.287197] WARNING: CPU: 0 PID: 1089 at lib/debugobjects.c:263
debug_print_object+0x85/0xa0
[  116.287197] ODEBUG: init active (active state 0) object type:
timer_list hint: corkscrew_timer+0x0/0x3b0 [3c515]
[  116.287197] Modules linked in: loop snd_pcm snd_timer snd
tpm_tis_core soundcore tpm evdev pcspkr dm_mod aha1542 sr_mod cdrom
isofs pata_legacy sd_mod ext4 jbd2 crc16 ext2 mbcache floppy vfat
msdos fat nls_cp437 ata_piix libata scsi_mod uhci_hcd usbcore
usb_common virtio_blk virtio_ring virtio 3c515 3c59x 3c509 mii
[  116.287197] CPU: 0 PID: 1089 Comm: ifconfig Tainted: G        W
  4.9.0-rc6-tejun4+ #15
[  116.287197]  c2707c74 c101c9f8 c15c0f5a 00000000 c2707c7c c123e756
c2707cb0 c1048326
[  116.287197]  c15cd08c c2707ce0 00000441 c15cdd5b 00000107 c125b6c5
c125b6c5 00000107
[  116.287197]  c2a0e780 c1664040 c15bb707 c2707ccc c10483eb 00000009
00000000 c2707cc4
[  116.287197] Call Trace:
[  116.287197]  [<c101c9f8>] show_stack+0x28/0x50
[  116.287197]  [<c123e756>] dump_stack+0x16/0x20
[  116.287197]  [<c1048326>] __warn+0xe6/0x100
[  116.287197]  [<c125b6c5>] ? debug_print_object+0x85/0xa0
[  116.287197]  [<c125b6c5>] ? debug_print_object+0x85/0xa0
[  116.287197]  [<c10483eb>] warn_slowpath_fmt+0x3b/0x40
[  116.287197]  [<c125b6c5>] debug_print_object+0x85/0xa0
[  116.287197]  [<c4963470>] ? init_module+0x320/0x320 [3c515]
[  116.287197]  [<c125be24>] __debug_object_init+0x1d4/0x330
[  116.287197]  [<c1377572>] ? cnic_netdev_event+0x312/0x390
[  116.287197]  [<c1042a85>] ? kmap_atomic_prot+0x35/0xc0
[  116.287197]  [<c125bfb7>] debug_object_init+0x17/0x20
[  116.287197]  [<c108ceac>] init_timer_key+0x1c/0x90
[  116.287197]  [<c49624ac>] corkscrew_open+0x4bc/0x6a0 [3c515]
[  116.287197]  [<c13d29c3>] ? call_netdevice_notifiers_info+0x33/0x70
[  116.287197]  [<c13d3df3>] __dev_open+0xc3/0x140
[  116.287197]  [<c104bb45>] ? __local_bh_enable_ip+0x75/0x80
[  116.287197]  [<c13d3bac>] __dev_change_flags+0x8c/0x150
[  116.287197]  [<c11c9713>] ? security_capable+0x43/0x50
[  116.287197]  [<c13d3c9e>] dev_change_flags+0x2e/0x70
[  116.287197]  [<c14491cb>] devinet_ioctl+0x60b/0x6d0
[  116.287197]  [<c13f1284>] ? dev_ioctl+0x504/0x640
[  116.287197]  [<c144ad25>] inet_ioctl+0x95/0xb0
[  116.287197]  [<c13bd92d>] sock_ioctl+0x6d/0x290
[  116.287197]  [<c13bd8c0>] ? sock_fasync+0x80/0x80
[  116.287197]  [<c1159585>] vfs_ioctl+0x15/0x30
[  116.287197]  [<c1159e48>] do_vfs_ioctl+0x158/0x680
[  116.287197]  [<c114953a>] ? __vfs_write+0x2a/0xc0
[  116.287197]  [<c1148c0a>] ? rw_verify_area+0x5a/0x130
[  116.287197]  [<c114907c>] ? fsnotify_modify+0x6c/0x80
[  116.287197]  [<c1149687>] ? vfs_write+0xb7/0x130
[  116.287197]  [<c115a3fa>] SyS_ioctl+0x8a/0x90
[  116.287197]  [<c1001813>] do_int80_syscall_32+0x63/0x130
[  116.287197]  [<c14cac5a>] entry_INT80_32+0x2a/0x2a
[  116.287197] ---[ end trace 5aa726e4811c503f ]---
[  116.291957] genirq: Flags mismatch irq 10. 00000000 (3c515) vs.
00000000 (platform[pata_legacy.3])

- Matthew
