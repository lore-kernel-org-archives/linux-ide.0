Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A6AC43331
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FE620748
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UGCPsOx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZNdg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:33:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCZNdf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 09:33:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so7858151wrd.0
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tM6k8Fj2XI4jxMf4gSkaCKamkuF33gpbY1KQZ0hgoFw=;
        b=UGCPsOx5jnQ2Ux+sRSgo6aTg0cPtMC0qzVGNTx6Nch0MnvTYMf4a1KNzhTYOrLWOoI
         5QcEj4/RjpnUC0DCksZyT3A3Q+OOhM4th7qK+dFbikV6IdzKIuridAtEVgeRCWr6gR6u
         ufx7a1c+gDHIv6eyLCac6A2StIo4XSkY1FxXDkQDeGS8aL2X65zYLF89bMVTh4GTWf2n
         G2IX1GigwZCxjw76p5XSxHNuJDAG2m7bj4TEde3m4nRS9zKO0mB83yyP5yAIbBywLNcW
         wMDTj5BXxot+Onx8ZMd7nVtNoiXjoYcFfiDVVChfqhcoU8PWk4oni8Pnkd00SDx6sdBy
         xvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tM6k8Fj2XI4jxMf4gSkaCKamkuF33gpbY1KQZ0hgoFw=;
        b=Ieupm5z5EXWVIBYCoNzJcYlHYYkl0IOrUlMhBbSTFEg+OoqdIpotE2LGv746iIfnME
         R87CwzE7DO6MSeJJsQ9Zd7dvlHhWTYsGD8VyNRvRyaveKUGbaj7N6LJn8QDwM7umNu0W
         bKF0baKjpGuMCnTPAhsk90dJDeOS4UTAxoLZGD01sxuD4547hXSRcxOsdgI0PEYpjhhd
         Q5CzayYCikCluRH6fmm5HXb6gKOqGHiZSjb5MCdVn/Ut71KZflXuqbDYJ1F33qk5SnsG
         eSlKg9gWGRISuK7ZlVIaJKNWhXDFifClY7qBo4T9qkT7tuYWiYWVYfYbhCtsmJdBpHax
         0vgA==
X-Gm-Message-State: ANhLgQ2ZU1+jRoCgdRw+t4gu0qbMPUMj96ISKaoxMmtAeZ+jJyYLS/wA
        EnfhCE1mOzcxqZOliR9PSRaz0w==
X-Google-Smtp-Source: ADFU+vuAG/qcMqec7ejMoYEcbRmLvtNENpLIfQtBH+S4zQor/iwINluL1SgJixPZ8XiANB53bI9sdg==
X-Received: by 2002:adf:e650:: with SMTP id b16mr8998804wrn.328.1585229611431;
        Thu, 26 Mar 2020 06:33:31 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id i8sm3628053wrb.41.2020.03.26.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:33:30 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:33:28 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        pdeschrijver@nvidia.com,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        axboe@kernel.dk, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: tegra124-jetson-tk1: sata doesnt work since 5.2
Message-ID: <20200326133328.GA30045@Red>
References: <20200319074401.GA4116@Red>
 <CABr+WTnBmJsDZPjUxYkG98dTneDD1p8G=uRftVduTGYbY0ruqQ@mail.gmail.com>
 <20200325134003.GA27961@Red>
 <cf63d40c-7b84-60f6-76be-a13255e69c99@nvidia.com>
 <20200325142306.GB27961@Red>
 <20200325201125.GA832965@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325201125.GA832965@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Wed, Mar 25, 2020 at 09:15:56PM +0100, Thierry Reding wrote:
> On Wed, Mar 25, 2020 at 03:23:06PM +0100, LABBE Corentin wrote:
> > On Wed, Mar 25, 2020 at 02:00:25PM +0000, Jon Hunter wrote:
> > > 
> > > On 25/03/2020 13:40, LABBE Corentin wrote:
> > > > On Thu, Mar 19, 2020 at 08:55:38AM +0100, Nicolas Chauvet wrote:
> > > >> Le jeu. 19 mars 2020 à 08:44, LABBE Corentin <clabbe@baylibre.com> a écrit :
> > > >>>
> > > >>> Hello
> > > >>>
> > > >>> sata doesnt work on tegra124-jetson-tk1 on next and master and at least since 5.2 (but 5.1 works).
> > > >>> [    0.492810] +5V_SATA: supplied by +5V_SYS
> > > >>> [    0.493230] +12V_SATA: supplied by +VDD_MUX
> > > >>> [    2.088675] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> > > >>> [    2.097643] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> > > >>> [    3.314776] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> > > >>> [    3.323658] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> > > >>> [    5.236964] tegra-ahci 70027000.sata: 70027000.sata supply ahci not found, using dummy regulator
> > > >>> [    5.245867] tegra-ahci 70027000.sata: 70027000.sata supply phy not found, using dummy regulator
> > > >>> [    5.254706] tegra-ahci 70027000.sata: 70027000.sata supply target not found, using dummy regulator
> > > >>> [    5.310270] phy phy-sata.6: phy poweron failed --> -110
> > > >>> [    5.315604] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
> > > >>> [    5.323022] tegra-ahci: probe of 70027000.sata failed with error -110
> > > >>> [   35.694269] +5V_SATA: disabling
> > > >>> [   35.697438] +12V_SATA: disabling
> > > >>
> > > >> It looks strange, because (on same device) , I have sata working as
> > > >> appropriate, but ethernet fails with me.
> > > >> https://bugzilla.kernel.org/show_bug.cgi?id=206217
> > > >>
> > > >> It might worth to have another report.
> > > >>
> > > > 
> > > > Hello
> > > > 
> > > > Mine has ethernet works well. But I hit many problem with it and older kernel.
> > > > Perhaps the 5.1.21, were I am stuck, does not have it.
> > > > 
> > > > Anyway, the tegra of kerneci has the same SATA problem.
> > > > https://storage.kernelci.org/next/master/next-20200325/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-baylibre/boot-tegra124-jetson-tk1.txt
> > > > 
> > > > Maintainers, any idea on this sata issue ?
> > > 
> > > I have checked our bootlogs for v5.6-rc7 and don't see the issue with
> > > either the tegra_defconfig or the multi_v7_defconfig. I am wondering if
> > > this could be due a difference in the bootloader version. Currently we
> > > are testing with a v2019.07 u-boot bootloader. Looks like the kernelci
> > > board is using an older u-boot. Obviously it should still work, but
> > > would be good to know if the reason why were are not seeing this is
> > > because of the bootloader.
> > > 
> > > Another thing to check would be the pll_e clock frequency on a working
> > > build and non-working build to see if there is a difference in the pll
> > > frequency that is causing this.
> > > 
> > > Cheers
> > > Jon
> > > 
> > 
> > Hello
> > 
> > My uboot is 2016.01-rc4-00002-g3861d78, so a bit old.
> > I have a mainline uboot build for this tegra, but still didnt find a clear way to update it.
> > Did you have a good documentation on how to update it ?
> > If possible some clear uboot commands to update it via tftp.
> 
> Not sure about TFTP, but you can find the standard flashing scripts for
> various devices here:
> 
> 	https://github.com/NVIDIA/tegra-uboot-flasher-scripts
> 
> Those work by uploading the image via RCM and then running the commands
> to flash it.
> 
> I think those scripts will also create the images that they will flash,
> so you should be able to download that image via TFTP and then flash it
> using the command that the tool would normally use.
> 

Hello

I have upgrade uboot to 2019.07 with it thanks.

But this do not change the SATA behavour:
And with today next, lots of newer warning for the clk appeared.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 (compile@Red) (gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)) #4 SMP PREEMPT Thu Mar 26 10:56:25 CET 2020
[    0.000000] CPU: ARMv7 Processor [413fc0f3] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: NVIDIA Tegra124 Jetson TK1
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 64 MiB at 0xfbc00000
[    0.000000] percpu: Embedded 20 pages/cpu s50072 r8192 d23656 u81920
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 522496
[    0.000000] Kernel command line: console=ttyS0,115200 root=/dev/ram0
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 1972328K/2096128K available (10240K kernel code, 983K rwdata, 4172K rodata, 1024K init, 286K bss, 58264K reserved, 65536K cma-reserved, 1244160K highmem)
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] /interrupt-controller@60004000: 160 interrupts forwarded to /interrupt-controller@50041000
[    0.000000] random: get_random_bytes called from start_kernel+0x320/0x4c4 with crng_init=0
[    0.000000] Tegra clk 127: register failed with -17
[    0.000009] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.000030] clocksource: timer_us: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000045] Switching to timer-based delay loop, resolution 1000ns
[    0.000728] clocksource: tegra_suspend_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.001319] arch_timer: cp15 timer(s) running at 12.00MHz (virt).
[    0.001339] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x2c47f4ee7, max_idle_ns: 440795202497 ns
[    0.001359] sched_clock: 56 bits at 12MHz, resolution 83ns, wraps every 4398046511096ns
[    0.001373] Switching to timer-based delay loop, resolution 83ns
[    0.002050] Console: colour dummy device 80x30
[    0.002089] Calibrating delay loop (skipped), value calculated using timer frequency.. 24.00 BogoMIPS (lpj=120000)
[    0.002106] pid_max: default: 32768 minimum: 301
[    0.002459] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.002476] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.003481] CPU: Testing write buffer coherency: ok
[    0.003529] CPU0: Spectre v2: using ICIALLU workaround
[    0.003779] /cpus/cpu@0 missing clock-frequency property
[    0.003813] /cpus/cpu@1 missing clock-frequency property
[    0.003846] /cpus/cpu@2 missing clock-frequency property
[    0.003880] /cpus/cpu@3 missing clock-frequency property
[    0.003894] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.004624] Setting up static identity map for 0x80100000 - 0x801000ac
[    0.004765] rcu: Hierarchical SRCU implementation.
[    0.005629] Tegra Revision: A01 SKU: 129 CPU Process: 1 SoC Process: 1
[    0.006754] smp: Bringing up secondary CPUs ...
[    0.007985] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.007994] CPU1: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.012496] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.012504] CPU2: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.022513] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.022522] CPU3: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
[    0.031339] smp: Brought up 1 node, 4 CPUs
[    0.031352] SMP: Total of 4 processors activated (96.00 BogoMIPS).
[    0.031362] CPU: All CPU(s) started in SVC mode.
[    0.032210] devtmpfs: initialized
[    0.052953] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.053437] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.053459] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.054801] pinctrl core: initialized pinctrl subsystem
[    0.056228] NET: Registered protocol family 16
[    0.057789] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.059463] cpuidle: using governor menu
[    0.142794] No ATAGs?
[    0.142931] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.142948] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.154204] platform 50000000.host1x: Adding to iommu group 0
[    0.154294] platform 54200000.dc: Adding to iommu group 1
[    0.154359] platform 54240000.dc: Adding to iommu group 1
[    0.154435] platform 54340000.vic: Adding to iommu group 1
[    0.154495] platform 57000000.gpu: Adding to iommu group 1
[    0.206365] +5V_SYS: supplied by +VDD_MUX
[    0.207925] +3.3V_SYS: supplied by +VDD_MUX
[    0.211111] +USB0_VBUS_SW: supplied by +5V_SYS
[    0.212750] +5V_USB_HS: supplied by +5V_SYS
[    0.214472] +5V_HDMI_CON: supplied by +5V_SYS
[    0.216052] +5V_SATA: supplied by +5V_SYS
[    0.217598] reg-fixed-voltage regulators:regulator@14: nonexclusive access to GPIO for regulators:regulator@14
[    0.217631] +12V_SATA: supplied by +VDD_MUX
[    0.220159] iommu: Default domain type: Translated 
[    0.221420] vgaarb: loaded
[    0.222530] SCSI subsystem initialized
[    0.223287] usbcore: registered new interface driver usbfs
[    0.223372] usbcore: registered new interface driver hub
[    0.223499] usbcore: registered new device driver usb
[    0.223753] videodev: Linux video capture interface: v2.00
[    0.223843] pps_core: LinuxPPS API ver. 1 registered
[    0.223853] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.223903] PTP clock support registered
[    0.225716] Advanced Linux Sound Architecture Driver Initialized.
[    0.229333] clocksource: Switched to clocksource arch_sys_counter
[    1.027370] NET: Registered protocol family 2
[    1.028345] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 12288 bytes, linear)
[    1.028404] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    1.028510] TCP bind hash table entries: 8192 (order: 5, 163840 bytes, linear)
[    1.028735] TCP: Hash tables configured (established 8192 bind 8192)
[    1.029273] UDP hash table entries: 512 (order: 2, 24576 bytes, linear)
[    1.029372] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes, linear)
[    1.029676] NET: Registered protocol family 1
[    1.030543] RPC: Registered named UNIX socket transport module.
[    1.030556] RPC: Registered udp transport module.
[    1.030566] RPC: Registered tcp transport module.
[    1.030575] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.032334] PCI: CLS 0 bytes, default 64
[    1.033073] Trying to unpack rootfs image as initramfs...
[    2.767171] Freeing initrd memory: 22848K
[    2.768142] hw perfevents: enabled with armv7_cortex_a15 PMU driver, 7 counters available
[    2.783926] Initialise system trusted keyrings
[    2.784179] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    2.785269] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.785982] NFS: Registering the id_resolver key type
[    2.786011] Key type id_resolver registered
[    2.786022] Key type id_legacy registered
[    2.826372] Key type asymmetric registered
[    2.826387] Asymmetric key parser 'x509' registered
[    2.826532] bounce: pool size: 64 pages
[    2.826606] io scheduler mq-deadline registered
[    2.826617] io scheduler kyber registered
[    2.869168] tegra-apbdma 60020000.dma: Tegra20 APB DMA driver registered 32 channels
[    2.871898] tegra-pmc 7000e400.pmc: emergency thermal reset enabled
[    2.874090] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.881471] printk: console [ttyS0] disabled
[    2.881529] 70006300.serial: ttyS0 at MMIO 0x70006300 (irq = 78, base_baud = 25500000) is a Tegra
[    3.636824] printk: console [ttyS0] enabled
[    3.643635] 70006000.serial: ttyTHS1 at MMIO 0x70006000 (irq = 76, base_baud = 0) is a TEGRA_UART
[    3.654055] 70006040.serial: ttyTHS2 at MMIO 0x70006040 (irq = 77, base_baud = 0) is a TEGRA_UART
[    3.734807] brd: module loaded
[    3.769212] loop: module loaded
[    3.779490] libphy: Fixed MDIO Bus: probed
[    3.784165] CAN device driver interface
[    3.787997] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    3.795002] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.800740] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    3.808186] usbcore: registered new interface driver pegasus
[    3.813934] usbcore: registered new interface driver asix
[    3.819418] usbcore: registered new interface driver ax88179_178a
[    3.825561] usbcore: registered new interface driver cdc_ether
[    3.831502] usbcore: registered new interface driver smsc75xx
[    3.837314] usbcore: registered new interface driver smsc95xx
[    3.843133] usbcore: registered new interface driver net1080
[    3.848854] usbcore: registered new interface driver cdc_subset
[    3.854844] usbcore: registered new interface driver zaurus
[    3.860509] usbcore: registered new interface driver cdc_ncm
[    3.866589] tegra-phy 7d000000.usb-phy: supply vbus not found, using dummy regulator
[    3.874672] tegra-phy 7d004000.usb-phy: supply vbus not found, using dummy regulator
[    3.882984] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.889524] ehci-pci: EHCI PCI platform driver
[    3.894037] tegra-ehci: Tegra EHCI driver
[    3.902429] tegra-ehci 7d004000.usb: EHCI Host Controller
[    3.907858] tegra-ehci 7d004000.usb: new USB bus registered, assigned bus number 1
[    3.915874] tegra-ehci 7d004000.usb: irq 98, io mem 0x7d004000
[    3.949360] tegra-ehci 7d004000.usb: USB 2.0 started, EHCI 1.10
[    3.958474] hub 1-0:1.0: USB hub found
[    3.962291] hub 1-0:1.0: 1 port detected
[    3.972167] tegra-ehci 7d008000.usb: EHCI Host Controller
[    3.977583] tegra-ehci 7d008000.usb: new USB bus registered, assigned bus number 2
[    3.985416] tegra-ehci 7d008000.usb: irq 99, io mem 0x7d008000
[    4.019366] tegra-ehci 7d008000.usb: USB 2.0 started, EHCI 1.10
[    4.028423] hub 2-0:1.0: USB hub found
[    4.032241] hub 2-0:1.0: 1 port detected
[    4.040495] usbcore: registered new interface driver cdc_acm
[    4.046148] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    4.054230] usbcore: registered new interface driver cdc_wdm
[    4.060013] usbcore: registered new interface driver usb-storage
[    4.078692] i2c /dev entries driver
[    4.089060] at24 0-0056: supply vcc not found, using dummy regulator
[    4.097396] at24 0-0056: 256 byte 24c02 EEPROM, writable, 8 bytes/write
[    4.117688] as3722 4-0040: AS3722 with revision 0x1 found
[    4.130938] as3722-sd2: supplied by +5V_SYS
[    4.135641] as3722-sd3: supplied by +5V_SYS
[    4.140240] +1.35V_LP0(sd3): Bringing 0uV into 1350000-1350000uV
[    4.146661] as3722-sd4: supplied by +5V_SYS
[    4.151388] as3722-sd5: supplied by +5V_SYS
[    4.157591] as3722-ldo0: supplied by +1.35V_LP0(sd2)
[    4.163786] +1.8V_RUN_CAM: Bringing 0uV into 1800000-1800000uV
[    4.170094] as3722-ldo2: supplied by +1.8V_VDDIO
[    4.176066] as3722-ldo3: supplied by +3.3V_SYS
[    4.180608] +1.05V_LP0_VDD_RTC: Bringing 1100000uV into 1000000-1000000uV
[    4.188437] as3722-ldo4: supplied by +3.3V_SYS
[    4.193168] +2.8V_RUN_CAM: Bringing 0uV into 2800000-2800000uV
[    4.199479] as3722-ldo5: supplied by +1.8V_VDDIO
[    4.204340] +1.2V_RUN_CAM_FRONT: Bringing 0uV into 1200000-1200000uV
[    4.211331] +VDDIO_SDMMC3: bypassed regulator has no supply!
[    4.216984] +VDDIO_SDMMC3: failed to get the current voltage(-517)
[    4.223188] as3722-regulator as3722-regulator: regulator 13 register failed -517
[    4.236456] as3722-rtc as3722-rtc: registered as rtc0
[    4.241887] as3722-rtc as3722-rtc: setting system clock to 2000-01-01T00:01:28 UTC (946684888)
[    4.250515] as3722-rtc as3722-rtc: RTC interrupt 377
[    4.258635] usbcore: registered new interface driver uvcvideo
[    4.264435] USB Video Class driver (1.1.1)
[    4.268525] gspca_main: v2.14.0 registered
[    4.273540] lm90 0-004c: supply vcc not found, using dummy regulator
[    4.283455] sdhci: Secure Digital Host Controller Interface driver
[    4.289653] sdhci: Copyright(c) Pierre Ossman
[    4.294003] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.300064] sdhci-tegra 700b0400.sdhci: Got CD GPIO
[    4.304971] sdhci-tegra 700b0400.sdhci: Got WP GPIO
[    4.309900] mmc0: Missing autocal timeout 3v3-pad drvs
[    4.315031] mmc0: Missing autocal timeout 3v3-pad drvs
[    4.320179] mmc0: Missing autocal timeout 1v8-pad drvs
[    4.325309] mmc0: Missing autocal timeout 1v8-pad drvs
[    4.338814] mmc0: Missing autocal timeout 3v3-pad drvs
[    4.343972] mmc0: Missing autocal timeout 3v3-pad drvs
[    4.349103] mmc0: Missing autocal timeout 1v8-pad drvs
[    4.354250] mmc0: Missing autocal timeout 1v8-pad drvs
[    4.367583] mmc0: Invalid maximum block size, assuming 512 bytes
[    4.405147] mmc0: SDHCI controller on 700b0600.sdhci [700b0600.sdhci] using ADMA 64-bit
[    4.414361] usbcore: registered new interface driver usbhid
[    4.419985] usbhid: USB HID core driver
[    4.434262] input: tegra-hda HDMI/DP,pcm=3 as /devices/soc0/70030000.hda/sound/card0/input0
[    4.489657] mmc0: new high speed MMC card at address 0001
[    4.496619] mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
[    4.502328] mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
[    4.509415] mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
[    4.515631] mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB, chardev (247:0)
[    4.842518] random: fast init done
[    4.857450] tegra30-i2s 70301100.i2s: DMA channels sourced from device 70300000.ahub
[    4.865785] ------------[ cut here ]------------
[    4.870411] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:954 clk_core_disable+0xf4/0x300
[    4.878402] pmc_clk_out_1 already disabled
[    4.882491] Modules linked in:
[    4.885550] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    4.894668] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    4.900946] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    4.908686] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    4.915908] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    4.922779] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    4.930256] [<c0123bac>] (warn_slowpath_fmt) from [<c04e5e44>] (clk_core_disable+0xf4/0x300)
[    4.938688] [<c04e5e44>] (clk_core_disable) from [<c04e6068>] (clk_core_disable_lock+0x18/0x24)
[    4.947384] [<c04e6068>] (clk_core_disable_lock) from [<c0837f5c>] (tegra_asoc_utils_set_rate+0xa4/0x2b0)
[    4.956945] [<c0837f5c>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    4.966506] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    4.975545] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    4.984151] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    4.992411] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    5.000671] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    5.009536] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    5.018055] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    5.026228] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    5.034401] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    5.042486] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    5.050659] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    5.059354] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    5.067525] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    5.075083] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    5.080129] 1fa0:                                     00000000 00000000 00000000 00000000
[    5.088297] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.096464] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.103074] ---[ end trace 94155ca1eb3f2299 ]---
[    5.107724] ------------[ cut here ]------------
[    5.112362] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:813 clk_core_unprepare+0x10c/0x2b0
[    5.120627] pmc_clk_out_1 already unprepared
[    5.124888] Modules linked in:
[    5.127945] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    5.138449] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    5.144718] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    5.152455] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    5.159672] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    5.166542] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    5.174020] [<c0123bac>] (warn_slowpath_fmt) from [<c04e9650>] (clk_core_unprepare+0x10c/0x2b0)
[    5.182711] [<c04e9650>] (clk_core_unprepare) from [<c04e9818>] (clk_unprepare+0x24/0x2c)
[    5.190884] [<c04e9818>] (clk_unprepare) from [<c0837f64>] (tegra_asoc_utils_set_rate+0xac/0x2b0)
[    5.199751] [<c0837f64>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    5.209309] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    5.218345] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    5.226949] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    5.235208] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    5.243467] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    5.252333] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    5.260852] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    5.269021] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    5.277193] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    5.285279] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    5.293449] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    5.302141] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    5.310311] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    5.317868] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    5.322916] 1fa0:                                     00000000 00000000 00000000 00000000
[    5.331084] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.339251] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.345926] ---[ end trace 94155ca1eb3f229a ]---
[    5.350552] ------------[ cut here ]------------
[    5.355169] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:954 clk_core_disable+0xf4/0x300
[    5.363158] pll_a_out0 already disabled
[    5.366987] Modules linked in:
[    5.370042] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    5.380545] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    5.386813] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    5.394551] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    5.401768] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    5.408638] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    5.416113] [<c0123bac>] (warn_slowpath_fmt) from [<c04e5e44>] (clk_core_disable+0xf4/0x300)
[    5.424542] [<c04e5e44>] (clk_core_disable) from [<c04e6068>] (clk_core_disable_lock+0x18/0x24)
[    5.433235] [<c04e6068>] (clk_core_disable_lock) from [<c0837f70>] (tegra_asoc_utils_set_rate+0xb8/0x2b0)
[    5.442796] [<c0837f70>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    5.452354] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    5.461390] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    5.469994] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    5.478253] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    5.486511] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    5.495378] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    5.503898] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    5.512069] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    5.520241] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    5.528326] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    5.536496] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    5.545187] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    5.553357] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    5.560915] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    5.565961] 1fa0:                                     00000000 00000000 00000000 00000000
[    5.574129] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.582295] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.588899] ---[ end trace 94155ca1eb3f229b ]---
[    5.593538] ------------[ cut here ]------------
[    5.598156] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:813 clk_core_unprepare+0x10c/0x2b0
[    5.606422] pll_a_out0 already unprepared
[    5.610438] Modules linked in:
[    5.613493] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    5.623996] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    5.630264] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    5.638001] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    5.645217] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    5.652087] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    5.659566] [<c0123bac>] (warn_slowpath_fmt) from [<c04e9650>] (clk_core_unprepare+0x10c/0x2b0)
[    5.668257] [<c04e9650>] (clk_core_unprepare) from [<c04e9818>] (clk_unprepare+0x24/0x2c)
[    5.676431] [<c04e9818>] (clk_unprepare) from [<c0837f78>] (tegra_asoc_utils_set_rate+0xc0/0x2b0)
[    5.685298] [<c0837f78>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    5.694857] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    5.703892] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    5.712497] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    5.720756] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    5.729015] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    5.737881] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    5.746399] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    5.754571] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    5.762743] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    5.770828] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    5.778999] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    5.787691] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    5.795862] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    5.803418] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    5.808464] 1fa0:                                     00000000 00000000 00000000 00000000
[    5.816632] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    5.824799] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    5.831425] ---[ end trace 94155ca1eb3f229c ]---
[    5.836035] ------------[ cut here ]------------
[    5.840651] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:954 clk_core_disable+0xf4/0x300
[    5.848639] pll_a already disabled
[    5.852033] Modules linked in:
[    5.855087] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    5.865590] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    5.871856] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    5.879593] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    5.886809] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    5.893679] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    5.901156] [<c0123bac>] (warn_slowpath_fmt) from [<c04e5e44>] (clk_core_disable+0xf4/0x300)
[    5.909584] [<c04e5e44>] (clk_core_disable) from [<c04e6068>] (clk_core_disable_lock+0x18/0x24)
[    5.918277] [<c04e6068>] (clk_core_disable_lock) from [<c0837f84>] (tegra_asoc_utils_set_rate+0xcc/0x2b0)
[    5.927837] [<c0837f84>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    5.937395] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    5.946430] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    5.955036] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    5.963295] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    5.971555] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    5.980421] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    5.988939] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    5.997110] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    6.005283] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    6.013367] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    6.021538] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    6.030230] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    6.038400] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    6.045956] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    6.051001] 1fa0:                                     00000000 00000000 00000000 00000000
[    6.059169] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    6.067335] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.073939] ---[ end trace 94155ca1eb3f229d ]---
[    6.078577] ------------[ cut here ]------------
[    6.083213] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:813 clk_core_unprepare+0x10c/0x2b0
[    6.091985] pll_a already unprepared
[    6.095556] Modules linked in:
[    6.098611] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-rc7-next-20200326-00073-ge3021b91dbe2 #4
[    6.109113] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    6.115382] [<c0111d20>] (unwind_backtrace) from [<c010bc74>] (show_stack+0x10/0x14)
[    6.123118] [<c010bc74>] (show_stack) from [<c0a99ddc>] (dump_stack+0xc0/0xd4)
[    6.130335] [<c0a99ddc>] (dump_stack) from [<c01237b8>] (__warn+0xd0/0xf8)
[    6.137205] [<c01237b8>] (__warn) from [<c0123bac>] (warn_slowpath_fmt+0x98/0xbc)
[    6.144683] [<c0123bac>] (warn_slowpath_fmt) from [<c04e9650>] (clk_core_unprepare+0x10c/0x2b0)
[    6.153375] [<c04e9650>] (clk_core_unprepare) from [<c04e9818>] (clk_unprepare+0x24/0x2c)
[    6.161550] [<c04e9818>] (clk_unprepare) from [<c0837f8c>] (tegra_asoc_utils_set_rate+0xd4/0x2b0)
[    6.170417] [<c0837f8c>] (tegra_asoc_utils_set_rate) from [<c08381fc>] (tegra_asoc_utils_init+0x94/0x180)
[    6.179975] [<c08381fc>] (tegra_asoc_utils_init) from [<c083b2c0>] (tegra_rt5640_probe+0x108/0x178)
[    6.189011] [<c083b2c0>] (tegra_rt5640_probe) from [<c05de864>] (platform_drv_probe+0x48/0x98)
[    6.197616] [<c05de864>] (platform_drv_probe) from [<c05dc774>] (really_probe+0x1e0/0x344)
[    6.205875] [<c05dc774>] (really_probe) from [<c05dca14>] (driver_probe_device+0x60/0x16c)
[    6.214135] [<c05dca14>] (driver_probe_device) from [<c05dccc0>] (device_driver_attach+0x58/0x60)
[    6.223001] [<c05dccc0>] (device_driver_attach) from [<c05dcd20>] (__driver_attach+0x58/0xcc)
[    6.231519] [<c05dcd20>] (__driver_attach) from [<c05dab90>] (bus_for_each_dev+0x78/0xb8)
[    6.239690] [<c05dab90>] (bus_for_each_dev) from [<c05dbb1c>] (bus_add_driver+0xf8/0x1dc)
[    6.247863] [<c05dbb1c>] (bus_add_driver) from [<c05dd890>] (driver_register+0x74/0x108)
[    6.255947] [<c05dd890>] (driver_register) from [<c010206c>] (do_one_initcall+0x50/0x2b0)
[    6.264117] [<c010206c>] (do_one_initcall) from [<c1000fa4>] (kernel_init_freeable+0x188/0x200)
[    6.272811] [<c1000fa4>] (kernel_init_freeable) from [<c0ab19d8>] (kernel_init+0x8/0x110)
[    6.280981] [<c0ab19d8>] (kernel_init) from [<c01001a8>] (ret_from_fork+0x14/0x2c)
[    6.288538] Exception stack(0xee8d1fb0 to 0xee8d1ff8)
[    6.293583] 1fa0:                                     00000000 00000000 00000000 00000000
[    6.301752] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    6.309918] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    6.316548] ---[ end trace 94155ca1eb3f229e ]---
[    6.329641] tegra-snd-rt5640 sound: rt5640-aif1 <-> 70301100.i2s mapping ok
[    6.340720] input: NVIDIA Tegra Jetson TK1 Headphones as /devices/soc0/sound/sound/card1/input1
[    6.351932] NET: Registered protocol family 10
[    6.357741] Segment Routing with IPv6
[    6.361579] mip6: Mobile IPv6
[    6.364545] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    6.372221] NET: Registered protocol family 17
[    6.376687] NET: Registered protocol family 15
[    6.381175] can: controller area network core (rev 20170425 abi 9)
[    6.387543] NET: Registered protocol family 29
[    6.392036] can: raw protocol (rev 20170425)
[    6.396301] can: broadcast manager protocol (rev 20170425 t)
[    6.401984] can: netlink gateway (rev 20190810) max_hops=1
[    6.407748] Key type dns_resolver registered
[    6.413087] Registering SWP/SWPB emulation handler
[    6.418146] Loading compiled-in X.509 certificates
[    6.458497] +3.3V_RUN: supplied by +3.3V_SYS
[    6.464078] +3.3V_LP0: supplied by +3.3V_SYS
[    6.468822] +3.3V_AVDD_HDMI_AP_GATED: supplied by +3.3V_RUN
[    6.475276] tegra-xusb-padctl 7009f000.padctl: failed to get regulators: -517
[    6.482887] tegra-pcie 1003000.pcie: host bridge /pcie@1003000 ranges:
[    6.489459] tegra-pcie 1003000.pcie:      MEM 0x0001000000..0x0001001fff -> 0x0001000000
[    6.497556] tegra-pcie 1003000.pcie:       IO 0x0012000000..0x001200ffff -> 0x0000000000
[    6.505674] tegra-pcie 1003000.pcie:      MEM 0x0013000000..0x001fffffff -> 0x0013000000
[    6.513790] tegra-pcie 1003000.pcie:      MEM 0x0020000000..0x003fffffff -> 0x0020000000
[    6.522074] tegra-pcie 1003000.pcie: 2x1, 1x1 configuration
[    6.529486] tegra-ahci 70027000.sata: supply ahci not found, using dummy regulator
[    6.537159] tegra-ahci 70027000.sata: supply phy not found, using dummy regulator
[    6.545607] as3722-regulator as3722-regulator: DMA mask not set
[    6.553831] as3722-sd2: supplied by +5V_SYS
[    6.558376] as3722-sd3: supplied by +5V_SYS
[    6.563045] as3722-sd4: supplied by +5V_SYS
[    6.567595] as3722-sd5: supplied by +5V_SYS
[    6.573459] as3722-ldo0: supplied by +1.35V_LP0(sd2)
[    6.578979] as3722-ldo1: supplied by +3.3V_RUN
[    6.583833] as3722-ldo2: supplied by +1.8V_VDDIO
[    6.589518] as3722-ldo3: supplied by +3.3V_SYS
[    6.594938] as3722-ldo4: supplied by +3.3V_SYS
[    6.599781] as3722-ldo5: supplied by +1.8V_VDDIO
[    6.604756] as3722-ldo6: supplied by +3.3V_RUN
[    6.609667] as3722-ldo7: supplied by +1.8V_VDDIO
[    6.615110] +1.05V_RUN_CAM_REAR: Bringing 0uV into 1050000-1050000uV
[    6.622271] as3722-ldo9: supplied by +5V_SYS
[    6.627323] +3.3V_RUN_TOUCH: Bringing 0uV into 2800000-2800000uV
[    6.634559] as3722-ldo10: supplied by +5V_SYS
[    6.639706] +2.8V_RUN_CAM_AF: Bringing 0uV into 2800000-2800000uV
[    6.646573] as3722-ldo11: supplied by +3.3V_RUN
[    6.651928] +1.8V_RUN_VPP_FUSE: Bringing 0uV into 1800000-1800000uV
[    6.659784] sdhci-tegra 700b0400.sdhci: Got CD GPIO
[    6.664695] sdhci-tegra 700b0400.sdhci: Got WP GPIO
[    6.669643] mmc1: Missing autocal timeout 3v3-pad drvs
[    6.674775] mmc1: Missing autocal timeout 3v3-pad drvs
[    6.679922] mmc1: Missing autocal timeout 1v8-pad drvs
[    6.685053] mmc1: Missing autocal timeout 1v8-pad drvs
[    6.698706] mmc1: Invalid maximum block size, assuming 512 bytes
[    6.740348] mmc1: SDHCI controller on 700b0400.sdhci [700b0400.sdhci] using ADMA 64-bit
[    6.750650]  usb2-1: supply vbus not found, using dummy regulator
[    6.757114]  usb3-0: supply vbus not found, using dummy regulator
[    6.764033] tegra-pcie 1003000.pcie: host bridge /pcie@1003000 ranges:
[    6.770865] tegra-pcie 1003000.pcie:      MEM 0x0001000000..0x0001001fff -> 0x0001000000
[    6.779031] tegra-pcie 1003000.pcie:       IO 0x0012000000..0x001200ffff -> 0x0000000000
[    6.787197] tegra-pcie 1003000.pcie:      MEM 0x0013000000..0x001fffffff -> 0x0013000000
[    6.795347] tegra-pcie 1003000.pcie:      MEM 0x0020000000..0x003fffffff -> 0x0020000000
[    6.803702] tegra-pcie 1003000.pcie: 2x1, 1x1 configuration
[    6.811601] tegra-pcie 1003000.pcie: probing port 0, using 2 lanes
[    6.819521] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
[    6.916426] mmc1: new high speed SDHC card at address 1388
[    6.923995] mmcblk1: mmc1:1388 NCard 7.32 GiB 
[    6.932600]  mmcblk1: p1 p2 p3 < p5 >
[    8.039456] tegra-pcie 1003000.pcie: link 0 down, ignoring
[    8.049460] tegra-pcie 1003000.pcie: PCI host bridge to bus 0000:00
[    8.055729] pci_bus 0000:00: root bus resource [bus 00-ff]
[    8.061233] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01001fff]
[    8.068109] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    8.074302] pci_bus 0000:00: root bus resource [mem 0x13000000-0x1fffffff]
[    8.081185] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3fffffff pref]
[    8.088881] pci 0000:00:02.0: [10de:0e13] type 01 class 0x060400
[    8.094927] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
[    8.104589] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
[    8.114286] pci 0000:00:02.0: enabling Extended Tags
[    8.119250] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
[    8.129003] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x3e may corrupt adjacent RW1C bits
[    8.138772] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[    8.148561] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    8.155188] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4c may corrupt adjacent RW1C bits
[    8.169512] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x3e may corrupt adjacent RW1C bits
[    8.179245] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
[    8.188907] pci_bus 0000:00: 1-byte config write to 0000:00:02.0 offset 0xc may corrupt adjacent RW1C bits
[    8.198562] PCI: bus0: Fast back to back transfers disabled
[    8.204148] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    8.212160] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x3e may corrupt adjacent RW1C bits
[    8.222146] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
[    8.228195] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x00ff]
[    8.233819] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00000fff 64bit]
[    8.240638] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[    8.248031] pci 0000:01:00.0: supports D1 D2
[    8.252317] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    8.284058] PCI: bus1: Fast back to back transfers disabled
[    8.289665] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    8.296301] pci 0000:00:02.0: BAR 8: assigned [mem 0x13000000-0x130fffff]
[    8.303105] pci 0000:00:02.0: BAR 9: assigned [mem 0x20000000-0x200fffff 64bit pref]
[    8.310856] pci 0000:00:02.0: BAR 7: assigned [io  0x1000-0x1fff]
[    8.316955] pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20003fff 64bit pref]
[    8.324727] pci 0000:01:00.0: BAR 2: assigned [mem 0x13000000-0x13000fff 64bit]
[    8.332066] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[    8.338161] pci 0000:00:02.0: PCI bridge to [bus 01]
[    8.343139] pci 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
[    8.349232] pci 0000:00:02.0:   bridge window [mem 0x13000000-0x130fffff]
[    8.356029] pci 0000:00:02.0:   bridge window [mem 0x20000000-0x200fffff 64bit pref]
[    8.363812] pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
[    8.370925] pcieport 0000:00:02.0: enabling device (0140 -> 0143)
[    8.377212] pcieport 0000:00:02.0: PME: Signaling with IRQ 25
[    8.383738] pcieport 0000:00:02.0: AER: enabled with IRQ 25
[    8.390057] r8169 0000:01:00.0: enabling device (0140 -> 0143)
[    8.427492] libphy: r8169: probed
[    8.431973] r8169 0000:01:00.0 eth0: RTL8168g/8111g, 00:04:4b:2f:50:23, XID 4c0, IRQ 393
[    8.440122] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    8.459061] +1.05V_RUN_AVDD_HDMI_PLL: supplied by +1.05V_RUN
[    8.467881] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.474698] drm drm: [drm] Cannot find any crtc or sizes
[    8.480606] drm drm: [drm] Cannot find any crtc or sizes
[    8.487085] [drm] Initialized tegra 0.0.0 20120330 for drm on minor 0
[    8.494155] tegra-ahci 70027000.sata: supply ahci not found, using dummy regulator
[    8.501937] tegra-ahci 70027000.sata: supply phy not found, using dummy regulator
[    8.509692] tegra-ahci 70027000.sata: supply target not found, using dummy regulator
[    8.559410] phy phy-sata.6: phy poweron failed --> -110
[    8.564759] tegra-ahci 70027000.sata: failed to power on AHCI controller: -110
[    8.572789] tegra-ahci: probe of 70027000.sata failed with error -110
[    8.581468] phy phy-usb2.0: no port found for USB2 lane 0
[    8.586866] phy phy-usb2.0: phy poweron failed --> -19
[    8.592062] tegra-xusb 70090000.usb: failed to enable PHYs: -19
[    8.599590] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 696000 KHz
[    8.606922] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 714000 KHz
[    8.615832] input: gpio-keys as /devices/soc0/gpio-keys/input/input2
[    8.622774] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    8.638560] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.647744] ALSA device list:
[    8.650758]   #0: tegra-hda at 0x70038000 irq 88
[    8.655361]   #1: NVIDIA Tegra Jetson TK1
[    8.660056] Freeing unused kernel memory: 1024K

for the value of pll_e:
working 5.1.21
pll_e                          4        4        0   100000000          0     0  50000
non working 5.6
pll_e                          2        2        0   100000000          0     0  50000
