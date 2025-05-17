Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B4188006;
	Sat, 17 May 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747505927; cv=none; b=GpY/CrSG32mUWExbQotAnCyiVzxmo+5ydTI7kUctoPr6zsxugymm8+R1T9B+Tj/E5JvtSotwFQfrwzYnRd03URwBs193EZ383l8Vr2wed7prGXZnB2VG9GSr6sKsEZzGTdIj7ZJxXuUVxwc7jw26hTXp35nOYfNphE7djOU1ilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747505927; c=relaxed/simple;
	bh=Pp6tXXx+lNG4yaP/EfxqA4XweQ6S4PG9HoQ/41NHE1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=n1pq2NkBbjjhcG12RmdI1dWYgW1LW/vNYUAJ+d6gs1UxIsvH1q2qZ8xCgaLEVjQ9w8XWbBnSy3F4nDtf4sqL3kKQagKLMb3OFFn4qD/bWnQuQeL+u9YCJbfrBHcKmXnd4Nhx92XdDRoIfN4O6TCpFgShnGpvmERiMnVWirxM6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llFGj0ND; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llFGj0ND"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5241abb9761so1121540e0c.1;
        Sat, 17 May 2025 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747505925; x=1748110725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8NB9jhbC6rdOs6uM+OwPkI7Yew3X60lL3ammPMJAlE=;
        b=llFGj0ND05yv3hnPQKTYkSmJFB6VKm1XqOUmkfLPBqWuEuYsKDaxXrZorfVUh3At92
         nYkEPX677WvoXe+xKD0lioOf9eSZ9Gtn1WZlERNj3IHmO3TpPk9VoCrpDiBhxePd5MGO
         QMbPeWvYGqtYRwEuAfGJXnniDD1Iuv76Qmqq5dUL43KBBs1PXNOwIN0dfNT87SPNum1P
         f7j3W0qNGeVepf85Tq1eORvsm3/2bkMwhAyNtn5T/6y8bofxaaSq7+P+QrnutSR+pYxZ
         tPH9z4rxqSMY4IR5V7Z9eV3pG0R5doRRSF7QrkSfJX4AuTxPM/BlVCk8Dc0zRg0bampS
         tqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747505925; x=1748110725;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8NB9jhbC6rdOs6uM+OwPkI7Yew3X60lL3ammPMJAlE=;
        b=PAfzvCM9Wq/rFbIAZxO+Z7rvZWVruxOVttXUy8/FCR3GpI9v1yJxtx7nJl7jlsV7ef
         fA4jqA735GYAF6NGugQYvefyNDlnzHIH0xA3KdnRg/r+neo8dVkVruTxxGRmklUlpr3f
         fbrqiq+mvC8jFVYAoh038vn68Fg1BfUv0/pbMWLQ0swmRWITGhuXhLTE4gcaj6wcr+Oi
         iDO463MAkKNT7rYGR15C1fVQQSxpAJBcGaV+Nyr8L8xCGWNFluI2JsuRGeIKUaE5eBCI
         IKYnXHDZ1u/7GnY/SdrwRmI5v4Smu6WoH4+t+4ivHG2G0WB0+9ObuFTuxFIbH3w6+9Tg
         OseQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqnUMYSSyG+xyzCyhO7cho8mZPu+5iw7G31uPbwNFImrcCXS2CGdd3+Y4Yi1xnSMmnqkC/8e18KzHO1eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYbWlfKr59jMU/AAX0sIWpz4i4r/0ujIzGh+mxD893TFJ0x9c
	CurQ4HB0ov/KSsYwAxNwseNYGTgJjQmP76FEg3KApQz981gpOATA3+Zb0MFPqJDFlN78FC5RjxJ
	oJz1flw7Jzl/0WM4IxSlFG4NOTmw2bLVD0Q8MBxBfFA==
X-Gm-Gg: ASbGnctebD/rbtjYnaXPUtIH7t1koJtmKsce8ZA7lSoOaV/toTl0wltoAO1VrlK1UZ2
	txXJ6MMrYk3T8QKMN2+c/yFe1oKtsEv4VvGejll8JVPTfLR5FPg6pheSTmQiW8Ivbf665M+mhZT
	NvTFIMy3PJfvUvB6yFpW8sweGczkiAfwHDv3n1vIeaPm9AO8kwGv/mRZ/wtMT7+n1I4w==
X-Google-Smtp-Source: AGHT+IGVRF8w8Iv7zvQQYZOxVZMx8tzMvrSzv6dxW/JM7KhmJhOqhMFCJ+o/9fVM5VNXlbMYE1BAb0VAwMUbX/p00Vk=
X-Received: by 2002:a05:6122:490a:b0:52b:789:cf93 with SMTP id
 71dfb90a1353d-52dba88b0f2mr7592772e0c.5.1747505924681; Sat, 17 May 2025
 11:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joj Loj3 <jojloj3@gmail.com>
Date: Sat, 17 May 2025 14:18:33 -0400
X-Gm-Features: AX0GCFuZo9RenNhsd61ikKraNIif5h493QtzNWzVKwpSzCLKR8YMoR_TqB2TuHw
Message-ID: <CAOnE0bQBVS2hz9Mbv+HFLSYUiuTcJJ=A6UqVrhP8Sgf_muMaCg@mail.gmail.com>
Subject: [BUG] pata_jmicron - JMB368-based IDE to PCIe adapters capped at
 extremely slow speeds
To: dlemoal@kernel.org, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies for the previous email, which was not formatted as
plaintext. I have fixed this for this email.

Dear Maintainers,

Tested on several kernels, including the latest master at time of
testing ( 6.15.0-0.rc5.250509g9c69f8884904.47.fc43.x86_64 ),
JMB368-based IDE to PCIe adapters are capped at extremely slow speeds,
regardless of whether the device attached is capable of much higher
ones. This issue exists OOTB on Windows as well, but is fixed via
installing the proper drivers, see
http://forum.redump.org/topic/59287/fix-for-pex2ide-jmicron-36x-based-pci-adapters-on-windows-1011/
for more information. I have tested Windows on the same machine and
confirmed that the issue is fixed once I have installed the proper
drivers.

Please let me know what additional info is necessary. This is my first
time submitting a kernel bug, and I'm not sure what extra information
might be needed.

Cheers,
Bestest

Specific adapter purchased:
https://www.amazon.com/dp/B000YAX13Y

Quote of the above forum post, if necessary:
A handful of dumpers have been having issues specifically with the
StarTech board you can grab on Amazon for a bit over $20 - this has a
JMB368 controller, but it "should" apply to any given PEX2IDE adapter.
Specifically - the adapter seems to be very compatible with any given
IDE optical drive you throw at it, but the read/write speeds are
"very" poor, similar to PIO4 mode speeds or as if the drive is
perpetually stuck in a 2x CD-ROM read speed average regardless of
parameters used.

Additionally, I had minor stability issues on my setup using a 12th
gen Intel CPU/motherboard that also seem to be caused by how this card
operates in Windows by default when dumping discs - this also seems to
fix those issues if you've had any issues on that end.

The "fix" is just manually replacing the generic "Standard Dual
Channel IDE Controller" you'll have appear in device manager with an
official driver from 2009 (1.17.49.4) - extract the files from the
linked cab archive (direct from Microsoft Update Catalog, it's
signed/legit etc.) to any given dir and manually update the driver by
pathing to the folder with the cat/inf/sys files.

https://www.catalog.update.microsoft.com/Search.aspx?q=jmb36x

The entire set of drivers can be found here - since MS doesn't denote
what version or x86/x64 variation as is, here are the relevant x64 and
x86 drivers:

x64: www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=65fceaa7-e6b6-4aac-8846-37b4ca469c5d
x86: www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=9ca80e2c-4391-4e75-8353-af41ef10a5c5

The newer drivers seemingly either fail to install (Device already has
best available drivers installed) or simply fails outright. This
specific revision for whatever reason replaces the generic one without
issue and works as expected. If you want to poke at the later
versions, be my guest!


Output of uname -r on latest kernel:

$ uname -r
6.15.0-0.rc5.250509g9c69f8884904.47.fc43.x86_64

Output from lspci -v:
03:00.0 IDE interface: JMicron Technology Corp. JMB368 IDE controller
(prog-if 85 [PCI native mode-only controller, supports bus mastering])
    Subsystem: JMicron Technology Corp. JMB368 IDE controller
    Physical Slot: 1
    Flags: bus master, fast devsel, latency 0, IRQ 28
    I/O ports at d010 [size=8]
    I/O ports at d020 [size=4]
    I/O ports at d018 [size=8]
    I/O ports at d024 [size=4]
    I/O ports at d000 [size=16]
    Expansion ROM at ee100000 [virtual] [disabled] [size=64K]
    Capabilities: [68] Power Management version 2
    Capabilities: [50] Express Legacy Endpoint, IntMsgNum 1
    Capabilities: [70] MSI: Enable- Count=1/1 Maskable- 64bit-
    Kernel driver in use: pata_jmicron
    Kernel modules: pata_jmicron, pata_acpi, ata_generic

Relevant output from dmesg:
[    3.155555] scsi host6: pata_jmicron
[    3.159374] scsi host7: pata_jmicron
[    3.159457] ata7: PATA max UDMA/100 cmd 0xd010 ctl 0xd020 bmdma
0xd000 irq 28 lpm-pol 0
[    3.159461] ata8: PATA max UDMA/100 cmd 0xd018 ctl 0xd024 bmdma
0xd008 irq 28 lpm-pol 0
[    3.204963] FDC 0 is a post-1991 82077
[    3.229154] usb-storage 1-3:1.0: USB Mass Storage device detected
[    3.230081] scsi host8: usb-storage 1-3:1.0
[    3.230253] usbcore: registered new interface driver usb-storage
[    3.234360] tg3 0000:01:00.0 eth0: Tigon3 [partno(BCM95754) rev
5784100] (PCI Express) MAC address 2c:27:d7:2d:99:f4
[    3.234367] tg3 0000:01:00.0 eth0: attached PHY is 5784
(10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[    3.234370] tg3 0000:01:00.0 eth0: RXcsums[1] LinkChgREG[0]
MIirq[0] ASF[0] TSOcap[1]
[    3.234373] tg3 0000:01:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[    3.315037] ata7.00: ATAPI: PLEXTOR DVDR   PX-716A, 1.11, max UDMA/66
[    3.319542] scsi 6:0:0:0: CD-ROM            PLEXTOR  DVDR   PX-716A
  1.11 PQ: 0 ANSI: 5
[    3.362459] sr 6:0:0:0: [sr1] scsi3-mmc drive: 40x/40x writer cd/rw
xa/form2 cdda tray
[    3.389254] sr 6:0:0:0: Attached scsi CD-ROM sr1
[    3.389402] sr 6:0:0:0: Attached scsi generic sg2 type 5
