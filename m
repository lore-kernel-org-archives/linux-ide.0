Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36134C70;
	Mon, 17 Feb 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739775772; cv=none; b=ujlGtydeIR6G6rLTTkGAo9ruGLJfVkEqCdYCLMQJX/JrBKNKOZMhP4fYIggRMzlrYpkKuVDSCyYHhJmqQ1W0C4YqlRrA9EhcwlwPS3J1WoZLCBe/KcWNhEzLy4YJy/v8O78GQUy0f5rBAWHiQ3deLEIGvAp/m9hOY+H+jhppFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739775772; c=relaxed/simple;
	bh=CnMACyq8fVyIC6o/qW1rsSrblNpgU9XLuyA5xGMStqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtM0aiPF9juWN1JqxoEBPh73aFJ7g4eh62KvQrVdhOTbOvIdlSheG2n6LT2OInOLeFD3cgpCNpyBEBgmfkZ2b8viGUF5/2NbOoMRSw7I8wrpY/57rwadAIWhcFl6uoLsgi0cJVwCaruTlmLliGtUUD9x6lTXZyOkQXMb2oUCqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qPK+yJh3; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qPK+yJh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739775724;
	bh=tEaf1fdlKHQ41IMwoFr6kAyWu7BQC3uaiiT0Z+Tp1vk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qPK+yJh3VI328ujJERmfE0AbHl0xq7idc6Cu/wtEllCf+vaueYRadZsV/agWa4on4
	 PmsR/hK3LQsjw9s5zOn/8js02rsCa9ppghL16ar2Lg5mw7fy6m1enVuVlQ7slPQOs2
	 dTGS52qt1hGJ8GQk5A+oWbr5KwHq2CcFDHa6SBBY=
X-QQ-mid: bizesmtpip3t1739775691t5lavpw
X-QQ-Originating-IP: TBtoORpur2h6g4UaoSd3UoAbLMVGet+CdXOJtAvKbqw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Feb 2025 15:01:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6567153048782771633
From: WangYuli <wangyuli@uniontech.com>
To: cassel@kernel.org
Cc: chenhuacai@kernel.org,
	chenhuacai@loongson.cn,
	dlemoal@kernel.org,
	jiaxun.yang@flygoat.com,
	kernel@xen0n.name,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	Jie Fan <fanjie@uniontech.com>,
	Erpeng Xu <xuerpeng@uniontech.com>
Subject: Re: Re: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
Date: Mon, 17 Feb 2025 15:01:20 +0800
Message-ID: <36B40EDC960C005C+20250217070120.666907-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Zt6l6DVeDGzb5W7N@ryzen.lan>
References: <Zt6l6DVeDGzb5W7N@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ob+TdET2B71e5ulmgkXCW/ALvBh1Qk50Fw2/F7D0yEfDpn7hXosZRLzi
	aWC5Ga/PoseFquZrV/AeJTJYlnZPJNDae1z6DRTewKSkQYWz8FxxMU0bnGjp3atFGVqsi5g
	tJF7LjZ1ncLl40hE3JJk7O6mW2mreplYRCSshyHo5o3C7Pe6qJZwFzB9wfZS09hDNOwsxqk
	iL6tvLgEe5eamt6bahbeFobaVo0qx4UVM1g0VGjRFB//nwoAIgoap7oetkDLBvk+NAy5erF
	h/DGW2iD7nduCe2PF5nT7hQN+AWc0pgOrAhqYb+/sJhHeiwZdkzINbcRl0/Dt03GahqnuyZ
	N80S5+zwgWoOsYxEXOsqNCgg1hmYnRuEVtJOv9GXZ4aQSmJTDyavaBLANITyBi0d9YOK3sx
	rypBHIFoF2DYPYQBfL4omu6bEeyXYclAFhMWx3WxhSZUFE2OC0W9RX7NKWgKs88kVv9tIVa
	sDWhYDull3GaoREvOtddWkitpLwG4/z25FhB62n+EKczOSVoJlinIzh6i9AkKM3656CCa7w
	eOGd9k5nbUOvBlJQ9adq+10VzU63CbznGhOPXpuTV4zxnAy2t5CSYJBjrMx2Y37Rpcl3LkN
	MP+owCu/aJ1QWfcusixGVNQfzlxyq5WAcwDtc+epJyrFaF/z7nC9OturBTLnArGRE+C4FTo
	aIcHEjmqzN8y3ACUN4Gj1h0E8mn2D5CsLnAnmXcNiVpxYcaP+uiWpj6bK/MYdZ6IEsB5bkU
	5NVp/kH5nC8pH9/tUfnDDsDssGBt36bWOdTbNguPeJ+GiFnXL43JKYGLzw9Y5v578arZGZA
	iS9yT7qGOBOSG+7CIaHmAeai/7cKS7rIxQqjZ/NhyiPKQGyNrBMoJd8ND/In1UJFLDSCIGz
	ENJ8tK1+8M/Kt7hgZ8u0Q+3/YqFUVytcwQsiuogPRnuiR9I4PRc9d34+b6sXysQef19oMfr
	vLz3z9ZQdvPNC6iMTxeHWbENPEityy79z0i8TWGZMi9gkMA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Reported-by: WangYuli <wangyuli@uniontech.com>

Hi all,

During testing, we observed that reading CDs on an INSPUR CE3000F desktop
computer (with a Phytium FT2000/4 processor [1]) running deepin 23 [2]
distribution is very slow, taking over a minute.

Further testing revealed that mounting the device from the command line is
fast.
  e.g., executing "time mount /dev/sr0 /mnt" returns a value of only 0.898s.

However, deepin's dde-file-manager reads more than just mounting when opening
the optical drive; it also reads disc information (such as capacity, etc.).

After using udisksctl to first mount and then unmount the disc to reset its
state, and then using the cd_sessions tool to read disc information, we used
strace to monitor system calls, testing commands are as follows:
  udisksctl mount -b /dev/sr0
  udisksctl unmount -b /dev/sr0
  strace -Ttt cd_sessions /dev/sr0
and found that openat was blocked for 42 seconds, and at this point, the
process had entered kernel space.

[1]. https://www.phytium.com.cn/homepage/production/6/
[2]. https://cdimage.deepin.com/releases/23/arm64/deepin-desktop-community-23-arm64.iso


TEST REPORT:

For this patch, before its introduction, with original system-integrated optical
drives capable of recognizing discs, the total execution time for cd_sessions was
92.4 seconds, including 31.6 seconds for openat and 60.6 seconds for ioctl.

With LITE-ON optical drives, under the same condition of disc recognition, the
total execution time for cd_sessions was 108.2 seconds, with openat taking 45.4
seconds and ioctl taking 62.9 seconds.

With RITEK optical drives, also when discs were recognizable, the total
cd_sessions execution time was 98.2 seconds, with openat at 36.7 seconds and ioctl
at 60.8 seconds.

After the patch was introduced, the time to read disc information (using cd_sessions)
with all optical drives was reduced to less than 0.5 seconds.

I've tried different pairings of optical drives and SATA controllers, and the test
results were consistent across the board. The Marvell 88SE9215 controller consistently
emerges as the source of the problem, no matter the optical drive tested.

Devices lists are as follow:


CD-ROM DRIVER LIST:
  1. original system-integrated optical drive
           *-cdrom
                description: DVD writer
                product: DVD A  DH16AFSH
                vendor: ATAPI
                physical id: 0
                bus info: scsi@2:0.0.0
                logical name: /dev/cdrom
                logical name: /dev/sr0
                version: DC2M
                capabilities: removable audio cd-r cd-rw dvd dvd-r
                configuration: ansiversion=5 status=ready
              *-medium
                   physical id: 0
                   logical name: /dev/cdrom
  2. a LITE-ON optical drive
           *-cdrom
                description: DVD writer
                product: DVD-RW DH16AFSH
                vendor: PLDS
                physical id: 0
                bus info: scsi@2:0.0.0
                logical name: /dev/cdrom
                logical name: /dev/sr0
                version: DL3M
                capabilities: removable audio cd-r cd-rw dvd dvd-r
                configuration: ansiversion=5 status=nodisc
  3. a RITEK optical drive
           *-cdrom
                description: DVD writer
                product: DH-16AFSH SUPDRV
                vendor: RIDATA
                physical id: 0
                bus info: scsi@2:0.0.0
                logical name: /dev/cdrom
                logical name: /dev/sr0
                version: NWDN
                capabilities: removable audio cd-r cd-rw dvd dvd-r
                configuration: ansiversion=5 status=nodisc


SATA Controllers LIST:
  1. INSPUR CE3000F
        *-sata
             description: SATA controller
             product: 88SE9215 PCIe 2.0 x1 4-port SATA 6 Gb/s Controller
             vendor: Marvell Technology Group Ltd.
             physical id: 0
             bus info: pci@0000:03:00.0
             logical name: scsi2
             logical name: scsi3
             version: 11
             width: 32 bits
             clock: 33MHz
             capabilities: sata pm msi pciexpress ahci_1.0 bus_master cap_list rom emulated
             configuration: driver=ahci latency=0
             resources: irq:43 ioport:2020(size=8) ioport:2030(size=4) ioport:2028(size=8) ioport:2034(size=4) ioport:2000(size=32) memory:58140000-581407ff memory:58100000-5813ffff
  2. Maxsun MS-WS W680 D4
             Hardware Class: storage
             Model: "Intel SATA controller"
             Vendor: pci 0x8086 "Intel Corporation"
             Device: pci 0x7ae2 
             Revision: 0x11
             Driver: "ahci"
             Driver Modules: "ahci"
             Memory Range: 0x82100000-0x82101fff (rw,non-prefetchable)
             Memory Range: 0x82102800-0x821028ff (rw,non-prefetchable)
             Memory Range: 0x82102000-0x821027ff (rw,non-prefetchable)
             IRQ: 166 (no events)
             Module Alias: "pci:v00008086d00007AE2sv00000000sd00000000bc01sc06i01"
             Driver Info #0:
               Driver Status: ahci is active
               Driver Activation Cmd: "modprobe ahci"
             Config Status: cfg=new, avail=yes, need=no, active=unknown


Tested-by: Jie Fan <fanjie@uniontech.com>
Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
Tested-by: WangYuli <wangyuli@uniontech.com>

Currently, due to the limited hardware I have access to, I'm unsure if this is a Marvell
88SE9215's specific issue or a general Marvell SATA controller problem.

So, I think it's reasonable to add a quirk to handle this for the Marvell 88SE9215 now.

Thanks,
--
WangYuli
