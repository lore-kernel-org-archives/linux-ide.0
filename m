Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C384A7C80
	for <linux-ide@vger.kernel.org>; Wed,  7 Oct 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791376840; cv=none; b=FJCZ6ZZKVidLB3WZsvIiL8HoW8n/EfnF1sd6IZQlold+F2dwrBL8qStr+C7WTCW3OQ0Sb5mGoWpv3qHFkdYrGEtlUtrWr3sgWy+d0W9yTk4F1f9p0AEFebSeMrxprO8BYWGe4Kn8TfTnbS1s9Jjfa1qJMDHnC8daSm6jqavS/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791376840; c=relaxed/simple;
	bh=Jc90DrgkmkCJP1d2Pn4L/y2dewlgSz0NqzIH+8ytKFA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Ama1F4LQyZrxUK/d4hpYEJ01af0J4H6JoYQdbPxne7ugGfWBvlWYUaxTKLYXoSy4AxBCCe8rPY7CcM3y5pZmtcVjxsKnnP6uFuBa3cuGBqOYh/RidhdmSarGRK4ycHwoz4Sz9nY/pvUJEsQA43tgWaW0UlGzTjHz+wE6YayFQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=RseLTobI; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="RseLTobI"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6D049240103
	for <linux-ide@vger.kernel.org>; Wed,  7 Oct 2026 14:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791376827;
	bh=fczfhEFWLc2TCU+JCu6EcM1jW34Ct6CugUZBv9ftY2Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:From;
	b=RseLTobIeutNV5gw+sgRmciE9VWCcKPtzCK5MSGTYHmx+0NtJjDyoOcv22XhLbdO8
	 gTfWSpCU+gRxTTVfZpIONQYL3NE5QpJ8YvmM+RKd5hME8Q/ggcQuRUPGnFm2EQR3++
	 N5JfzOC9hliT+ZeGFD2TDnFYe4UQARCq/k1qF50luBpHX3QyJX+BPBVveM3fy6pF6e
	 uLut4VjLLPj2EZChfZ+z3qaXPCjJGosLXF6K94KII55pZXl+fB3ZUWCODQcretNEL3
	 q5SS58Gy+1D+S1s7WAs4B3Qzlbo8CNBzI01qpXhqZK7bxTQmd1eHyYoijH2ewB9eLl
	 P/NoNAimK6RIg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j0CQK6WCFz9rxB;
	Wed,  7 Oct 2026 14:40:25 +0200 (CEST)
Message-ID: <c096264c-640f-4491-b242-399bba9cbbac@posteo.de>
Date: Wed, 07 Oct 2026 12:40:27 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hans-Joachim Lange <lange-achim@posteo.de>
Subject: =?UTF-8?Q?PROBLEM=3A_Kernel_6=2E8=2Ex=3A_VFS=3A_Unable_to_mount_roo?=
 =?UTF-8?Q?t_fs_on_unknown-block=280=2C0=29_=E2=80=93_SATA_=28Intel_AHCI=29_?=
 =?UTF-8?Q?not_detected?=
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org, cassel@kernel.org, regressions@lists.linux.dev
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I am experiencing a regression: kernel 5.15.x boots fine, but 6.8.x
fails with "Kernel panic - not syncing: VFS: Unable to mount root fs
on unknown-block(0,0)". The SATA controller (Intel, rev 06) is not
detected; /dev/sda never appears. The ahci module is present in the
initramfs but does not load.

[1.] One line summary:
     Kernel 6.8.x fails to detect Intel SATA AHCI controller; /dev/sda 
not created.

[2.] Full description:
     On a [Laptop-Modell], Linux Mint 21.x, kernel 5.15.x boots normally.
     Kernel 6.8.x panics during initramfs: "VFS: Unable to mount root fs
     on unknown-block(0,0)". The initramfs contains ahci.ko, sd_mod.ko,
     libahci.ko, libata.ko (verified with lsinitramfs). No shell is
     reachable (break=bottom, rdinit=/usr/bin/sh both fail). Secure Boot
     was disabled during testing.

[3.] Keywords:
     ahci, sata, ata, initramfs, boot, regression

[4.] Kernel version:
     Working:  5.15.0-xx-generic
     Broken:   6.8.0-xx-generic

[5.] Oops/Panic message:
     Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)

[7.] Environment:
     Distro: Linux Mint 21.x (Ubuntu 22.04 based)
     Arch: x86_64
     Controller: Intel Corporation [SATA controller] (rev 06)
     Kernel driver in use (on 5.15): ahci

     lspci -k output:
    00:00.0 Host bridge: Intel Corporation Gemini Lake Host Bridge (rev 06)
     DeviceName: Onboard - Other
00:00.1 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Dynamic Platform and Thermal Framework Processor 
Participant (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Dynamic Platform and Thermal Framework Processor Participant
     Kernel driver in use: proc_thermal
     Kernel modules: processor_thermal_device_pci_legacy
00:02.0 VGA compatible controller: Intel Corporation GeminiLake [UHD 
Graphics 600] (rev 06)
     DeviceName: Onboard - Video
     Kernel driver in use: i915
     Kernel modules: i915
00:0e.0 Multimedia audio controller: Intel Corporation Celeron/Pentium 
Silver Processor High Definition Audio (rev 06)
     DeviceName: Onboard - Sound
     Subsystem: Realtek Semiconductor Co., Ltd. Celeron/Pentium Silver 
Processor High Definition Audio
     Kernel driver in use: sof-audio-pci-intel-apl
     Kernel modules: snd_hda_intel, snd_soc_skl, snd_sof_pci_intel_apl
00:0f.0 Communication controller: Intel Corporation Celeron/Pentium 
Silver Processor Trusted Execution Engine Interface (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Trusted Execution Engine Interface
     Kernel driver in use: mei_me
     Kernel modules: mei_me
00:12.0 SATA controller: Intel Corporation Celeron/Pentium Silver 
Processor SATA Controller (rev 06)
     DeviceName: Onboard - SATA
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor SATA 
Controller
     Kernel driver in use: ahci
     Kernel modules: ahci
00:13.0 PCI bridge: Intel Corporation Gemini Lake PCI Express Root Port 
(rev f6)
     Subsystem: Intel Corporation Gemini Lake PCI Express Root Port
     Kernel driver in use: pcieport
00:14.0 PCI bridge: Intel Corporation Gemini Lake PCI Express Root Port 
(rev f6)
     Subsystem: Intel Corporation Gemini Lake PCI Express Root Port
     Kernel driver in use: pcieport
00:15.0 USB controller: Intel Corporation Celeron/Pentium Silver 
Processor USB 3.0 xHCI Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor USB 
3.0 xHCI Controller
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci
00:16.0 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 0 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 0
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:16.1 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 1 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 1
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:16.2 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 2 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 2
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:16.3 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 3 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 3
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:17.0 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 4 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 4
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:17.1 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 5 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 5
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:17.2 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 6 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 6
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:17.3 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor I2C 7 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 7
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:18.0 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO UART Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO UART Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:18.1 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO UART Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO UART Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:18.2 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO UART Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO UART Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:18.3 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO UART Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO UART Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:19.0 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO SPI Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO SPI Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:19.1 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO SPI Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO SPI Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:19.2 Signal processing controller: Intel Corporation Celeron/Pentium 
Silver Processor Serial IO SPI Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Serial IO SPI Host Controller
     Kernel driver in use: intel-lpss
     Kernel modules: intel_lpss_pci
00:1c.0 SD Host controller: Intel Corporation Celeron/Pentium Silver 
Processor SDA Standard Compliant SD Host Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor SDA 
Standard Compliant SD Host Controller
     Kernel driver in use: sdhci-pci
     Kernel modules: sdhci_pci
00:1e.0 SD Host controller: Intel Corporation Device 31d0 (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Device 7270
     Kernel driver in use: sdhci-pci
     Kernel modules: sdhci_pci
00:1f.0 ISA bridge: Intel Corporation Celeron/Pentium Silver Processor 
LPC Controller (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor LPC 
Controller
     Kernel driver in use: lpc_ich
     Kernel modules: lpc_ich
00:1f.1 SMBus: Intel Corporation Celeron/Pentium Silver Processor 
Gaussian Mixture Model (rev 06)
     DeviceName: Onboard - Other
     Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
Gaussian Mixture Model
     Kernel driver in use: i801_smbus
     Kernel modules: i2c_i801
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 
802.11ac PCIe Wireless Network Adapter
     Subsystem: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe 
Wireless Network Adapter
     Kernel modules: rtw88_8821ce, rtw_8821ce, 8821ce

     dmesg | grep -iE "ata|sata|ahci" (on 5.15.x):
    [    0.000000] BIOS-e820: [mem 
0x000000006dd70000-0x000000006dd80fff] ACPI data
[    0.000000] reserve setup_data: [mem 
0x0000000000000000-0x000000000003efff] usable
[    0.000000] reserve setup_data: [mem 
0x000000000003f000-0x000000000003ffff] reserved
[    0.000000] reserve setup_data: [mem 
0x0000000000040000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 
0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 
0x0000000000100000-0x000000000fffffff] usable
[    0.000000] reserve setup_data: [mem 
0x0000000010000000-0x0000000012150fff] reserved
[    0.000000] reserve setup_data: [mem 
0x0000000012151000-0x00000000607a9017] usable
[    0.000000] reserve setup_data: [mem 
0x00000000607a9018-0x00000000607b9057] usable
[    0.000000] reserve setup_data: [mem 
0x00000000607b9058-0x000000006b4bbfff] usable
[    0.000000] reserve setup_data: [mem 
0x000000006b4bc000-0x000000006dd6ffff] reserved
[    0.000000] reserve setup_data: [mem 
0x000000006dd70000-0x000000006dd80fff] ACPI data
[    0.000000] reserve setup_data: [mem 
0x000000006dd81000-0x000000006dde0fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x000000006dde1000-0x000000006e1e6fff] reserved
[    0.000000] reserve setup_data: [mem 
0x000000006e1e7000-0x000000006ea3cfff] usable
[    0.000000] reserve setup_data: [mem 
0x000000006ea3d000-0x000000006ea3dfff] ACPI NVS
[    0.000000] reserve setup_data: [mem 
0x000000006ea3e000-0x000000006ea3ffff] reserved
[    0.000000] reserve setup_data: [mem 
0x000000006ea40000-0x000000006eb14fff] usable
[    0.000000] reserve setup_data: [mem 
0x000000006eb15000-0x000000006ebc4fff] reserved
[    0.000000] reserve setup_data: [mem 
0x000000006ebc5000-0x000000006effffff] usable
[    0.000000] reserve setup_data: [mem 
0x000000006f000000-0x000000007fffffff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000d0000000-0x00000000d0ffffff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000d3709000-0x00000000d3709fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000fe042000-0x00000000fe044fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000fe900000-0x00000000fe902fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000fed01000-0x00000000fed01fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 
0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 
0x0000000100000000-0x00000001ffffffff] usable
[    0.024880] NODE_DATA(0) allocated [mem 0x1fffd6000-0x1ffffffff]
[    0.203122] Memory: 5547680K/5931444K available (16393K kernel code, 
4402K rwdata, 11004K rodata, 3296K init, 18764K bss, 383508K reserved, 
0K cma-reserved)
[    0.370364] Register File Data Sampling: Mitigation: Clear Register File
[    0.718375] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.932015] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.932228] libata version 3.00 loaded.
[    1.936203] Write protecting the kernel read-only data: 30720k
[    1.936858] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    1.937125] Freeing unused kernel image (rodata/data gap) memory: 1284K
[    2.238334] ahci 0000:00:12.0: version 3.0
[    2.249922] ahci 0000:00:12.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[    2.249929] ahci 0000:00:12.0: flags: 64bit ncq sntf pm clo only pmp 
pio slum part deso sadm sds apst
[    2.256735] scsi host0: ahci
[    2.260141] scsi host1: ahci
[    2.260198] ata1: SATA max UDMA/133 abar m2048@0x80040000 port 
0x80040100 irq 124
[    2.260204] ata2: SATA max UDMA/133 abar m2048@0x80040000 port 
0x80040180 irq 124
[    2.575597] ata2: SATA link down (SStatus 4 SControl 300)
[    2.737540] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.739515] ata1.00: ATA-9: SSD 1TB, X0606B0, max UDMA/133
[    2.740480] ata1.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 
32), AA
[    2.744572] ata1.00: configured for UDMA/133
[    2.745087] scsi 0:0:0:0: Direct-Access     ATA      SSD 1TB          
6B0  PQ: 0 ANSI: 5
[    6.125323] EXT4-fs (sda4): mounted filesystem with ordered data 
mode. Opts: (null). Quota mode: none.
[    7.231564] cfg80211: Loading compiled-in X.509 certificates for 
regulatory database
[    7.253660] systemd[1]: systemd-hwdb-update.service - Rebuild 
Hardware Database was skipped because of an unmet condition check 
(ConditionNeedsUpdate=/etc).
[    9.645970] EXT4-fs (sda5): mounted filesystem with ordered data 
mode. Opts: (null). Quota mode: none.

[X.] Notes:
     - ahci.ko is present in initramfs but not loaded
     - No initramfs shell reachable (break=bottom, rdinit both fail)
     - Secure Boot disabled during testing
     - First broken kernel: 6.x.x (if known)
     - Last working kernel: 5.15.x

Thank you

