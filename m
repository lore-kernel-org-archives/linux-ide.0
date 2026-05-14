Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1138D6BD
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731788; cv=none; b=hNdpiJprTUoDpTBImAqvCI0hZ9w0k9yOmekwxQd4miV3yt5wmPenT6KtJfPwfqgo9iCXxANe0WRVGKaD3ZCPJBcf/T7FS7iLsu4Hgh0xwxiIfdreeawB1F8lFFvaz1UA29tWi3p/3lHA8/Zhie5hUs4ELBTWWS7OTVD/xg22QlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731788; c=relaxed/simple;
	bh=k/kp3ihLCNnD1UGZHxs2q9/c3Qk/fNAUN//X6NWioLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:In-Reply-To:
	 From:Content-Type; b=TgHx988WZO7QdVFEHYcee/7Z5vlVr+htAWn3/16p9W5lU4A1CBwJOK/L2QJO0razhD1riKlq0h8w5Oi7I+jF+cXFsHOGHDPGvVMAtBROEoxbPD3gYR1OKdTykNd+Af2ryRcYEBzxN16YJ83OMPdkoaGovm/mER/hFod8SktFEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=fe+J9wer; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="fe+J9wer"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778731778; bh=k/kp3ihLCNnD1UGZHxs2q9/c3Qk/fNAUN//X6NWioLo=;
	h=Subject:To:Cc:References:In-Reply-To:From;
	b=fe+J9werLbVojPWbTwHN15qVz8yiFyioclasZ5ycU2aePM+Jf9ZKMTujkc0EoHALl
	 CVsF8qtVlq1FBD3Tfzvh6+zj9BsCr18N9i12gJcq1o0UKLjkpaxuif4VaDzatGFAJc
	 cW7S5PK4qPOORd6VvUansPX2xuAV9mbHEwJKjdSf8GkGVTwXE9B2mmaZbYif8khUA9
	 T++nxzJxy0YQDeTnTisMDuewElF5FTUltXSQXHKBgxjuK3Vni1KqrO+hfebTW6HBpQ
	 AMZdUgpq9Lvi9DBjVu9NEH/ajsf+YQF0GQ/upfAouMhXmcdRQsrae+JrgJQpTGwAmh
	 iEvPtTk7kKyEw==
Message-ID: <5ef17ab9-5941-4268-b537-9e4f6cf7e602@tkel.ly>
Date: Wed, 13 May 2026 21:09:35 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/4] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513151359.1075403-6-cassel@kernel.org>
Content-Language: en-US
In-Reply-To: <20260513151359.1075403-6-cassel@kernel.org>
From: Tommy Kelly <linux@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 08:13, Niklas Cassel wrote: 
> Changes since v3:
> -Use iter_mode PMP_FIRST rather than EDGE in ata_for_each_link(), such that
>  the slave_link is included.
> -Add patch 1/4 that is a cleanup patch.
> -Add patch 2/4 that changes so that the deferred QC is only used for
>  ATA_DEFER_LINK (i.e. not used for ATA_DEFER_PORT).
> -Renamed ATA_DEFER_LINK_CBS to ATA_DEFER_LINK_EXCL.
> 
> 
> Niklas Cassel (4):
>   ata: libata-scsi: improve readability of ata_scsi_qc_issue()
>   ata: libata-scsi: do not use the deferred QC feature for
>     ATA_DEFER_PORT
>   ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>   ata: libata-scsi: do not needlessly defer commands when using PMP with
>     FBS
> 
>  drivers/ata/libata-core.c |  9 ++--
>  drivers/ata/libata-eh.c   |  8 ++--
>  drivers/ata/libata-pmp.c  | 18 +++++++-
>  drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++----------------
>  drivers/ata/sata_sil24.c  |  6 ++-
>  include/linux/libata.h    |  7 +--
>  6 files changed, 87 insertions(+), 50 deletions(-)
> 
> 
> base-commit: 79b6e4dd96ec663ef51bb52b00e0bbbdf0ec9009

Hi Niklas + Damien,

I built linux v7.1-rc3 with this v4 patchset and libata/for-next applied.

With FBS, no warnings, errors, or noticable usability issues.

With CBS strange things are happening.
The first boot, I got a warning. It happened right at the beginning of the fsck-on-mount:

> kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> 19:29:15 smartd[1045]: Device: /dev/sdc [SAT], is SMART capable. Adding to "monitor" list.
> 19:29:15 smartd[1045]: Device: /dev/sdd, type changed from 'scsi' to 'sat'
> 19:29:15 smartd[1045]: Device: /dev/sdd [SAT], opened
> 19:29:15 smartd[1045]: Device: /dev/sdd [SAT], ADATA SU655, S/N:2J0720016679, WWN:0-000000-000000000, FW:V8X01c62, 240 GB
> 19:29:15 kernel: bcachefs: accounting_read... done (0 seconds)
> 19:29:15 smartd[1045]: Device: /dev/sdd [SAT], found in smartd database 7.5/6028: Silicon Motion based SSDs
> 19:29:16 kernel: ------------[ cut here ]------------
> 19:29:16 kernel: WARNING: drivers/ata/libata-scsi.c:1682 at ata_scsi_deferred_qc_work+0x88/0x98, CPU#0: kworker/0:1H/603
> 19:29:16 kernel: CPU: 0 UID: 0 PID: 603 Comm: kworker/0:1H Tainted: G           OE      ------  ---  7.1.0-0.rc3.1d5dcaa3bd65.25.test.fc44.aarch64 #1 PREEMPT(lazy) 
> 19:29:16 kernel: Hardware name: hardkernel Hardkernel ODROID-M1/Hardkernel ODROID-M1, BIOS 2026.04 04/01/2026
> 19:29:16 kernel: Workqueue: events_highpri ata_scsi_deferred_qc_work
> 19:29:16 kernel: pc : ata_scsi_deferred_qc_work+0x88/0x98
> 19:29:16 kernel: lr : ata_scsi_deferred_qc_work+0x54/0x98
> 19:29:16 kernel: Call trace:
> 19:29:16 kernel:  ata_scsi_deferred_qc_work+0x88/0x98 (P)
> 19:29:16 kernel:  process_one_work+0x188/0x520
> 19:29:16 kernel:  worker_thread+0x194/0x2f8
> 19:29:16 kernel:  kthread+0x11c/0x140
> 19:29:16 kernel:  ret_from_fork+0x10/0x20
> 19:29:16 kernel: ---[ end trace 0000000000000000 ]---

However the rest of the first boot proceeded fine and I was able to use the system normally.

---

The second boot, I got the libata-scsi warning in the exact same spot, right at the beginning of fsck. Same call trace.

> bcachefs: accounting_read... done (0 seconds)
> WARNING: drivers/ata/libata-scsi.c:1682 at ata_scsi_deferred_qc_work+0x88/0x98

Fsck completed without issue. The filesystem was mounted.
Then this smartd error log showed up for the first (and only) time.

> smartd[1045]: Device: /dev/sdd [SAT], no ATA CHECK POWER STATUS support, ignoring -n Directive

Then, some power issue(?) caused the system to go read-only and I can't debug
anything because I can't execute any programs. This has happened in the past a
few times. The system crashes after a few minutes in this state. No logs are
available because the log system fails. Unsure if its related to these patches
but seems to happen when I build my own kernels. For these CBS tests I'm using the
unpatched fdt from u-boot v2026.04.
My root/boot filesystems are on an nvme drive, not the SATA PMP.

--- 

Now the third boot with CBS.

We make it to fsck without issue.
Fsck begins, but its running very slowly. Normally a fsck only takes 9-11 mins.
The libata-scsi warning appears, but after a few mins into the fsck this time.
Eventually, a recurring error which appears to reset the PMP links.
And SRCU lock warnings appear which I haven't seen since linux 6.19.

smartd times out on the third drive:

> 19:44:05 smartd[1051]: Device: /dev/sdc, type changed from 'scsi' to 'sat'
> 19:44:05 smartd[1051]: Device: /dev/sdc [SAT], opened
> 19:44:05 smartd[1051]: Device: /dev/sdc [SAT], Hitachi HTS547575A9E384 ...
> 19:44:05 smartd[1051]: Device: /dev/sdc [SAT], found in smartd database 7.5/6028: Hitachi/HGST Travelstar 5K750
> 19:45:09 smartd[1051]: Device: /dev/sdc [SAT], not capable of SMART Health Status check
> 19:45:37 systemd[1]: smartd.service: start operation timed out. Terminating.
> 19:46:11 systemd[1]: smartd.service: Failed with result 'timeout'.
> 19:46:11 systemd[1]: Failed to start smartd.service - Self Monitoring and Reporting Technology (SMART) Daemon.

fsck begins:

> 19:44:05 kernel: bcachefs : recovering from unclean shutdown
> 19:44:05 kernel: bcachefs : starting journal read
> 19:47:58 kernel: bcachefs : check_allocations...
> 19:51:06 kernel:  done (191 seconds)
> 19:51:08 kernel: bcachefs : going read-write
> 19:52:09 kernel: ------------[ cut here ]------------
> 19:52:09 kernel: WARNING: drivers/ata/libata-scsi.c:1682 at ata_scsi_deferred_qc_work+0x88/0x98, CPU#0: kworker/0:1H/601
...
> 20:02:51 kernel: bcachefs : check_extents_to_backpointers...
> 20:02:51 kernel: ata1.00: failed to read SCR 1 (Emask=0x40)
> 20:02:51 kernel: ata1.01: failed to read SCR 1 (Emask=0x40)
> 20:02:51 kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
> 20:02:51 kernel: ata1.03: failed to read SCR 1 (Emask=0x40)
> 20:02:51 kernel: ata1.04: failed to read SCR 1 (Emask=0x40)
> 20:02:51 kernel: ata1.04: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x6 frozen
> 20:02:51 kernel: ata1.04: incorrect PMP
> 20:02:51 kernel: ata1.04: failed command: DATA SET MANAGEMENT
> 20:02:51 kernel: ata1.04: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag 16 dma 512 out
>                                         res 40/00:00:f0:67:fb/00:00:00:00:00/40 Emask 0x2 (HSM violation)
> 20:02:51 kernel: ata1.04: status: { DRDY }
> 20:02:52 kernel: ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 20:02:52 kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:02:53 kernel: ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:02:53 kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:02:54 kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:02:54 kernel: ata1.04: hard resetting link
> 20:02:54 kernel: ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:02:54 kernel: ata1.00: configured for UDMA/133
> 20:02:54 kernel: ata1.01: configured for UDMA/133
> 20:02:54 kernel: ata1.02: configured for UDMA/133
> 20:02:54 kernel: ata1.03: configured for UDMA/133
> 20:02:54 kernel: ata1.04: configured for UDMA/133
> 20:02:54 kernel: ata1: EH complete
> 20:03:40 kernel:  done (49 seconds)
> 20:09:00 kernel: bcachefs : check_alloc_to_lru_refs...
> 20:09:25 kernel:  done (25 seconds)
> 20:14:39 kernel: ata1.00: failed to read SCR 1 (Emask=0x40)
> 20:14:39 kernel: ata1.01: failed to read SCR 1 (Emask=0x40)
> 20:14:39 kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
> 20:14:39 kernel: ata1.03: failed to read SCR 1 (Emask=0x40)
> 20:14:39 kernel: ata1.04: failed to read SCR 1 (Emask=0x40)
> 20:14:39 kernel: ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> 20:14:39 kernel: ata1.03: failed command: FLUSH CACHE EXT
> 20:14:39 kernel: ata1.03: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 29
>                                         res 40/00:01:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> 20:14:39 kernel: ata1.03: status: { DRDY }
> 20:14:39 kernel: ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 20:14:40 kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:14:40 kernel: ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:14:41 kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:14:41 kernel: ata1.03: hard resetting link
> 20:14:41 kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:14:42 kernel: ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:14:42 kernel: ata1.00: configured for UDMA/133
> 20:14:42 kernel: ata1.01: configured for UDMA/133
> 20:14:42 kernel: ata1.02: configured for UDMA/133
> 20:14:42 kernel: ata1.03: configured for UDMA/133
> 20:14:42 kernel: ata1.03: retrying FLUSH 0xea Emask 0x4
> 20:14:42 kernel: ata1.04: configured for UDMA/133
> 20:14:42 kernel: ata1: EH complete
> 20:14:42 kernel: bcachefs : check_snapshot_trees... done (0 seconds)
> 20:15:43 kernel: bcachefs : check_snapshots... done (0 seconds)
> 20:15:43 kernel: bcachefs (dev/sda): error reading superblock: EBUSY
> 20:15:43 kernel: error starting filesystem: EBUSY
> 20:15:43 kernel: bcachefs: bch2_fs_get_tree() error: EBUSY
> 20:15:44 kernel: ata1.00: failed to read SCR 1 (Emask=0x40)
> 20:15:44 kernel: ata1.01: failed to read SCR 1 (Emask=0x40)
> 20:15:44 kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
> 20:15:44 kernel: ata1.03: failed to read SCR 1 (Emask=0x40)
> 20:15:44 kernel: ata1.04: failed to read SCR 1 (Emask=0x40)
> 20:15:44 kernel: ata1.04: exception Emask 0x2 SAct 0x0 SErr 0x0 action 0x6 frozen
> 20:15:44 kernel: ata1.04: incorrect PMP
> 20:15:44 kernel: ata1.04: failed command: FLUSH CACHE EXT
> 20:15:44 kernel: ata1.04: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 24
>                                         res 40/00:c8:00:3c:f2/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
> 20:15:44 kernel: ata1.04: status: { DRDY }
> 20:15:45 kernel: ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 20:15:45 kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:15:46 kernel: ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:15:46 kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:15:46 kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:15:46 kernel: ata1.04: hard resetting link
> 20:15:47 kernel: ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:15:47 kernel: ata1.00: configured for UDMA/133
> 20:15:47 kernel: ata1.01: configured for UDMA/133
> 20:15:47 kernel: ata1.02: configured for UDMA/133
> 20:15:47 kernel: ata1.03: configured for UDMA/133
> 20:15:47 kernel: ata1.04: configured for UDMA/133
> 20:15:47 kernel: ata1.04: retrying FLUSH 0xea Emask 0x2
> 20:15:47 kernel: ata1.04: device reported invalid CHS sector 0
> 20:15:47 kernel: ata1: EH complete
> 20:16:50 kernel: ata1.00: failed to read SCR 1 (Emask=0x40)
> 20:16:50 kernel: ata1.01: failed to read SCR 1 (Emask=0x40)
> 20:16:50 kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
> 20:16:50 kernel: ata1.03: failed to read SCR 1 (Emask=0x40)
> 20:16:50 kernel: ata1.04: failed to read SCR 1 (Emask=0x40)
> 20:16:50 kernel: ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 20:16:51 kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:16:51 kernel: ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:16:52 kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:16:52 kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:16:53 kernel: ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:16:53 kernel: ata1.00: configured for UDMA/133
> 20:16:53 kernel: ata1.01: configured for UDMA/133
> 20:16:53 kernel: ata1.02: configured for UDMA/133
> 20:16:53 kernel: ata1.03: configured for UDMA/133
> 20:16:53 kernel: ata1.04: configured for UDMA/133
> 20:16:53 kernel: bcachefs : check_subvols... done (0 seconds)
> 20:16:54 kernel: bcachefs : check_subvol_children... done (0 seconds)
> 20:17:55 kernel: ata1: illegal qc_active transition (08000000->01800000)
> 20:17:55 kernel: ata1.00: failed to read SCR 1 (Emask=0x40)
> 20:17:55 kernel: ata1.01: failed to read SCR 1 (Emask=0x40)
> 20:17:55 kernel: ata1.02: failed to read SCR 1 (Emask=0x40)
> 20:17:55 kernel: ata1.03: failed to read SCR 1 (Emask=0x40)
> 20:17:55 kernel: ata1.04: failed to read SCR 1 (Emask=0x40)
> 20:17:55 kernel: ata1.04: exception Emask 0x100 SAct 0x8000000 SErr 0x0 action 0x6 frozen
> 20:17:55 kernel: ata1.04: failed command: WRITE FPDMA QUEUED
> 20:17:55 kernel: ata1.04: cmd 61/08:d8:b0:35:40/00:00:00:00:00/40 tag 27 ncq dma 4096 out
>                                         res 50/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x100 (unknown error)
> 20:17:55 kernel: ata1.04: status: { DRDY }
> 20:17:56 kernel: ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 20:17:56 kernel: ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:17:57 kernel: ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:17:57 kernel: ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> 20:17:58 kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:17:58 kernel: ata1.04: hard resetting link
> 20:17:58 kernel: ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> 20:17:58 kernel: ata1.00: configured for UDMA/133
> 20:17:58 kernel: ata1.01: configured for UDMA/133
> 20:17:58 kernel: ata1.02: configured for UDMA/133
> 20:17:58 kernel: ata1.03: configured for UDMA/133
> 20:17:58 kernel: ata1.04: configured for UDMA/133
> 20:17:58 kernel: ata1: EH complete
> 20:18:30 kernel: ------------[ cut here ]------------
> 20:18:30 kernel: btree trans held srcu lock (delaying memory reclaim) for 31 seconds
>                                btree_node_write:
>                                journal_reclaim_finish:
>                                journal_reclaim_start:
>                                transaction_commit:
> 20:18:30 kernel: WARNING: src/fs/bcachefs/btree/locking.c:1055 at bch2_trans_unlock_long+0x258/0x270 [bcachefs], CPU#1: kworker/1:1/6027
> 20:18:30 kernel: Hardware name: hardkernel Hardkernel ODROID-M1/Hardkernel ODROID-M1, BIOS 2026.04 04/01/2026
> 20:18:30 kernel: Workqueue: bcachefs_write_ref bch2_do_discards_work [bcachefs]
> 20:18:30 kernel: pc : bch2_trans_unlock_long+0x258/0x270 [bcachefs]
> 20:18:30 kernel: lr : bch2_trans_unlock_long+0x258/0x270 [bcachefs]
> 20:18:30 kernel: Call trace:
> 20:18:30 kernel:  bch2_trans_unlock_long+0x258/0x270 [bcachefs] (P)
> 20:18:30 kernel:  bch2_trans_begin+0x488/0x5a8 [bcachefs]
> 20:18:30 kernel:  bch2_do_discards+0x1b8/0x7e8 [bcachefs]
> 20:18:30 kernel:  bch2_do_discards_work+0x28/0x50 [bcachefs]
> 20:18:30 kernel:  process_one_work+0x188/0x520
> 20:18:30 kernel:  worker_thread+0x194/0x2f8
> 20:18:30 kernel:  kthread+0x11c/0x140
> 20:18:30 kernel:  ret_from_fork+0x10/0x20
> 20:18:30 kernel: ---[ end trace 0000000000000000 ]---
> 20:19:01 kernel: ------------[ cut here ]------------
> 20:19:01 kernel: btree trans held srcu lock (delaying memory reclaim) for 30 seconds
> 20:19:01 kernel: WARNING: src/fs/bcachefs/btree/locking.c:1055 at bch2_trans_unlock_long+0x258/0x270 [bcachefs], CPU#1: kworker/1:1/6027

I get this same warning 6 times total, with the do_discards call trace.
Some more errors happen:

> 20:25:10 kernel: bcachefs : check_inodes...
> 20:25:10 kernel: bcachefs (dev/sda): error reading superblock: EBUSY
> 20:25:10 kernel: error starting filesystem: EBUSY
> 20:25:10 kernel: bcachefs: bch2_fs_get_tree() error: EBUSY
> 20:28:20 kernel: bcachefs (dev/sda): error reading superblock: EBUSY
> 20:28:20 kernel: error starting filesystem: EBUSY
> 20:28:20 kernel: bcachefs: bch2_fs_get_tree() error: EBUSY

Eventually we make it through the fsck.
I'm able to use the filesystem, watch a big video file.
But the 2nd video file I try to watch, it stalls out, and I get a warning.

> 20:38:21 kernel: btree trans held srcu lock (delaying memory reclaim) for 121 seconds
> 20:38:21 kernel: WARNING: src/fs/bcachefs/btree/locking.c:1055 at bch2_trans_unlock_long+0x258/0x270
> 20:38:21 kernel: Call trace:
> 20:38:21 kernel:  bch2_trans_unlock_long+0x258/0x270 [bcachefs] (P)
> 20:38:21 kernel:  bch2_trans_begin+0x488/0x5a8 [bcachefs]
> 20:38:21 kernel:  bchfs_read+0x18c/0x600 [bcachefs]
> 20:38:21 kernel:  bch2_readahead+0x2b0/0x4f0 [bcachefs]
> 20:38:21 kernel:  read_pages+0x70/0x2d8

After some minutes of loading I can watch the 2nd video.

---

With the v1 patchset, CBS was working fine. But perhaps surfacing the bug has
to do with how many / what type of commands are issued to the drives.

Thanks,
Tommy

