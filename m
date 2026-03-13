Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0022FAC14
	for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365944; cv=pass; b=CJz+6VBktKx1kXD4EahItxt5WCVDqFVs1gGsjbU97eurdma7QsZ6S3p7hk1k/0xXC82q3Bh9/zNUdw6K/RoDO/25ppSxchG0FhmuCMm84SPQe1IrVP2qKv33N8nj4V/IjzFUSJYJTwArVOGa1yR+YR8UeChqRIcsaFmhmcijsJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365944; c=relaxed/simple;
	bh=Ht2d7CFTTs7mAWjwCE0C7F6caiT2erH1PFwDT0TIQCg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ba9NT8gb9lJXI7YiyyINc2YI5FvJ14FRJaNxlG23vo0vvXRfQ95rcbcIIJ+TtsaZZUuzUDSibgEpfV5ej0e7twXtGZL8MSAVm0i+uiYz5lnvZEjMt/Yz1/zU94EseLTGnCs5A5E/hSf8cy7Gma44KIGzEFKpunI7YiA4SPbQ4IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2RbATeu; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2RbATeu"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a07f66f4eso20671096d6.1
        for <linux-ide@vger.kernel.org>; Thu, 12 Mar 2026 18:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773365941; cv=none;
        d=google.com; s=arc-20240605;
        b=Hi8Kwga7x13YvP+c9amUmb5a3Njy9Nr2jbro5iKVWhFTfs0lOXxm1xnXPG4xNu6db1
         fdFoDue2EMyZc5RPJBx+hKvVe1J3gB9Da8vrQ1OhMbytCTPmx0CSnstMev3RuWHU3dMR
         lzEZg1UtAR9sArso0IjmngcYirubBFpoDAb1bkzyW1rCTycVjsl8SAK3L0UgmwRBfojN
         3rd/Ly238WjnGYWKBH1kj6UXDIPCdg/t6NrwTr6TwVIvklQjxvwWwVSBbEbZowRht9Pp
         y1Qsnzxg11wzgpe9nxOaIAV5q1oxOspXq2t0y7hr7RSJTfTg8VpFhn0FbWjJJ6FJjK3e
         WdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xhfj8XE6l6QHlbFHbhZHwxe9uvsRSgjKWFC06amrVLs=;
        fh=PRjkr8nF8wJB4mhzE6exA+LRz3JJpxFjdy74u2WsgZA=;
        b=lG9CHzEWsY9W+leHfsqDadIu1S+MYakzYcF0q7IhMYG+Flh6KPUes2LWWPLwKB29He
         Z1VXRRf8xW/vUKhDmhvt502HN3p6+RebG/WKQgIr0rT8UABYdcWYpMG5OWdFSguG2A1c
         QTdvku2jvxhR4iK6YV4OedL/MIFg830n9tsJelP/lL/7fI6Ly6U758kBnA+4TVFhjM+T
         ct3zwOK5BGwZS2VowXQHN2zzsjPbu4z8Qjk231kt+LjC+1ieJ5Zt8Vq/XuRGeLDPph8U
         I1iChbk6eQidfdi47oHWJVmMSYxsXoXqEAyxE1Fyakr8wCWh9LOIRFM4ByRonj6uh05R
         v0Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773365941; x=1773970741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xhfj8XE6l6QHlbFHbhZHwxe9uvsRSgjKWFC06amrVLs=;
        b=F2RbATeurfhG91phfBl+n6DIn+t2DQRFVOTQUlH+SAOmpFk99BxNR74gAzzEL879Jb
         y4zHqqv376G2/HsXd7MGjUlwgazn4sASxnY8Ef/CXIz6fSuaiTd6xVy9SNKV2GlMhZId
         3RkU3+pXRAESG6dDDvvn9p7nagdrne51UpxK+0Rv8vOXDnyavKGH4c1ou4mhLpT1hVTo
         WPY3c7kZehcm0+kCrKKpK7tKeRS0171mqVHLkV6WxLetHdSbD1uGzQQwAWATK80jVUal
         pYVcDnaCMoAVBM9w4FmniYqCOvafTibXcK1bpO1JjU40ihEOFWvmCg45s4gkyvzl4nph
         +cfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773365941; x=1773970741;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhfj8XE6l6QHlbFHbhZHwxe9uvsRSgjKWFC06amrVLs=;
        b=XVYyoxgbfR/kTNXc9VU3FzQRJclq6YgTITsksqS4XNh9OOqq2yemg9eNrOwUhx/C78
         snKXzqyhSw55rtdwtzNievv0JazRPeOPgnkvaW4zKE1THTNmn23uXrAUTwFL5ai+CgMf
         nhiuCbzSdgZhZHFrfjDqUeLdf8jzctL+hBAZ1tyNEB63BZPXNxsmGoiFRHdWG1HcqoKf
         a19XwBMjmzttvbLI2peV46In+z7EemLuZ0/EjeNAZBglgQiuxvxZxZwpl3TjSDBcXDhv
         g2L51DGzUQkwFT+XFpQHO3ZQy2Gr6A0wzZBz5Njne+Rm2VMC75Z+HOKQQzHCrg0EWdgX
         T18g==
X-Gm-Message-State: AOJu0YzbTcm9lg04crCkfNuuOQkrffyULZu/d1YLcFVo2zn3MxHo3dWw
	cl4ugVx4+Gn6CFm3bF+v6zw8SyDdvmAypZutUVqliMjrOSTDSYi35j5odwyUCwr1Jpyuw3Y8Dht
	jkbOmSXLq7/vH0AcziEoXKmNj3ODzU9eMQBHkn9w=
X-Gm-Gg: ATEYQzwK3TFkigW6MjFWM0cKYevhjfqlP9DkjfYPhOBifwW/ySJE55140YQwRbaBh5r
	rotAtWoBgFnaFrYPtwmnV3+q7KJ7hyVnEv0JBWsZuqMDh6Sf+PHrhh83uJwlmICWoWC2Ufmos3M
	qqosh1FwfbeRGCZZFb/RlB80Ti+RqoQfyPUAhGsPXwKI+qNF/drn5GJEH4/21BY23pe7jOl8kZl
	xz3Y3bJbIltd12+7uzUPdDteoPBh+gj04GrYKLJv9f5xn7Sr0SRvtLJ82h9AqmBWi+gc5cmGUyj
	GaLIwwCSMRbc8JqW7eseIPn05nvrK/pU6rEnZAIA9nhbnG67ZsAfFwl+4ovhfvKXpNkK8S6N34u
	lxVUky3DW4J+ZMRBcM8A3DBVSwu0p5hGE1xhf
X-Received: by 2002:a05:6214:da3:b0:895:4b25:4a18 with SMTP id
 6a1803df08f44-89a81ea6ad3mr27140066d6.34.1773365941052; Thu, 12 Mar 2026
 18:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Date: Fri, 13 Mar 2026 03:38:50 +0200
X-Gm-Features: AaiRm51WeDBa6ejokDgn2EJ673eZKN5qxBTCNWi5CWXTUhLDZVWWxeDsNL0MrWA
Message-ID: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
Subject: [BUG] libata/AHCI: ADATA SU680 on Dell Vostro 15 3510 shows repeated
 FPDMA timeouts, ATA bus errors, hard link resets, GPT/metadata instability,
 and SMART reset-counter inflation unless link power management is forced to max_performance
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

A reproducible storage issue has been observed on a Dell Vostro 15
3510 using an ADATA SU680 1TB SATA SSD as the Ubuntu/Linux system
disk.

Hardware / environment:
- Laptop: Dell Vostro 15 3510
- Affected disk: ADATA SU680 1TB SATA SSD
- Firmware: VE1R910D
- Linux block device: /dev/sda
- Windows installed separately on NVMe
- Ubuntu installed on the ADATA SATA SSD

Observed behavior under Ubuntu/Linux:
- repeated libata/AHCI failures across multiple boots
- WRITE/READ FPDMA QUEUED failures
- Emask 0x4 (timeout) and Emask 0x10 (ATA bus error)
- irq_stat 0x08000000, interface fatal error
- SError: { PHYRdyChg CommWake }
- SError: { UnrecovData CommWake Handshk }
- ata1: hard resetting link
- Sense Key : Aborted Command
- transient I/O errors on /dev/sda
- SMART Power_Cycle_Count / Lifetime Power-On Resets increasing during
normal Linux runtime without real reboot/shutdown
- initial symptom was apparent GPT/partition-table
unreadability/corruption on the ADATA SATA SSD, which caused the
machine to skip the GRUB menu and boot directly into Windows 11; in
Windows, the SATA disk appeared as if its GPT/partition metadata might
require initialization
- broader runtime effects including slow OS behavior, temporary
hangs/freezes, and application instability

Important SMART findings:
- overall health PASSED
- Reallocated_Sector_Ct = 0
- Reported_Uncorrect = 0
- UDMA_CRC_Error_Count = 0
- Available_Reservd_Space = 100
- Percentage Used Endurance Indicator = 0
- SMART error log empty

Additional validation:
- full raw-device read completed successfully
- later extended SMART self-test completed without error once the
workaround below was applied
- GPT was restored successfully from the backup GPT/header

Critical workaround:
Setting all AHCI hosts to max_performance immediately stopped the
abnormal runtime reset-counter growth:

for f in /sys/class/scsi_host/host*/link_power_management_policy; do
  echo max_performance | sudo tee "$f"
done

Before the workaround, the observed Linux SATA power-related state was:
- /sys/class/scsi_host/host0/link_power_management_policy:
min_power_with_partial
- /sys/class/scsi_host/host1/link_power_management_policy:
min_power_with_partial
- /sys/class/block/sda/device/power/control: on

After forcing max_performance:
- SMART reset/power counter stabilized immediately
- later long boots were clean
- extended SMART self-test passed
- system stability improved significantly

This strongly suggests an ALPM / DIPM / AHCI / libata interaction or
incompatibility with this SSD/platform combination rather than classic
SSD media failure.

Representative affected log patterns included:
- failed command: WRITE FPDMA QUEUED
- failed command: READ FPDMA QUEUED
- Emask 0x4 (timeout)
- Emask 0x10 (ATA bus error)
- ata1: hard resetting link
- Sense Key : Aborted Command
- I/O error, dev sda, sector ...

The issue was recurrent across multiple boots before the workaround
and disappeared across later long boots after forcing max_performance.

Ubuntu Launchpad bug:
https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.17/+bug/2144060

Ubuntu community discussion:
https://discourse.ubuntu.com/t/adata-su680-ssd-on-dell-vostro-15-3510-shows-repeated-sata-resets-gpt-metadata-instability-smart-reset-counter-inflation-freezes-and-i-o-errors-under-ubuntu-until-link-power-management-is-forced-to-max-performance/78396

If needed, additional logs can be provided or retests can be performed
against suggested settings/kernels.

Regards,
Mohammad-Khaled Bayan
