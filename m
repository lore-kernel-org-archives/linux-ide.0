From: Ido Schimmel <idosch@mellanox.com>
Subject: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Thu, 24 Aug 2017 14:29:32 +0300
Message-ID: <20170824112932.GA12461@shredder.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:62869
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752195AbdHXL3n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 24 Aug 2017 07:29:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hch@lst.de, tj@kernel.org
Cc: xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

Hi,

Booting kernel v4.13-rc6 on my system results in the following errors in
the kernel log:

ata5.00: qc timeout (cmd 0x47)
ata5.00: READ LOG DMA EXT failed, trying PIO
ata5.00: ATA Identify Device Log not supported
ata5.00: Security Log not supported
ata5.00: failed to set xfermode (err_mask=0x40)
ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x5)
ata5.00: revalidation failed (errno=-5)
ata5: limiting SATA link speed to 3.0 Gbps
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=0x5)
ata5.00: revalidation failed (errno=-5)
ata5.00: disabled
ata5: hard resetting link
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
ata5: EH complete

And a dracut shell. Bisected this down to commit 818831c8b22f ("libata:
implement SECURITY PROTOCOL IN/OUT"). Can you please look into it? I can
easily test your patches.

I didn't find any relevant patches in patchwork or similar reports
beside this one:
https://www.spinics.net/lists/kernel/msg2533719.html

To which no one replied.

Thanks!

More info that might help:

Full bisection log:

git bisect start
# bad: [5771a8c08880cdca3bfb4a3fc6d309d6bba20877] Linux v4.13-rc1
git bisect bad 5771a8c08880cdca3bfb4a3fc6d309d6bba20877
# good: [6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c] Linux 4.12
git bisect good 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c
# good: [e5f76a2e0e84ca2a215ecbf6feae88780d055c56] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good e5f76a2e0e84ca2a215ecbf6feae88780d055c56
# bad: [bd78acad8e866e1167f9de97c9b090ee6c2c96a7] parisc: move generic-y of exported headers to uapi/asm/Kbuild
git bisect bad bd78acad8e866e1167f9de97c9b090ee6c2c96a7
# bad: [e0f25a3f2d052e36ff67a9b4db835c3e27e950d8] Merge tag 'hwlock-v4.13' of git://github.com/andersson/remoteproc
git bisect bad e0f25a3f2d052e36ff67a9b4db835c3e27e950d8
# bad: [920f2ecdf6c3b3526f60fbd38c68597953cad3ee] Merge tag 'sound-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 920f2ecdf6c3b3526f60fbd38c68597953cad3ee
# good: [b821d298f8864dc3c3d42643812df43289159507] Merge remote-tracking branch 'asoc/topic/inte' into asoc-next
git bisect good b821d298f8864dc3c3d42643812df43289159507
# good: [7fc8e7c1d9787ab8cb0f91adb3bc9c2c64c00ef8] Merge branch 'for-linus' into for-next
git bisect good 7fc8e7c1d9787ab8cb0f91adb3bc9c2c64c00ef8
# good: [9b51f04424e17051a89ab32d892ca66b2a104825] Merge branch 'parisc-4.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good 9b51f04424e17051a89ab32d892ca66b2a104825
# bad: [109a5db5042c035ded330b948a710b9a0c20934d] Merge branch 'for-4.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata
git bisect bad 109a5db5042c035ded330b948a710b9a0c20934d
# bad: [79af3ae6e293855321dcd1a43c73be316fdff1a9] ata: pata_octeon_cf: make of_device_ids const.
git bisect bad 79af3ae6e293855321dcd1a43c73be316fdff1a9
# good: [f01f62c257cc343246a5a9b2df8135f01fc044ab] libata: move ata_read_log_page to libata-core.c
git bisect good f01f62c257cc343246a5a9b2df8135f01fc044ab
# bad: [af36ddc988922adc00221b37662120cd78f4aa7d] ata: Add DT bindings for Faraday Technology FTIDE010
git bisect bad af36ddc988922adc00221b37662120cd78f4aa7d
# good: [1d51d5f3907abf86ef0521971bcddf5853564263] libata: clarify log page naming / grouping
git bisect good 1d51d5f3907abf86ef0521971bcddf5853564263
# bad: [818831c8b22f75353f59a63a484e20736c0567c9] libata: implement SECURITY PROTOCOL IN/OUT
git bisect bad 818831c8b22f75353f59a63a484e20736c0567c9
# good: [a0fd2454a36ffab2ce39b3a91c1385a5f98e63f0] libata: factor out a ata_identify_page_supported helper
git bisect good a0fd2454a36ffab2ce39b3a91c1385a5f98e63f0
# first bad commit: [818831c8b22f75353f59a63a484e20736c0567c9] libata: implement SECURITY PROTOCOL IN/OUT

Relevant hardware info:

$ lshw -class disk
  *-disk                    
       description: ATA Disk
       product: M.2 (S42) 3ME3
       physical id: 0.0.0
       bus info: scsi@4:0.0.0
       logical name: /dev/sda
       version: 19
       serial: 20161029AA101511210E
       size: 14GiB (16GB)
       capabilities: partitioned partitioned:dos
       configuration: ansiversion=5 logicalsectorsize=512 sectorsize=512 signature=8de6ec69
$ lshw -class storage
  *-storage:0               
       description: SATA controller
       product: Atom processor C2000 AHCI SATA2 Controller
       vendor: Intel Corporation
       physical id: 17
       bus info: pci@0000:00:17.0
       version: 02
       width: 32 bits
       clock: 66MHz
       capabilities: storage msi pm ahci_1.0 bus_master cap_list
       configuration: driver=ahci latency=0
       resources: irq:27 ioport:f0f0(size=8) ioport:f0e0(size=4) ioport:f0d0(size=8) ioport:f0c0(size=4) ioport:f040(size=32) memory:dfcaa000-dfcaa7ff
  *-storage:1
       description: SATA controller
       product: Atom processor C2000 AHCI SATA3 Controller
       vendor: Intel Corporation
       physical id: 18
       bus info: pci@0000:00:18.0
       version: 02
       width: 32 bits
       clock: 66MHz
       capabilities: storage msi pm ahci_1.0 bus_master cap_list
       configuration: driver=ahci latency=0
       resources: irq:28 ioport:f0b0(size=8) ioport:f0a0(size=4) ioport:f090(size=8) ioport:f080(size=4) ioport:f020(size=32) memory:dfca9000-dfca97ff
  *-scsi
       physical id: 1
       logical name: scsi4
       capabilities: emulated
