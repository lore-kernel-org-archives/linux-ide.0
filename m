Received: from out198-190.us.a.mail.aliyun.com (out198-190.us.a.mail.aliyun.com [47.90.198.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB836BCDA
	for <linux-ide@vger.kernel.org>; Thu,  9 Apr 2026 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775737366; cv=none; b=I9AlZRpbiI6yzenpkCAVi8pi1hP60BJaQPKh7uPxvrH1kwGDq5svi5UQnkNKjDqjZ7UOIgvij1NO0M+i21zeK1D59kmxs9pZQBYuvK+GMAPpfJaMCzr/MAoCfqOWpeb2NQ7NVOS4vfDlFLLnbYHqsRWWsRZ++LHIcyMtN6jbcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775737366; c=relaxed/simple;
	bh=d4daVvbKCW1DZJcDkbzFka/KpM7xJd/lCnHzp0JsVlY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UciphGRWnRoyzvPM4ygpw+VWNkSy2nzNdXwqoibCpscXWz0vnRKIJMHLZfNUYV3YeVIM2tB35g2wlvLt+McDjtEfpQDgO+da0nldu4Uuj+AvuueCMx1DneyANcopoXBxT8Rc6vtCgieYjHrtObtgCSlS7beepCE1f6fl68WKMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc; spf=pass smtp.mailfrom=alancui.cc; dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b=PFLWO3vT; arc=none smtp.client-ip=47.90.198.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alancui.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alancui.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alancui.cc header.i=@alancui.cc header.b="PFLWO3vT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775737351; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=TVyZilHVhqOTAaBV0FGVbExB+ha7D+qg+Krs/ij/E5o=;
	b=PFLWO3vTyRJEwrM9m0GK/fFMFgKA3jCXbj+pWOiX9/+JzfulBeJlDR4xP0OmlM0DtK8y5G5aUy0eYJ/IaG/6mmpXRiYp+sku0/0LySBk/HkZ7Tgmv1FtxJ/80wJk1tlQVZjqL1i+E9pyGajElhC/d8kgeLSLc0BIrfHMP52kOeBJ5dPp0LitHNq5FH7lfV9MnX2pMGwMLt7glEy9ZwWt8hGWjb9vC7tgLBokwyuNcEUksQL48LTx4/w7L51J9pIUeRfDwPRmGE91Cph02VYa+PB87GAC2cJJ4L8BKGCVeHIwo0kuxT6DkvX9NgHW5FHdbjbF3XCkvr0Q4nEUTOtPrA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.123991|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0201925-8.93795e-05-0.979718;FP=1833947879054247347|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.h8GPoNP_1775730062;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h8GPoNP_1775730062 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 18:21:03 +0800
From: AlanCui4080 <me@alancui.cc>
To: linux-ide@vger.kernel.org, dlemoal@kernel.org
Subject:
 Default IDENTIFY timeout is 5000ms which is too short for enterprise disks
Date: Thu, 09 Apr 2026 18:21:02 +0800
Message-ID: <14015677.uLZWGnKmhe@alanarchdesktop>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

I have two ST4000NM000A-2HZ100 on my computer which is of seagate enterprise 
line.  But when i recovery from suspend, the kernel complains about that and 
the zpool kicks the disk off:

```
ata2: found unknown device (class 0)
ata4: found unknown device (class 0)
ata2: found unknown device (class 0)
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4: found unknown device (class 0)
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4.00: qc timeout after 5000 msecs (cmd 0xec)
ata4.00: qc timeout after 5000 msecs (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata2.00: qc timeout after 5000 msecs (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: revalidation failed (errno=-5)
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: configured for UDMA/133
ata4.00: configured for UDMA/133
```
I think that's cause by the too slow spinup for my disk.
After make libata to wait longer, the warning disappeared.

```
# cat /proc/cmdline
libata.ata_probe_timeout=10
```

```
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
sd 1:0:0:0: [sda] Starting disk
ata2.00: configured for UDMA/133
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
sd 3:0:0:0: [sdb] Starting disk
ata4.00: configured for UDMA/133
```


Meanwhile, the seachest reports that the startup time from standby is 9sec, 
which is longer that the default ATA IDENTIFY timeout.

```
/dev/sg0 - ST4000NM000A-2HZ100 - **** - TN04 - ATA

Standby Z : Recovery Time : 90 (in 100msecs)
```

```
static const unsigned int ata_eh_identify_timeouts[] = {
         5000,  /* covers > 99% of successes and not too boring on failures */
        10000,  /* combined time till here is enough even for media access */
        30000,  /* for true idiots */
        UINT_MAX,
};
```

I tested the hard drive, and as long as it's never set to STANDBY_Z (disk 
stops spinning, requiring 9 seconds to recover) and kept in IDLE_C (platter 
slows down, requiring 3.2 seconds to recover), this error never occurs.

It's been seen many users complaining about this elsewhere, should we quirk 
for those "heavy" disk? Or print some warnings about how to relax this 
problem.

Alan


