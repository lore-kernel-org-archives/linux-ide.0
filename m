Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA033998
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788630552; cv=pass; b=WC55ssyROQXJ74p/oTi+HYNHgavzqne2vxWAj4XdlIhYf1ENycyqyRUww5Ejjka7LGWqfQwG0doxFT4JYE/DcMiN9FCpEHR2z+jt0+A2B3yAh63rmyu2pWBfafmCKp5wVnYoGVWEc4TNTMCpHUb7kvCKmYcXIC+REQ3y+ZzUUL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788630552; c=relaxed/simple;
	bh=3LyyokutBxcAjfcGRumvVjoScViISOI7AqKTnE+qbTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fG1g7mTe+zdyESKnDe/FStu2dODZDsC3TwQ+R9VIUamjCQ9R9Is1KBAHSEqcSGy3nLcWSewjgRztxuOnunGwwXJSnTWSW5nRAIF7GehdAzupSJJiXyWnHfcItwj4i9gXijhhECvarmlOs0ycUFxSwUIFAZ4TbTjRjX/c+ZzdXfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USg/EQaq; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USg/EQaq"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a468f4c547so6194571fa.0
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 10:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788630548; cv=none;
        d=google.com; s=arc-20260327;
        b=OK/EOsU11vDdJjej9PiHR0VmJS/5MmRRig3uHOkbhQmztooSNOm7RKOAM5mX/Non2w
         uBcssS5tYoEcyZ4/Izf6/GQO88uAUGieMc6i+CsjwwVTYCobH8yX8O4Xda1qxNuNMYsS
         BZPrbw1valwXYgdzdr79qL1u9a1zegM/R0Z6EP4BxLTKIIS8WcDCedFMgwdXgj8D7S9F
         7ry0nB0okrStTaEK8K7yHJNE2icnSSK1mSSy7EE40T/MdskQDX7QZnspDNhVhXRzE5R/
         f2Ma5Qhh2f0IJoF/ao6OK7UuSnXn71/mC0B+gn2jevLetSXCr50XkzHsMBVn3/jisL7h
         VpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        fh=yWZo4es5zoZ7kHtDHJ2TmkE8gzjRr0wtXET0a7oso6E=;
        b=I3j8ups//BKJ+9OjabVlrmIgeE3O3ekvvnkGFyIi+5duDalMpF2Qht7p7lfS8o11Tm
         1Wqgyk6A8LvY0/cNP0+aHOI5+cCPE4I8qOPT9AjCeu5me7RxF4Soal8wdQVKJ+V/SfYs
         SUdCXVt8by0I7pyE0Jef6D76R0/P7oZK1BLfVLNPZJ4zN5pJ+UhUEOAfnGb1zfiyr1HN
         4pam3PV7if9rni8EuFByiV9+vvZlWCVMS0iWvpKcqyeOH1pvEiH5n3O1eH5+yf3i8uJw
         cYWs3iHMxjDyrSa7vN6tlvA9GvLjOCYmhX701CITfkrNv/MRXuyuZC/dQVunnlQ/LBzX
         SiCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788630548; x=1789235348; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        b=USg/EQaqOSZA9QFtWSuAPi+GSUJpzKyt95f4hphJ752CmBgdDUEsFuq9M3azXu1ms3
         ziZJ3Qkitxdbx4ET9UhiCEwaKvFobD8kQrOu7eJb/ZrNYceSVgHMpUPefCnKwVCDD6nf
         E8LaptyTDOccxVGWniCHE3T1VAEdRcU3tjpH1O6gusKAwgc7MB+YPK1LVq3qRs4/lz4l
         PhG5W4X83qVvC5cOcc5xEWlyDDmRSwnK7jOWbDGq3+LUmP0Dlb4ANUMTWfFqxXNq/+H9
         9RxaUWjSH0azlzIXZWGqMGZVD6vgDLWfxpjG8qbqaraqgyc3e26R4RdGtkpt4glIVeA1
         /Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788630548; x=1789235348;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w3+5gfKK+1zlUjdiuSCjWDIkfjdLdSqOfUHivha/O9M=;
        b=j4IOh1bHgfcnL4Iu9POpH+hD4rGHjd+huDxTANyuMtaOzQLz+Vw3He4yxUzZiGaxQu
         jwK8DfapLmWYSmaiLZcyEDsChjkz7tEKkn/rkmBhW+z3bjOEESzBraMkC4Xov6lyo4Km
         4xxhJsbXmLP5MDcC84pBia1s8cFd5yzWkLyci2rjUnF5iBkTIVtq7AHoISbCqM8P7CtF
         hfiJtFElmP2wRlQiXIHt0mJw746pghMHLX+MEHpevLT022HnsJB/ggJy1rYySPqYa2Fj
         nz5FF1QCQalC5yHwo0LBqm/oDVjtdNHrEqnaFLgms30QdY2SoSwAenamD+Sr/4mlFDZp
         Y7TQ==
X-Gm-Message-State: AFuF++kP9OUyd069u2zjVEVXhZazFcNatmMtpECuLURqYggXgI8KT3k1
	lSgiXeGk+hoU21O4ghQFW6D7FOJkiFPLwh1TRhztTgsqWnFj8ta0k8kIHpG2qdvsDt43N5QwZgo
	HqHBqDAqULrsG4Ln3qKY0me9xNYTBXqNXiBKP
X-Gm-Gg: AYBFou0jiTMSe1Q+qpyAWjYtkXKdFuCN7HVgMPXDJYs4MnUzRwEz/68MxIX27i/SsyT
	gb176YnMMJ7AEdsFlCvFe3FmzoKH+rHhW2X6Va1mcRsS2o10x9Nn0cmSYvPcDJmMbLQQymVGh0g
	kjM3Ypo5VlojjPm5y9zmb3fwpwSaSrrrzkQC/74GILBWPbtXL6KzBMU+9xwdFeKyjX5y7Pu4J0y
	CFTLLNxGMFCDsoex9yyfQcdTMVMv8O9WfTP2ZhS7wdFxtx6EFolO6RzLlM+2fz8aYQoeTwoumR9
	5YLxebapK7z9WcUfAIIxsKLhHLRNmjWT+9o59Qb9j/xFMBLQIrGceVffAfnUKuXXDuv7XYBXbE1
	+2l2srA6ayGsjEUPRPO6tEIgi
X-Received: by 2002:a05:651c:43cc:20b0:3a3:1391:fb19 with SMTP id
 38308e7fff4ca-3a371bb39e7mr11104281fa.9.1788630548430; Sat, 05 Sep 2026
 10:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Smith <imjohnsmith4000@gmail.com>
Date: Sat, 5 Sep 2026 20:48:56 +0300
X-Gm-Features: AcwNN1Xu-VurMgpls7HqOcG3u1WJMxdYGE5yaeczLyplTxIcSs8C8GkSUdfXWtc
Message-ID: <CAJ_jo9SD9UqRQe6UGcXAZjU8CbYzQwnwrz=muGd1HaAPGT-jYw@mail.gmail.com>
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
To: linux-ide@vger.kernel.org
Cc: mikael1022bzh@gmail.com, mario.limonciello@amd.com, cassel@kernel.org, 
	dlemoal@kernel.org, vasant.hegde@amd.com, alvinwylim@gmail.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

another data point for this thread, from a third platform: the same
"Using 64-bit DMA addresses" trigger, the same silent zero reads, and
the same cure (identity mapping). It adds one detail that may be useful:
the size boundary of the corruption matches the IOVA rcache limit
exactly.

Platform
--------
  Board:   AOOSTAR WTR MAX (DMI: TianBei "WTR MAX"), AMI BIOS 0.01,
           release date 2025-04-27, BIOS revision 5.29
  CPU:     AMD Ryzen 7 PRO 8845HS (family 25 model 117 stepping 2)
  RAM:     32 GB (30 GiB usable; highest System RAM at 0x83E2FFFFF)
  SATA:    ASMedia ASM1166 [1b21:1166] rev 02, subsystem [1b21:2116],
           PCIe 8GT/s x2; the only SATA controller on the board;
           two 4 TB HDDs attached
  Kernel:  7.0.14-11-pve (Proxmox VE, Ubuntu-derived 7.0)
  IOMMU:   "iommu: Default domain type: Translated",
           "DMA domain TLB invalidation policy: lazy mode",
           "AMD-Vi: Using global IVHD EFR:0x246577efa2054ada, EFR2:0x0"
           (v1 page tables in use; EFR bit 48 GIOSup is set)
  No VFIO / device assignment, no untrusted PCI devices.

What happened
-------------
Three incidents in 12 days on one uptime (booted 2026-08-24). Each was
preceded by exactly one kernel line for the SATA controller, with
nothing else logged in the surrounding minutes:

  2026-08-25T07:56:41+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses
  2026-08-31T23:23:59+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses
  2026-09-05T03:01:27+03:00 ahci 0000:67:00.0: Using 64-bit DMA addresses

First symptom afterwards (ext4 "iget: checksum invalid", files that look
corrupt, or the write/read canary failing): 2 h 05 min, 12 min and 3 min
later respectively. No AMD-Vi IO_PAGE_FAULT or any other AMD-Vi event at
any point, no ATA errors, SMART clean, AER counters zero.

The line appeared three times because the device was re-probed twice in
between (manual "echo 1 > remove; echo 1 > rescan" on 08-26 and again on
09-01), which re-arms pci_32bit_workaround. Each re-probe made the
problem disappear for 4 to 6 days.

Measurements while faulted (2026-09-05, ~11:00 +03)
---------------------------------------------------
  * 4 KiB O_DIRECT reads of the GPT header / ext4 superblock: correct.
  * 1 MiB and 8 MiB O_DIRECT reads at several offsets on BOTH drives:
    all bytes zero, identical and repeatable
    (md5 of an 8 MiB read == md5 of 8 MiB of zeros, 96995b58...).
  * 1 MiB from /dev/urandom -> cp onto the ext4 fs -> sync -> O_DIRECT
    read back: 0 of 1048576 bytes non-zero, 3 of 3 attempts.
  * After the fix all of the above return correct data, and everything
    that had been WRITTEN during the fault window (20,519 video
    segments, 47.8 GB, plus the ext4 metadata) verified intact. So on
    this platform only device-to-memory transfers went wrong;
    memory-to-device transfers landed correctly.
  * On 08-26, files that "went bad" had zero-filled holes starting at a
    uniform ~128-160 KB offset.

The 128 KiB boundary is IOVA_RANGE_CACHE_MAX_SIZE: allocations up to
32 pages keep getting recycled low IOVAs from the rcache, larger ones
hit the rbtree and, after the flip, get IOVAs at the top of the 64-bit
range. That is why a small-read health check stays green while every
large transfer is garbage.

Fix / current state
-------------------
  * Live: unbound ahci, "echo identity > /sys/kernel/iommu_groups/26/type"
    (the group holds only the ASM1166), rebound: correct data at once.
  * Persistent: iommu=pt on the kernel command line, rebooted
    2026-09-05 16:02 +03. Clean so far; a 1 MiB write/read canary runs
    every 5 minutes and the machine alerts on any new "Using 64-bit DMA"
    line. I will follow up if it recurs.
  * amd_iommu=pgtbl_v2 not tested here. Note that this 8845HS advertises
    GIOSup (EFR bit 48 = 1), so v2 page tables should be selectable on
    this platform, contrary to what was reported earlier for the 8845HS.
  * Not related to the ASM106x 43-bit limitation: the ASM1166 handled
    32-bit IOVAs for 12 days of heavy I/O, and handles physical
    addresses up to 2^36 under identity mapping without issue.

Happy to run the fio verify canary with iommu.forcedac=1, and/or
amd_iommu=pgtbl_v2 iommu.forcedac=1, or to provide lspci -vvv / SMN
register dumps, if that helps.

Thanks,
John Smith
