Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E9C433E9
	for <linux-ide@archiver.kernel.org>; Wed, 27 Jan 2021 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D21064DC4
	for <linux-ide@archiver.kernel.org>; Wed, 27 Jan 2021 21:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhA0V3e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 27 Jan 2021 16:29:34 -0500
Received: from mout01.posteo.de ([185.67.36.65]:60809 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhA0V2R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 27 Jan 2021 16:28:17 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3194916005C
        for <linux-ide@vger.kernel.org>; Wed, 27 Jan 2021 22:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1611782837; bh=MJxrzVe2aeDU9sxzUXS1R1bcUF7BBdUXF2A7A75N8Do=;
        h=Date:From:To:Subject:From;
        b=QgOGnFRTojlvCGFfGSKkSj4xgalPKX5VY8/hkwTTTl/z6FQkEPq+sZ0v0tI3lIGff
         OYRN/BrkES03OKE//k1xTiF/Ks/fDLbOCaCW7ojP2rZ6aLNq4BAjnEG6a6H1Ab/TiY
         QG47l1k07bMb+SG4KwGo0Ari7aRyVFAxYbV644z5Qz4ddVK3OmkqeeR5FRQpU/BKmN
         2H/VoZr+eePLqqLRJzu5z46pCtd25NZyOFNmEaQ8VJB5XlIO6m9fK83gLTGdj0zEpe
         vnFhIfeJavOGjBoz0Sg3hZvmNL39aIeUgX60zVENh53Z9C3S7rC9C9OOO26qws0u/1
         zWXUlNvgWil9g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DQxWm5ncsz9rxS
        for <linux-ide@vger.kernel.org>; Wed, 27 Jan 2021 22:27:16 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 27 Jan 2021 22:27:16 +0100
From:   =?UTF-8?Q?R=C3=B6tti?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
To:     Linux ide <linux-ide@vger.kernel.org>
Subject: Kernel panic caused by plugging in a sata cable on a a
 minipcie-sata board
Message-ID: <cbbb2496501fed013ccbeba524e8d573@posteo.de>
X-Sender: espressobinboardarmbiantempmailaddress@posteo.de
User-Agent: Posteo Webmail
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello everyone,

I own two ESPRESSOBin boards V5.

And to both I attached an XCSOURCE=C2=AE MiniPCIe Sata3.0 AC696 extension=
=20
card via MiniPCIe.

This is the link to amazon: https://www.amazon.de/dp/B06XRG2TGV

I tested several images from=20
https://www.armbian.com/espressobin/#kernels-archive-all

Tested Kernels 8 weeks ago + the latest two this week:
- 5.10.09-mvebu64  #21.02.0-hirsute (trunk) <-- works not
- 5.08.18-mvebu64  #20.11.6-bionic <-- works not
- 5.08.18-mvebu64  #20.11.3-focal <-- works not
- 5.08.18-mvebu64  #20.11.3-bionic <-- works not
- 5.08.06-mvebu64  #20.08.2-focal <-- works not
- 4.14.135-mvebu64 #19.11.3-bionic <-- works


Here is the whole UART-dump:

TIM-1.0
WTMI-devel-18.12.0-a0a1cb8
WTMI: system early-init
SVC REV: 3, CPU VDD voltage: 1.155V
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
NOTICE:  BL1: Built : 09:48:09, Feb 20 2019
NOTICE:  BL1: Booting BL2
NOTICE:  BL2: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
NOTICE:  BL2: Built : 09:48:10, Feb 20 2019
NOTICE:  BL1: Booting BL31
NOTICE:  BL31: v1.5(release):1f8ca7e (Marvell-devel-18.12.2)
NOTICE:  BL31: Built : 09:4

U-Boot 2018.03-devel-18.12.3-gc9aa92c-armbian (Feb 20 2019 - 09:45:04=20
+0100)

Model: Marvell Armada 3720 Community Board ESPRESSOBin
        CPU     1000 [MHz]
        L2      800 [MHz]
        TClock  200 [MHz]
        DDR     800 [MHz]
DRAM:  2 GiB
Comphy chip #0:
Comphy-0: USB3          5 Gbps
Comphy-1: PEX0          2.5 Gbps
Comphy-2: SATA0         6 Gbps
Target spinup took 0 ms.
AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
flags: ncq led only pmp fbss pio slum part sxs
PCIE-0: Link up
MMC:   sdhci@d0000: 0, sdhci@d8000: 1
Loading Environment from SPI Flash... SF: Detected w25q32dw with page=20
size 256 Bytes, erase size 4 KiB, total 4 MiB
OK
Model: Marvell Armada 3720 Community Board ESPRESSOBin
Net:   eth0: neta@30000 [PRIME]
Hit any key to stop autoboot:  0
starting USB...
USB0:   Register 2000104 NbrPorts 2
Starting the controller
USB XHCI 1.00
USB1:   USB EHCI 1.00
scanning bus 0 for devices... 1 USB Device(s) found
scanning bus 1 for devices... 1 USB Device(s) found
        scanning usb for storage devices... 0 Storage Device(s) found

## Loading init Ramdisk from Legacy Image at 01100000 ...
    Image Name:   uInitrd
    Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
    Data Size:    10750023 Bytes =3D 10.3 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 06000000
    Booting using the fdt blob at 0x6000000
    Loading Ramdisk to 7ebea000, end 7f62a847 ... OK
    Using Device Tree in place at 0000000006000000, end 00000000060059cd

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.8.18-mvebu64 (root@beast)=20
(aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture=20
8.3-2019.03 (arm-rel-8.36)) 8.3.0, GNU ld (GNU Toolchain for the=20
A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321)=20
#20.11.3 SMP PREEMPT Fri Dec 11 21:10:52 CET 2020
[    0.000000] Machine model: Globalscale Marvell ESPRESSOBin Board
[    0.000000] earlycon: ar3700_uart0 at MMIO 0x00000000d0012000=20
(options '')
[    0.000000] printk: bootconsole [ar3700_uart0] enabled
Loading, please wait...
Starting version 245.4-4ubuntu3.3
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/local-top=20
=2E.. done.
Begin: Running /scripts/local-premount ... Scanning for Btrfs=20
filesystems
done.
Begin: Will now check root file system ... fsck from util-linux 2.34
[/usr/sbin/fsck.ext4 (1) -- /dev/mmcblk0p1] fsck.ext4 -a -C0=20
/dev/mmcblk0p1
/dev/mmcblk0p1: clean, 41739/1828336 files, 439779/7502824 blocks
done.
done.
Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
[    3.694604] Internal error: synchronous external abort: 96000210 [#1]=20
PREEMPT SMP
[    3.699465] Modules linked in: tag_edsa mv88e6xxx dsa_core bridge stp=20
llc phy_mvebu_a3700_comphy
[    3.708518] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted=20
5.8.18-mvebu64 #20.11.3
[    3.716037] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
[    3.722685] Workqueue: events free_work
[    3.726614] pstate: 00000085 (nzcv daIf -PAN -UAO BTYPE=3D--)
[    3.732352] pc : ahci_single_level_irq_intr+0x1c/0x90
[    3.737549] lr : __handle_irq_event_percpu+0x5c/0x168
[    3.742737] sp : ffffffc0113bbd10
[    3.746142] x29: ffffffc0113bbd10 x28: ffffff807d48b700
[    3.751608] x27: 0000000000000060 x26: ffffffc010f085e8
[    3.757073] x25: ffffffc0113075a5 x24: ffffff8079101800
[    3.762539] x23: 000000000000002d x22: ffffffc0113bbdd4
[    3.768004] x21: 0000000000000000 x20: ffffffc011465008
[    3.773470] x19: ffffff8079381600 x18: 0000000000000000
[    3.778936] x17: 0000000000000000 x16: 0000000000000000
[    3.784401] x15: 000000d2c010fc50 x14: 0000000000000323
[    3.789867] x13: 00000000000002d4 x12: 0000000000000000
[    3.795332] x11: 0000000000000040 x10: ffffffc011282dd8
[    3.800798] x9 : ffffffc011282dd0 x8 : ffffff807d000270
[    3.806263] x7 : 0000000000000000 x6 : 0000000000000000
[    3.811729] x5 : ffffffc06ea93000 x4 : ffffffc0113bbe10
[    3.817196] x3 : ffffffc06ea93000 x2 : ffffff8079101a80
[    3.822661] x1 : ffffff8078803e00 x0 : 000000000000002d
[    3.828126] Call trace:
[    3.830642]  ahci_single_level_irq_intr+0x1c/0x90
[    3.835478]  __handle_irq_event_percpu+0x5c/0x168
[    3.840315]  handle_irq_event_percpu+0x38/0x90
[    3.844885]  handle_irq_event+0x48/0xe0
[    3.848828]  handle_simple_irq+0x94/0xd0
[    3.852860]  generic_handle_irq+0x30/0x48
[    3.856985]  advk_pcie_irq_handler+0x214/0x240
[    3.861552]  __handle_irq_event_percpu+0x5c/0x168
[    3.866389]  handle_irq_event_percpu+0x38/0x90
[    3.870959]  handle_irq_event+0x48/0xe0
[    3.874900]  handle_fasteoi_irq+0xb8/0x170
[    3.879112]  generic_handle_irq+0x30/0x48
[    3.883234]  __handle_domain_irq+0x64/0xc0
[    3.887447]  gic_handle_irq+0xc8/0x168
[    3.891298]  el1_irq+0xb8/0x180
[    3.894524]  unmap_kernel_range_noflush+0x128/0x188
[    3.899540]  remove_vm_area+0xac/0xd0
[    3.903303]  __vunmap+0x48/0x298
[    3.906618]  free_work+0x44/0x60
[    3.909937]  process_one_work+0x1e8/0x360
[    3.914057]  worker_thread+0x44/0x480
[    3.917820]  kthread+0x154/0x158
[    3.921135]  ret_from_fork+0x10/0x34
[    3.924812] Code: a90153f3 f9401022 f9400854 91002294 (b9400293)
[    3.931087] ---[ end trace 98b323414bb99c99 ]---
[    3.935829] Kernel panic - not syncing: Fatal exception in interrupt
[    3.942368] SMP: stopping secondary CPUs
[    3.946403] Kernel Offset: disabled
[    3.949985] CPU features: 0x240002,2000200c
[    3.954283] Memory Limit: none
[    3.957424] ---[ end Kernel panic - not syncing: Fatal exception in=20
interrupt ]---

The boards boots up if I don't plug in any SATA HDDs into the extension=20
card.

I hope this helps. If you need any other information just let me know,=20
I'm absolutely willing to help. But I have no clue of kernel=20
patching/compiling etc. Sorry!

Thank you very, very much in advance! You're doing an awesome job.

Sincerely R=C3=B6tti
