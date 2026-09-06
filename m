Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267C86329
	for <linux-ide@vger.kernel.org>; Sun,  6 Sep 2026 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788671108; cv=none; b=mZXdNON2eI1p0UZZPrzLOTk9n/KY4/121HoHRf+Qh3FWGwqclt17POF6Q/xQKt5JHXEsqKTRX3c27Jed7vmwJIi3Ti5VVhdJWhqolqfNQmV37oSqorNndUfys/DXuNOn7DbNboUqHq1ekzoDIixqGiNdARdU0cNC9LhvZdv5wVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788671108; c=relaxed/simple;
	bh=YgYgBAAMUMbzQ1Yt57F5vwKHC4Z+Khrmk/VuT4Ol10w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NC0oNgo1/oF4MmHOw6UiQJ5NyJctY1MILy/VNxJwOcwmifDvnuTJcucrxxkwSHj7rqVoywXigJb0win75AJ9W11j5ngejYn1KiSlxPgqyq1ajyWxVThUXXOcvXgBq6MqhbR5tMP6Ca7jvh4Dw7UDyJrILeGMHFC8BQyQivpXIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAqVyiVe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAqVyiVe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2411549a91.2
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788671107; x=1789275907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUIGmCEIhlHBJbu35BsFij7w+kVs3fHpV8HmNX1rv5w=;
        b=FAqVyiVeZvr/PI3eKup8k1nSYz5SQUJmR7yMXRNvNGvNXNDc5D4+vnGgJlzu+SpIFW
         vhVe21Ow3kD48oTJUwgb6Oq2owQwnkwaXiuxdV7QjmC99dYVktX+iADfDie7c2p/l6rF
         vO8fuLJXW9iXxUIu4Q4uYHXHUUi53Zsu0ninnw4JZnEtx+bhJfOOL3vKvlKKJFW5f6b9
         kux2M0uUw92yJTKK6oulWDGhBpjQQoLUS1GphzKONBLN8RFSoKBOOqiI1TwoYpp6dp1Y
         ph+IDU0QchVuCZmc31VOqEYNIEzhWRKbgx5wu+PDCahqpaVFIAv2qMDdNNlBahtxFXPT
         EQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788671107; x=1789275907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JUIGmCEIhlHBJbu35BsFij7w+kVs3fHpV8HmNX1rv5w=;
        b=ktkTO3tcVYjYVcX07BZuLim2ZuV6tnAd6hEeiOcW5H8oHuODWH9HjcMUF30HBu/9wR
         M9752wY46tp3eRPFwNpHqvatyguIiUIu6pzl+UwAbZozgABgd3IAMQ9F2W/X2MpkoEqR
         ozbmwxCJjQ0vwgX+OLCHfltlo48DEGxPeWsC6+QPMDk4u62rArymi/xfoVl2MVt9kV9c
         qInx95HU9zEhFBM0XMbRNZ8KRk3GpqlouLglEF+Q1P2Jy4wG1CEIJ+22RBtLQ6Xpj+0k
         tPJTK1vwpAPMcg1OJzwVhsrfwMNIj88fhAU1CE0d0fVb+NkidVEBxPXbvQmJPLr+9obb
         avLg==
X-Forwarded-Encrypted: i=1; AKwUvBx3Nm+4a8iFSra3vFNTLp3AJUnYzDpB1+9U0r6/JdM/PXtQp1Sd+7sjtmOF7bOp07GnrsqbeVHbZBk=@vger.kernel.org
X-Gm-Message-State: AFuF++ngz2EkF6B6p880UAhSXk0OqAx/2C6ttiNlzaeLjfLTm73vPNtU
	GDSBspHRgEAX4SjdTXiEZ7fKXKL79Gvg5vAmHT3lS3gBS/8HV/Qcs9D8
X-Gm-Gg: AYBFou1VEF3RBCQSzeaD2T+n9ooVnliWgTSTGkpMBVMnb4K7njAjqWlyIsdsQYNwSr+
	ywtzAubRkZG8BUBqPLna4U1ixVsiAgaCKWP2hVfE8AeiJNTsMXb2UtsrEwtJCpCtDRHEozFkhGz
	jT7i0LHDteLO03+neK/Qqfn5ITQvmEhueIQb+B8uyisavvf5n75nu0lCVE+98xhqXF2zW/eh7xt
	E3n9SBagoN2oCa/qEZIjfjwR6SFfFSk+l33IxT9b57SItSTAdS8RuVP6rYv7Pg7ZTcmxp+2itHh
	l1wmqN5nPLVh4md+yZ24DnB2iF0gxDHZvDF4ADPVUjnAMfqOGSNXiZpOJR6GnEsZ1ssD+PGtOYr
	HNFZhwSN6tplLyOw0EOAfeGn1uMrek0Ah4RtCL5vRjgIloN5JK6CyELt1nlNlrjk0xEEChKCiUh
	AQ+/cZEI3uIyz3Y428Z8cJ+pAzF7TTKsUOLU0IOzb5D4iKv3hoAGZS5MNBfnrGdHFNT5cMG20y4
	Z+R
X-Received: by 2002:a17:90b:3c45:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-39b26232bb1mr25188202a91.20.1788671106688;
        Sat, 05 Sep 2026 22:05:06 -0700 (PDT)
Received: from claudeLX-01.hammies.cc ([165.173.24.245])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm16230165c88.14.2026.09.05.22.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 22:05:06 -0700 (PDT)
From: Alvin Lim <alvinwylim@gmail.com>
To: mario.limonciello@amd.com,
	mikael1022bzh@gmail.com,
	cassel@kernel.org
Cc: roland.waltersson@netinsight.net,
	artmoty@gmail.com,
	linux-ide@vger.kernel.org,
	david.laight.linux@gmail.com,
	kernel@wantstofly.org,
	imjohnsmith4000@gmail.com
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Date: Sun,  6 Sep 2026 13:05:01 +0800
Message-ID: <20260906050501.1309388-1-alvinwylim@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1c3df04b-7929-4b43-adb7-6007347a954e@amd.com>
References: <178854093896.541085.18395405788748617410@gmail.com> <20260905113848.1397882-1-alvinwylim@gmail.com> <1c3df04b-7929-4b43-adb7-6007347a954e@amd.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 05, 2026 at 07:26:49AM -0500, Mario Limonciello wrote:
> Two things:
>
> 1. lspci -ttvvnn
> 2. Turn on  amd_smn_debugfs_enable=1 on kernel command line.

Both below. Your script ran unmodified.

Conditions
----------

  Board      : AOOSTAR WTR MAX (DMI: TianBei "WTR MAX")
  BIOS       : AMI 0.01, 2025-04-27, revision 5.29
  CPU        : AMD Ryzen 7 PRO 8845HS
  SATA       : ASMedia ASM1166 [1b21:1166] rev 02, 6 HDDs
               subsystem [1b21:2116], PCIe 8GT/s x2
  Cmdline    : root=/dev/mapper/pve-root ro amd_iommu=off quiet
               amd_iommu=off amd_smn_debugfs_enable=1

amd_iommu=off was in force for every reading below. I did not re-enable
the IOMMU at any point, so these are values as seen in the configuration
this machine has run since 2026-06-17.

I took the same maintenance window to apply a pending Proxmox kernel
security update, and captured twice so the reboot was not wasted:

  7.0.14-14-pve   the kernel I quoted in my earlier mail
  7.0.14-15-pve   after the update

The two captures are byte-identical, so on this box the values do not
depend on which of those two kernels is running. That is an observation,
not a conclusion -- I have no basis for saying more than that.

To be explicit, since I would rather foreclose the misreading than
correct it later: this is not a test of the corruption on the newer
kernel. amd_iommu=off was set for both boots, so neither capture
exercised the failing path, and nothing here says anything about whether
7.0.14-15 behaves differently.

SMN registers
-------------

  0x111401d0: 0x00000100
  0x111411d0: 0x00000100
  0x111421d0: 0x00000000
  0x111431d0: 0x00000100
  0x111441d0: 0x00000100
  0x112401d0: 0x00000100
  0x112411d0: 0x00000100
  0x112421d0: 0x00000100
  0x112431d0: 0x00000100
  0x112441d0: 0x00000100
  0x112451d0: 0x00000100
  0x113401d0: 0x00000100
  0x114401d0: 0x00000100

All thirteen read cleanly; no invalid reads and nothing stalled. I have
not tried to interpret them and am not going to guess at what they mean.

lspci -ttvvnn
-------------

-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Phoenix Root Complex [1022:14e8]
           +-00.2  Advanced Micro Devices, Inc. [AMD] Phoenix IOMMU [1022:14e9]
           +-01.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge [1022:14ea]
           +-01.1-[6a]--
           +-01.2-[6b]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller SM951/PM951 [144d:a802]
           +-01.3-[6c]----00.0  Micron/Crucial Technology P510 NVMe PCIe SSD (DRAM-less) [c0a9:560a]
           +-01.5-[6d]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller 980 (DRAM-less) [144d:a809]
           +-02.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge [1022:14ea]
           +-02.2-[64-65]--+-00.0  Intel Corporation Ethernet Controller X710 for 10GbE SFP+ [8086:1572]
           |               \-00.1  Intel Corporation Ethernet Controller X710 for 10GbE SFP+ [8086:1572]
           +-02.3-[66]----00.0  Intel Corporation Ethernet Controller I226-V [8086:125c]
           +-02.4-[67]----00.0  Intel Corporation Ethernet Controller I226-V [8086:125c]
           +-02.5-[68]----00.0  ASMedia Technology Inc. ASM1166 Serial ATA Controller [1b21:1166]
           +-02.6-[69]----00.0  Micron/Crucial Technology T500 NVMe PCIe SSD [c0a9:5415]
           +-03.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge [1022:14ea]
           +-03.1-[04-63]--
           +-04.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge [1022:14ea]
           +-08.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Host Bridge [1022:14ea]
           +-08.1-[01]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Phoenix3 [1002:1900]
           |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix] [1002:1640]
           |            +-00.2  Advanced Micro Devices, Inc. [AMD] Phoenix CCP/PSP 3.0 Device [1022:15c7]
           |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device [1022:15b9]
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device [1022:15ba]
           |            +-00.5  Advanced Micro Devices, Inc. [AMD] Audio Coprocessor [1022:15e2]
           |            \-00.6  Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller [1022:15e3]
           +-08.2-[02]--+-00.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
           |            \-00.1  Advanced Micro Devices, Inc. [AMD] AMD IPU Device [1022:1502]
           +-08.3-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
           |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device [1022:15c0]
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device [1022:15c1]
           |            \-00.5  Advanced Micro Devices, Inc. [AMD] Pink Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b]
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e]
           +-18.0  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 0 [1022:14f0]
           +-18.1  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 1 [1022:14f1]
           +-18.2  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 2 [1022:14f2]
           +-18.3  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 3 [1022:14f3]
           +-18.4  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 4 [1022:14f4]
           +-18.5  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 5 [1022:14f5]
           +-18.6  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 6 [1022:14f6]
           \-18.7  Advanced Micro Devices, Inc. [AMD] Phoenix Data Fabric; Function 7 [1022:14f7]

What I can still do cheaply
---------------------------

I deliberately left amd_smn_debugfs_enable=1 on the command line, so
more SMN reads cost me nothing -- no reboot, no maintenance window. If
you want further registers, or the same ones under different
conditions, just send the list.

I can also still run any boot parameter combination (amd_iommu=pgtbl_v2,
iommu.forcedac=1, iommu=pt), older kernels from the Proxmox archive, a
custom kernel with a debug patch, or a long fio crc32c canary. The one
constraint I mentioned before still applies: this is a live NAS and the
ASM1166 carries real data including a Ceph OSD, so anything that
re-enables the IOMMU needs a scheduled window with the filesystems
unmounted, and I would write the canary first through the path I know
is good.

Still not something I can offer: no JMicron JMB582/585, no Intel or ARM
IOMMU machine, and no SATA controller other than this ASM1166.

A note for John Smith, added to Cc
----------------------------------

John -- I have added you because you are running the same machine I am,
and one of the readings above may be worth your attention.

You reported a TianBei WTR MAX with AMI BIOS 0.01 dated 2025-04-27,
revision 5.29, an ASM1166 with subsystem [1b21:2116], and IVHD EFR
0x246577efa2054ada. I checked each of those against this box today
rather than assuming, and every field matches.

The EFR needed a different route, which may be useful to you: with
amd_iommu=off there is no AMD-Vi line in dmesg to read it from, so I
took it from the IVRS ACPI table instead --

  od -An -tx1 /sys/firmware/acpi/tables/IVRS

parsing the IVHD type 11h/40h blocks, where the EFR image sits at offset
0x18. Both blocks give 0x246577efa2054ada, EFR2 0, with GIOSup (bit 48)
and GT (bit 4) set. That is a live reading from this machine, not the
figure quoted from my earlier mail.

The thing that stands out: of the thirteen registers above, twelve read
0x00000100 and one -- 0x111421d0 -- reads 0x00000000. From a single
machine I cannot tell whether that is ordinary for this board or
specific to my unit, and you are the only person I know of with an
identical one, so your numbers would be directly comparable to mine.

That is the whole reason for the Cc. No obligation, and no request
attached -- I just did not think it was right to sit on it without
telling you.

Alvin Lim
