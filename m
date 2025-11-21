Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD321B9FD
	for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710510; cv=none; b=PXqgMWp4c1Ge1EmwbTSC6PHgTjmX3bByBpzt64vK/zFMonRE7mYFCPY6i0ZZ5jqh9Qqf5e2Wy03ES7LLH6Azuo2qTxfQZtt85KGd4USoYlKlbSSnkzfh2Gw0A5YihX5KxmrixOMcbixuMW3LhaSwmG9geTKZ6kVSARp/bhfFxUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710510; c=relaxed/simple;
	bh=5ZFaPPHpwx/QqbFQlzHuLr0rHuxFVdUup04ENiQfoqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BBpNYR5uDRNT13PLm45qvVWKr7EMPh9eoIbcDYKd3M8KeZtLbnf9Vxg7dpPjQadzE1Tgz+zwo/JvRd+jZjueRbwCJ7/5x6OjjtFod4S8iKVev+0c4v9MdEAn0t0SYNJomnUS3hKlJQi6chYdWTOFjqeSuHdJ12x17wTKnxoUqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ckK2k5BG; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ckK2k5BG"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kfkHXzT82wN8lM8keGLI6ER7nKu68MfhYXMMBbHphjI=;
	b=ckK2k5BGrHh//OxNuaKx/OBTaMDrl8YmFwKNHZsUACVWu75czQGH664g3lq6yLQPiOYaV6O3A
	3J4N8udUaRVdkKnphQIysrNkwfO8JveN9sKyDmymDMGr/CIi8CVbG2jnmD5NSfeZVAw6RHLPrEG
	+3h5DVW4PbEA9kgfbb1xEhA=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dCRlf648LzmV6W;
	Fri, 21 Nov 2025 15:33:18 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id E3429140295;
	Fri, 21 Nov 2025 15:35:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 15:35:03 +0800
From: Yihang Li <liyihang9@h-partners.com>
To: <mario.limonciello@amd.com>, <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>, <linuxarm@huawei.com>,
	<liyihang9@h-partners.com>, <liuyonglong@huawei.com>
Subject: [bug report] ata: ahci: IO error with the default med_power_with_dipm
Date: Fri, 21 Nov 2025 15:35:02 +0800
Message-ID: <20251121073502.3388239-1-liyihang9@h-partners.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemh200005.china.huawei.com (7.202.181.112)

Hello Mario, Damien,

After commit 5433f0e7427ae ("ata: Kconfig: Update SATA_MOBILE_LPM_POLICY
default to med_power_with_dipm") from linux v6.11, I am seeing the error,
and eventually, my file system became read-only and could no longer
be used. Please help check whether this is reasonable and how to resolve
this issue?

I am using an standard AHCI controller, connected to a SATA disk, and
using this disk as the system drive.

# lsblk
NAME               MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda                  8:0    0 447.1G  0 disk 
├─sda1               8:1    0   600M  0 part /boot/efi
├─sda2               8:2    0     1G  0 part /boot
└─sda3               8:3    0 445.5G  0 part 
  ├─openeuler-root 252:0    0    70G  0 lvm  /
  ├─openeuler-swap 252:1    0     4G  0 lvm  [SWAP]
  └─openeuler-home 252:2    0 371.5G  0 lvm  /home

Any suggestions on the problem are welcome.

Thanks,
Yihang

error message is as follows:
[  614.263599] ata1: limiting SATA link speed to 3.0 Gbps
[  614.269289] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0xf0100 action 0x6 frozen
[  614.276979] ata1: SError: { UnrecovData PHYRdyChg PHYInt CommWake 10B8B }
[  614.284037] ata1.00: failed command: FLUSH CACHE
[  614.288850] ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 10
[  614.288850]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x14 (ATA bus error)
[  614.303261] ata1.00: status: { DRDY }
[  614.307036] ata1: hard resetting link
[  619.651573] ata1: link is slow to respond, please be patient (ready=-19)
[  624.499503] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  624.499574] ata1: illegal qc_active transition (00000400->00000001)
[  629.759549] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
[  629.765817] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  629.772120] ata1.00: revalidation failed (errno=-5)
[  629.778303] ata1: hard resetting link
[  635.139452] ata1: link is slow to respond, please be patient (ready=-19)
[  639.959462] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  649.987465] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
[  649.993775] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  650.000159] ata1.00: revalidation failed (errno=-5)
[  650.006136] ata1: limiting SATA link speed to 1.5 Gbps
[  650.011470] ata1: hard resetting link
[  655.351514] ata1: link is slow to respond, please be patient (ready=-19)
[  660.179451] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  691.967428] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
[  691.973582] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  691.980156] ata1.00: revalidation failed (errno=-5)
[  691.985935] ata1.00: disable device
[  697.299481] ata1: link is slow to respond, please be patient (ready=-19)
[  702.175503] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  702.182413] ata1: EH complete
[  702.186319] sd 0:0:0:0: [sda] tag#3 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=148s
[  702.186413] sd 0:0:0:0: [sda] tag#2 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=145s
[  702.196359] sd 0:0:0:0: [sda] tag#3 CDB: opcode=0x35 35 00 00 00 00 00 00 00 00 00
[  702.206217] sd 0:0:0:0: [sda] tag#2 CDB: opcode=0x28 28 00 04 9b 47 a0 00 00 88 00
[  702.214189] I/O error, dev sda, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
[  702.221543] I/O error, dev sda, sector 77285280 op 0x0:(READ) flags 0x80700 phys_seg 11 prio class 0
[  702.222563] sd 0:0:0:0: [sda] tag#5 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.222631] sd 0:0:0:0: [sda] tag#5 CDB: opcode=0x28 28 00 03 23 e1 60 00 00 f0 00
[  702.222693] I/O error, dev sda, sector 52683104 op 0x0:(READ) flags 0x80700 phys_seg 30 prio class 0
[  702.222873] sd 0:0:0:0: [sda] tag#6 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.222927] sd 0:0:0:0: [sda] tag#6 CDB: opcode=0x2a 2a 00 00 34 d0 00 00 05 40 00
[  702.222972] I/O error, dev sda, sector 3461120 op 0x1:(WRITE) flags 0x1004000 phys_seg 168 prio class 0
[  702.223051] Write-error on swap-device (252:4:131072)
[  702.223087] Write-error on swap-device (252:4:131080)
[  702.223110] Write-error on swap-device (252:4:131088)
[  702.223128] Write-error on swap-device (252:4:131096)
[  702.223143] Write-error on swap-device (252:4:131104)
[  702.223155] Write-error on swap-device (252:4:131112)
[  702.223166] Write-error on swap-device (252:4:131120)
[  702.223178] Write-error on swap-device (252:4:131128)
[  702.223193] Write-error on swap-device (252:4:131136)
[  702.223200] Write-error on swap-device (252:4:131144)
[  702.223391] sd 0:0:0:0: [sda] tag#17 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223405] sd 0:0:0:0: [sda] tag#13 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223429] sd 0:0:0:0: [sda] tag#17 CDB: opcode=0x2a 2a 00 03 fe 0d 40 00 00 08 00
[  702.223455] sd 0:0:0:0: [sda] tag#14 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223474] I/O error, dev sda, sector 66981184 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
[  702.223501] sd 0:0:0:0: [sda] tag#14 CDB: opcode=0x2a 2a 00 03 fd f8 08 00 05 40 00
[  702.223517] I/O error, dev sda, sector 66975752 op 0x1:(WRITE) flags 0x4000 phys_seg 168 prio class 0
[  702.223551] sd 0:0:0:0: [sda] tag#15 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223556] sd 0:0:0:0: [sda] tag#15 CDB: opcode=0x2a 2a 00 03 fd fd 48 00 00 d0 00
[  702.223556] EXT4-fs warning (device dm-0): ext4_end_bio:342: I/O error 10 writing to inode 395063 starting block 1979304)
[  702.223581] I/O error, dev sda, sector 66977096 op 0x1:(WRITE) flags 0x0 phys_seg 26 prio class 0
[  702.223606] Buffer I/O error on device dm-0, logical block 1979304
[  702.223626] sd 0:0:0:0: [sda] tag#13 CDB: opcode=0x2a 2a 00 00 34 d5 40 00 02 18 00
[  702.223641] EXT4-fs warning (device dm-0): ext4_end_bio:342: I/O error 10 writing to inode 395005 starting block 1978625)
[  702.223729] I/O error, dev sda, sector 3462464 op 0x1:(WRITE) flags 0x1000000 phys_seg 67 prio class 0
[  702.223755] sd 0:0:0:0: [sda] tag#20 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223773] sd 0:0:0:0: [sda] tag#20 CDB: opcode=0x2a 2a 00 06 54 10 00 00 00 08 00
[  702.223780] I/O error, dev sda, sector 106172416 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
[  702.223803] EXT4-fs warning (device dm-0): ext4_end_bio:342: I/O error 10 writing to inode 395005 starting block 6878208)
[  702.223792] sd 0:0:0:0: [sda] tag#19 UNKNOWN(0x2003) Result: hostbyte=0x04 driverbyte=DRIVER_OK cmd_age=0s
[  702.223825] Buffer I/O error on device dm-0, logical block 6878208
[  702.223980] sd 0:0:0:0: [sda] tag#19 CDB: opcode=0x2a 2a 00 05 16 09 70 00 00 68 00
[  702.224050] I/O error, dev sda, sector 85330288 op 0x1:(WRITE) flags 0x9800 phys_seg 13 prio class 2
[  702.224144] Buffer I/O error on device dm-0, logical block 1978625
[  702.224211] Buffer I/O error on device dm-0, logical block 1978626
[  702.224222] Buffer I/O error on device dm-0, logical block 1978627
[  702.224239] Buffer I/O error on device dm-0, logical block 1978628
[  702.224264] Buffer I/O error on device dm-0, logical block 1978629
[  702.224277] Buffer I/O error on device dm-0, logical block 1978630
[  702.224288] Buffer I/O error on device dm-0, logical block 1978631
[  702.224304] Buffer I/O error on device dm-0, logical block 1978632
[  702.224338] EXT4-fs warning (device dm-0): ext4_end_bio:342: I/O error 10 writing to inode 395221 starting block 3919882)
[  702.224827] Aborting journal on device dm-0-8.
[  702.224947] EXT4-fs error (device dm-0): ext4_journal_check_start:84: comm rasdaemon: Detected aborted journal
[  702.230833] Buffer I/O error on dev dm-0, logical block 4227072, lost sync page write
[  702.243123] coredump: 28149(grep): |/usr/lib/systemd/systemd-coredump pipe failed
[  702.248987] JBD2: I/O error when updating journal superblock for dm-0-8.
[  702.649651] Buffer I/O error on dev dm-0, logical block 0, lost sync page write
[  702.657315] EXT4-fs (dm-0): I/O error while writing superblock
[  702.663495] EXT4-fs (dm-0): Remounting filesystem read-only


