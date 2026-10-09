Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8C47ECD8;
	Fri,  9 Oct 2026 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531227; cv=none; b=obqGC/obR+TfUG8NeEKiG5GF/paxI0BZOdEVFNLWgqGJ+wMkXsjtr4rTzVCcYkjoChPjXUH3UTt/Erx4JdkWufBA5dwI8YnUJGpWOUqHcp1ht/aQtKw7kw+abldcSt/y5IDNdyM/MjejlSfQ0U6EwqWljKlRTgNLwOCJunzXt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531227; c=relaxed/simple;
	bh=ah0uvXYioNuN1PjSOB3yd/XKsnr8OOzFFwurbShFXJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA2SpKM5bkoH02e+zVNlF4/SH/DlQF/pJW+Srv6zEhR1ie5is/iFzOyEupcHPm5TspvJKHzcA+/moDJOOKD9cpLcM/TsQbXSU7b335NKS+EOEgYUfLtHmS1Nvs4jplmj2S1lSE0qCZO6eJ08VjjU3zKNv46bXFjp2ba1/LyzABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9ZgFVQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9ZgFVQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF8C1F000FF;
	Fri,  9 Oct 2026 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531225;
	bh=++BKtTpjGmPNZdWoozsVFxoIxe6EF8BLGALpPJPcYqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e9ZgFVQeyMiZh69gsRgLtopfNhG8XUfvykM+J35uFFNB7lIGIsm6I3QlHuysraZDB
	 uUg8jakh0ne0wXBWe7mZI4jc+TFpCXkcz74syUagpdJg/suLqjZotgYWptpIsQDEUy
	 zCW7icW78W8XAFhVpQ80Os/yKFyQZFpUdM2KbpZBPe7ke6w9SRAv31d0J5xYszbwSD
	 ImjCwKc3/BAYdUlLIJO+TGpLyjTVg8BfXdYH0M8fPftYXW/A/w/SUWcdZj0EPZaT+t
	 n4xNR3hWgz81QJVLlirwLMAw47sKcgcNuiSrwLLuv91FFnBpEwuqNw2v7DVbDtXaiy
	 n8kjWpj3jCzVA==
Message-ID: <1b9f33d6-f887-432a-83ec-292ff43eccdd@kernel.org>
Date: Fri, 9 Oct 2026 09:33:42 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_PROBLEM=3A_Kernel_6=2E8=2Ex=3A_VFS=3A_Unable_to_mou?=
 =?UTF-8?Q?nt_root_fs_on_unknown-block=280=2C0=29_=E2=80=93_SATA_=28Intel_AH?=
 =?UTF-8?Q?CI=29_not_detected?=
To: Hans-Joachim Lange <lange-achim@posteo.de>, linux-ide@vger.kernel.org
Cc: cassel@kernel.org, regressions@lists.linux.dev
References: <c096264c-640f-4491-b242-399bba9cbbac@posteo.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c096264c-640f-4491-b242-399bba9cbbac@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/10/07 14:40, Hans-Joachim Lange wrote:
> Hello,
> 
> I am experiencing a regression: kernel 5.15.x boots fine, but 6.8.x
> fails with "Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(0,0)". The SATA controller (Intel, rev 06) is not
> detected; /dev/sda never appears. The ahci module is present in the
> initramfs but does not load.
> 
> [1.] One line summary:
>      Kernel 6.8.x fails to detect Intel SATA AHCI controller; /dev/sda 
> not created.

Please try again with at least the latest stable kernel, or ideally the latest
mainline kernel (7.3-rc6 as of this week). And also please try to capture the
boot messages with the bad kernel. Hard to say what's happening without that.
You can use network console or simply a video/pictures of the screen where we
can see the ata messages.

> 
> [2.] Full description:
>      On a [Laptop-Modell], Linux Mint 21.x, kernel 5.15.x boots normally.
>      Kernel 6.8.x panics during initramfs: "VFS: Unable to mount root fs
>      on unknown-block(0,0)". The initramfs contains ahci.ko, sd_mod.ko,
>      libahci.ko, libata.ko (verified with lsinitramfs). No shell is
>      reachable (break=bottom, rdinit=/usr/bin/sh both fail). Secure Boot
>      was disabled during testing.
> 
> [3.] Keywords:
>      ahci, sata, ata, initramfs, boot, regression
> 
> [4.] Kernel version:
>      Working:  5.15.0-xx-generic
>      Broken:   6.8.0-xx-generic
> 
> [5.] Oops/Panic message:
>      Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(0,0)
> 
> [7.] Environment:
>      Distro: Linux Mint 21.x (Ubuntu 22.04 based)
>      Arch: x86_64
>      Controller: Intel Corporation [SATA controller] (rev 06)
>      Kernel driver in use (on 5.15): ahci
> 
>      lspci -k output:
>     00:00.0 Host bridge: Intel Corporation Gemini Lake Host Bridge (rev 06)
>      DeviceName: Onboard - Other
> 00:00.1 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Dynamic Platform and Thermal Framework Processor 
> Participant (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Dynamic Platform and Thermal Framework Processor Participant
>      Kernel driver in use: proc_thermal
>      Kernel modules: processor_thermal_device_pci_legacy
> 00:02.0 VGA compatible controller: Intel Corporation GeminiLake [UHD 
> Graphics 600] (rev 06)
>      DeviceName: Onboard - Video
>      Kernel driver in use: i915
>      Kernel modules: i915
> 00:0e.0 Multimedia audio controller: Intel Corporation Celeron/Pentium 
> Silver Processor High Definition Audio (rev 06)
>      DeviceName: Onboard - Sound
>      Subsystem: Realtek Semiconductor Co., Ltd. Celeron/Pentium Silver 
> Processor High Definition Audio
>      Kernel driver in use: sof-audio-pci-intel-apl
>      Kernel modules: snd_hda_intel, snd_soc_skl, snd_sof_pci_intel_apl
> 00:0f.0 Communication controller: Intel Corporation Celeron/Pentium 
> Silver Processor Trusted Execution Engine Interface (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Trusted Execution Engine Interface
>      Kernel driver in use: mei_me
>      Kernel modules: mei_me
> 00:12.0 SATA controller: Intel Corporation Celeron/Pentium Silver 
> Processor SATA Controller (rev 06)
>      DeviceName: Onboard - SATA
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor SATA 
> Controller
>      Kernel driver in use: ahci
>      Kernel modules: ahci
> 00:13.0 PCI bridge: Intel Corporation Gemini Lake PCI Express Root Port 
> (rev f6)
>      Subsystem: Intel Corporation Gemini Lake PCI Express Root Port
>      Kernel driver in use: pcieport
> 00:14.0 PCI bridge: Intel Corporation Gemini Lake PCI Express Root Port 
> (rev f6)
>      Subsystem: Intel Corporation Gemini Lake PCI Express Root Port
>      Kernel driver in use: pcieport
> 00:15.0 USB controller: Intel Corporation Celeron/Pentium Silver 
> Processor USB 3.0 xHCI Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor USB 
> 3.0 xHCI Controller
>      Kernel driver in use: xhci_hcd
>      Kernel modules: xhci_pci
> 00:16.0 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 0 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 0
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:16.1 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 1 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 1
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:16.2 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 2 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 2
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:16.3 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 3 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 3
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:17.0 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 4 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 4
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:17.1 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 5 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 5
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:17.2 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 6 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 6
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:17.3 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor I2C 7 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor I2C 7
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:18.0 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO UART Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO UART Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:18.1 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO UART Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO UART Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:18.2 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO UART Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO UART Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:18.3 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO UART Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO UART Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:19.0 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO SPI Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO SPI Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:19.1 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO SPI Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO SPI Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:19.2 Signal processing controller: Intel Corporation Celeron/Pentium 
> Silver Processor Serial IO SPI Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Serial IO SPI Host Controller
>      Kernel driver in use: intel-lpss
>      Kernel modules: intel_lpss_pci
> 00:1c.0 SD Host controller: Intel Corporation Celeron/Pentium Silver 
> Processor SDA Standard Compliant SD Host Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor SDA 
> Standard Compliant SD Host Controller
>      Kernel driver in use: sdhci-pci
>      Kernel modules: sdhci_pci
> 00:1e.0 SD Host controller: Intel Corporation Device 31d0 (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Device 7270
>      Kernel driver in use: sdhci-pci
>      Kernel modules: sdhci_pci
> 00:1f.0 ISA bridge: Intel Corporation Celeron/Pentium Silver Processor 
> LPC Controller (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor LPC 
> Controller
>      Kernel driver in use: lpc_ich
>      Kernel modules: lpc_ich
> 00:1f.1 SMBus: Intel Corporation Celeron/Pentium Silver Processor 
> Gaussian Mixture Model (rev 06)
>      DeviceName: Onboard - Other
>      Subsystem: Intel Corporation Celeron/Pentium Silver Processor 
> Gaussian Mixture Model
>      Kernel driver in use: i801_smbus
>      Kernel modules: i2c_i801
> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 
> 802.11ac PCIe Wireless Network Adapter
>      Subsystem: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe 
> Wireless Network Adapter
>      Kernel modules: rtw88_8821ce, rtw_8821ce, 8821ce
> 
>      dmesg | grep -iE "ata|sata|ahci" (on 5.15.x):
>     [    0.000000] BIOS-e820: [mem 
> 0x000000006dd70000-0x000000006dd80fff] ACPI data
> [    0.000000] reserve setup_data: [mem 
> 0x0000000000000000-0x000000000003efff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000000003f000-0x000000000003ffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x0000000000040000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000000009e000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x0000000000100000-0x000000000fffffff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x0000000010000000-0x0000000012150fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x0000000012151000-0x00000000607a9017] usable
> [    0.000000] reserve setup_data: [mem 
> 0x00000000607a9018-0x00000000607b9057] usable
> [    0.000000] reserve setup_data: [mem 
> 0x00000000607b9058-0x000000006b4bbfff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000006b4bc000-0x000000006dd6ffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x000000006dd70000-0x000000006dd80fff] ACPI data
> [    0.000000] reserve setup_data: [mem 
> 0x000000006dd81000-0x000000006dde0fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 
> 0x000000006dde1000-0x000000006e1e6fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x000000006e1e7000-0x000000006ea3cfff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000006ea3d000-0x000000006ea3dfff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 
> 0x000000006ea3e000-0x000000006ea3ffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x000000006ea40000-0x000000006eb14fff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000006eb15000-0x000000006ebc4fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x000000006ebc5000-0x000000006effffff] usable
> [    0.000000] reserve setup_data: [mem 
> 0x000000006f000000-0x000000007fffffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000d0000000-0x00000000d0ffffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000d3709000-0x00000000d3709fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000fe042000-0x00000000fe044fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000fe900000-0x00000000fe902fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000fed01000-0x00000000fed01fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x00000000ff800000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 
> 0x0000000100000000-0x00000001ffffffff] usable
> [    0.024880] NODE_DATA(0) allocated [mem 0x1fffd6000-0x1ffffffff]
> [    0.203122] Memory: 5547680K/5931444K available (16393K kernel code, 
> 4402K rwdata, 11004K rodata, 3296K init, 18764K bss, 383508K reserved, 
> 0K cma-reserved)
> [    0.370364] Register File Data Sampling: Mitigation: Clear Register File
> [    0.718375] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.932015] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.932228] libata version 3.00 loaded.
> [    1.936203] Write protecting the kernel read-only data: 30720k
> [    1.936858] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    1.937125] Freeing unused kernel image (rodata/data gap) memory: 1284K
> [    2.238334] ahci 0000:00:12.0: version 3.0
> [    2.249922] ahci 0000:00:12.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 
> 0x3 impl SATA mode
> [    2.249929] ahci 0000:00:12.0: flags: 64bit ncq sntf pm clo only pmp 
> pio slum part deso sadm sds apst
> [    2.256735] scsi host0: ahci
> [    2.260141] scsi host1: ahci
> [    2.260198] ata1: SATA max UDMA/133 abar m2048@0x80040000 port 
> 0x80040100 irq 124
> [    2.260204] ata2: SATA max UDMA/133 abar m2048@0x80040000 port 
> 0x80040180 irq 124
> [    2.575597] ata2: SATA link down (SStatus 4 SControl 300)
> [    2.737540] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    2.739515] ata1.00: ATA-9: SSD 1TB, X0606B0, max UDMA/133
> [    2.740480] ata1.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 
> 32), AA
> [    2.744572] ata1.00: configured for UDMA/133
> [    2.745087] scsi 0:0:0:0: Direct-Access     ATA      SSD 1TB          
> 6B0  PQ: 0 ANSI: 5
> [    6.125323] EXT4-fs (sda4): mounted filesystem with ordered data 
> mode. Opts: (null). Quota mode: none.
> [    7.231564] cfg80211: Loading compiled-in X.509 certificates for 
> regulatory database
> [    7.253660] systemd[1]: systemd-hwdb-update.service - Rebuild 
> Hardware Database was skipped because of an unmet condition check 
> (ConditionNeedsUpdate=/etc).
> [    9.645970] EXT4-fs (sda5): mounted filesystem with ordered data 
> mode. Opts: (null). Quota mode: none.
> 
> [X.] Notes:
>      - ahci.ko is present in initramfs but not loaded
>      - No initramfs shell reachable (break=bottom, rdinit both fail)
>      - Secure Boot disabled during testing
>      - First broken kernel: 6.x.x (if known)
>      - Last working kernel: 5.15.x
> 
> Thank you


-- 
Damien Le Moal
Western Digital Research
