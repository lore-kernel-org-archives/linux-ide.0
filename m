Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BC33FE26
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2026 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823271; cv=none; b=furQGSyO8SddQGZ9C3W4YfqgLZe+TBA0Wcgvra+56YXV424zJDKUFfAxkL6Pc6gKAAx6oKnEFO+Rb4ah2VNvPnPPWnz44GsnmKbqbBQ/qijbZt7McJkDkFeKt/UkcDkUW5DzMU4e8WGBBsEV3VLkkR1uGA2ZENpZ+3uhqZWhru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823271; c=relaxed/simple;
	bh=kvIzaECYab6ftvAiS7pf1dkPP89CUhvxNhRYMMbDCU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/PcsHhA8hmlLd1e85YJD8TfJdavR/PTUAYqPzWR7DiunnikIMwZ3hx4RAafTASaX+o6IyAIE358GxqoiqKFbKfWMebDUl7cUN4UDcTAAkFnI1mFSXNILhriXaYvvTkmQRp92Hy5DkdETM8BL6Fg2M3Y4BMlBqo/vkTsPId4Rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=INMlVnTc; arc=none smtp.client-ip=115.124.28.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="INMlVnTc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775823265; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ImyAjyKpp5zFHjMX+oiCRlCzVm+OD2k/hzXaxYNeP5Y=;
	b=INMlVnTcUaK2W/x3Jc2ZeJA+jxKe+Z1w/nvGzrrkrcg7DBHuFhQ6KG/HzwVo39y71pPy0xSdQup6jOdOQmEQdPEyMFk/DRIXZnMVWDUW9ZeVbPyr7Uy+rwpHp6GwE0ETh40mRzPo9ephL9oaCYX6+XO7A/FHZ8++mVzSsQyqftLGp0nT+Nk3iBJQmqY5Jlha4Bw5IWaD8QMi6TcB5TyjC6SgmjMBuKMgIdO/yI+lBYLyc6B8+2XdRW4jdBHnWG2eIgHsVQKugTu1aaEVjWUY5cvBQuwD5mHIwKmy79ZBRp+OezhUPKJYHHWGHiyFaiY2sLc3aCwoJImqLfhe5qOFJA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07533253|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.248013-5.25892e-05-0.751934;FP=4347571172197274770|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.h9JIcEz_1775823263;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h9JIcEz_1775823263 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 10 Apr 2026 20:14:24 +0800
From: AlanCui4080 <me@alancui.cc>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject:
 Re: Default IDENTIFY timeout is 5000ms which is too short for enterprise
 disks
Date: Fri, 10 Apr 2026 20:14:23 +0800
Message-ID: <3404296.aeNJFYEL58@alanarchdesktop>
In-Reply-To: <12870147.O9o76ZdvQC@alanarchdesktop>
References:
 <14015677.uLZWGnKmhe@alanarchdesktop>
 <4482b737-1454-48cb-a941-165aa84fb2eb@kernel.org>
 <12870147.O9o76ZdvQC@alanarchdesktop>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

As further infomation, I found that increase the time of timeout can only relax
the problem, In multiple wakings from S3, it failed to IDENTIFY in about 10% time.
Interestingly, after the failure, the port immediately regained the link then
successfully configured the hard drive.

```
[  322.975526] ACPI: PM: Waking up from system sleep state S3
...
[  332.991862] ata4: found unknown device (class 0)
[  332.992863] ata2: found unknown device (class 0)
[  333.147890] ata2: found unknown device (class 0)
[  333.147899] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  333.147911] ata4: found unknown device (class 0)
[  333.147920] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  348.198232] ata4.00: qc timeout after 15000 msecs (cmd 0xec)
[  348.198242] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  348.198245] ata4.00: revalidation failed (errno=-5)
[  348.198259] ata2.00: qc timeout after 15000 msecs (cmd 0xec)
[  348.198269] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  348.198272] ata2.00: revalidation failed (errno=-5)
[  348.662584] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  348.662610] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  348.699354] ata4.00: configured for UDMA/133
[  348.719825] ata2.00: configured for UDMA/133
```

And the difference between the failed recovery to succeed one is that ata
won't report "found unkown device". Then I attached new customer-level
WD and Seagate drives, and as what i think, they spinup really faster
than those Exos drives and will never be reported as revalidation failed:

```  // 2.5 inch WD Blue drive, 8 secs faster
[ 1047.409533] ACPI: PM: Waking up from system sleep state S3
...
[ 1047.724415] ata5: SATA link down (SStatus 0 SControl 330)
[ 1047.724451] ata3: SATA link down (SStatus 0 SControl 300)
[ 1048.452451] ata6: SATA link down (SStatus 0 SControl 0)
[ 1049.204451] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1049.257864] sd 0:0:0:0: [sdc] Starting disk
...
[ 1051.916495] PM: suspend exit
[ 1052.728394] ata4: link is slow to respond, please be patient (ready=0)
[ 1052.733355] ata2: link is slow to respond, please be patient (ready=0)
[ 1054.840880] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control rx/tx
[ 1057.076309] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1057.116416] sd 1:0:0:0: [sda] Starting disk
[ 1057.134584] ata2.00: configured for UDMA/133
[ 1057.532325] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1057.576679] sd 3:0:0:0: [sdb] Starting disk
[ 1057.594743] ata4.00: configured for UDMA/13
```

```  // 3.5 inch Seagate BarraCuda drive, 6 secs faster
[ 1484.056163] ACPI: PM: Waking up from system sleep state S3
[ 1484.371881] ata5: SATA link down (SStatus 0 SControl 330)
[ 1484.371917] ata3: SATA link down (SStatus 0 SControl 300)
[ 1485.099799] ata6: SATA link down (SStatus 0 SControl 0)
...
[ 1488.620192] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1488.621446] sd 0:0:0:0: [sdc] Starting disk
[ 1488.622941] ata1.00: configured for UDMA/133
...
[ 1488.633805] PM: suspend exit
[ 1489.374930] ata2: link is slow to respond, please be patient (ready=0)
[ 1489.374939] ata4: link is slow to respond, please be patient (ready=0)
[ 1491.563828] r8169 0000:07:00.0 enp7s0: Link is Up - 1Gbps/Full - flow control rx/tx
[ 1493.666523] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1493.713096] sd 1:0:0:0: [sda] Starting disk
[ 1493.731018] ata2.00: configured for UDMA/133
[ 1494.026490] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1494.083273] sd 3:0:0:0: [sdb] Starting disk
[ 1494.101513] ata4.00: configured for UDMA/133
```
Furthermore, I discovered that adding an extra hard drive to the system can relax
the revalidation failure issue. That may shows, the hard drive might not actually
restore the linkwhen the kernel believes it has (because the kernel said it don't
know the device on the link). And the slight delay caused by adding an extra
hard drive allows command can be truly accepted by the hard drive, thus avoiding this problem.

At the same time, I'd like to point out that the AMD B550 southbridge only has
two native SATA ports, so these six ports must be of port multiplier.
Could this cause issues? I've seen many B550 users reported that the ASMedia IP Cores
used for the southbridge SATA ports are no reliable enough.

Alan.


