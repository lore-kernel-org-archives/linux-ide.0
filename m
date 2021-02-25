Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA065C43381
	for <linux-ide@archiver.kernel.org>; Thu, 25 Feb 2021 22:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C464E83
	for <linux-ide@archiver.kernel.org>; Thu, 25 Feb 2021 22:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBYWsU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 25 Feb 2021 17:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbhBYWsT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 25 Feb 2021 17:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614293212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=G1drA3UFDqdiqdbIwoMwc6KQ+nh7S59hCx8uMqafaGY=;
        b=f16zBZnVc2c3Kz/jPUh7uwDtQoPFcn0v5tR62+A7dWZftW1jqxPlO1e75R1wipxBLZkVEb
        iODXXhKX95i378FSKwECe9fyvWuLcOD2VYIJ7Rws/7DXXUL4eRdkfk7HQ8Evg3NUXEDVj8
        qqnPSslYLhsaWKGgJ/eFDWSnSzQ9XFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-brv95CxDP7yiP7wOmBm2FA-1; Thu, 25 Feb 2021 17:46:50 -0500
X-MC-Unique: brv95CxDP7yiP7wOmBm2FA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EADEA106BC6B;
        Thu, 25 Feb 2021 22:46:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4A61A86B;
        Thu, 25 Feb 2021 22:46:48 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CA14C18095C7;
        Thu, 25 Feb 2021 22:46:48 +0000 (UTC)
Date:   Thu, 25 Feb 2021 17:46:47 -0500 (EST)
From:   Tony Asleson <tasleson@redhat.com>
To:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <640349190.32399497.1614293207910.JavaMail.zimbra@redhat.com>
In-Reply-To: <1400296846.32399218.1614292826918.JavaMail.zimbra@redhat.com>
Subject: WARNING: CPU: 11 PID: 7118 at drivers/ata/libata-core.c:4561
 __ata_qc_complete+0x102/0x120
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.112.124, 10.4.195.12]
Thread-Topic: WARNING: CPU: 11 PID: 7118 at drivers/ata/libata-core.c:4561 __ata_qc_complete+0x102/0x120
Thread-Index: e8sivIpafpURdDCGRn9Q8kH2aWWFxw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

New SATA disk drive (/dev/sde) install yesterday and was copying some
files to it when I ran into this.


Feb 25 13:22:57 kernel: sas: Enter sas_scsi_recover_host busy: 4 failed: 4
Feb 25 13:22:57 kernel: sas: trying to find task 0x0000000054c16ca6
Feb 25 13:22:57 kernel: sas: sas_scsi_find_task: aborting task 0x0000000054c16ca6
Feb 25 13:22:57 kernel: sas: sas_scsi_find_task: task 0x0000000054c16ca6 is aborted
Feb 25 13:22:57 kernel: sas: sas_eh_handle_sas_errors: task 0x0000000054c16ca6 is aborted
Feb 25 13:22:57 kernel: sas: trying to find task 0x000000003d036aed
Feb 25 13:22:57 kernel: sas: sas_scsi_find_task: aborting task 0x000000003d036aed
Feb 25 13:22:57 kernel: sas: sas_scsi_find_task: task 0x000000003d036aed is aborted
Feb 25 13:22:57 kernel: sas: sas_eh_handle_sas_errors: task 0x000000003d036aed is aborted
Feb 25 13:23:19 kernel: sas: trying to find task 0x000000001981ff45
Feb 25 13:23:19 kernel: sas: sas_scsi_find_task: aborting task 0x000000001981ff45
Feb 25 13:23:19 kernel: sas: sas_scsi_find_task: task 0x000000001981ff45 is aborted
Feb 25 13:23:19 kernel: sas: sas_eh_handle_sas_errors: task 0x000000001981ff45 is aborted
Feb 25 13:23:19 kernel: sas: trying to find task 0x0000000067682310
Feb 25 13:23:19 kernel: sas: sas_scsi_find_task: aborting task 0x0000000067682310
Feb 25 13:23:19 kernel: sas: sas_scsi_find_task: task 0x0000000067682310 is aborted
Feb 25 13:23:19 kernel: sas: sas_eh_handle_sas_errors: task 0x0000000067682310 is aborted
Feb 25 13:23:19 kernel: sas: ata7: end_device-7:0: cmd error handler
Feb 25 13:23:19 kernel: sas: ata7: end_device-7:0: dev error handler
Feb 25 13:23:19 kernel: ata7.00: exception Emask 0x0 SAct 0x780000 SErr 0x0 action 0x6 frozen
Feb 25 13:23:19 kernel: ata7.00: failed command: READ FPDMA QUEUED
Feb 25 13:23:19 kernel: ata7.00: cmd 60/f0:00:00:30:8f/07:00:04:00:00/40 tag 19 ncq dma 1040384 in
                                 res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Feb 25 13:23:19 kernel: ata7.00: status: { DRDY }
Feb 25 13:23:19 kernel: ata7.00: failed command: READ FPDMA QUEUED
Feb 25 13:23:19 kernel: ata7.00: cmd 60/10:00:f0:37:8f/02:00:04:00:00/40 tag 20 ncq dma 270336 in
                                 res 40/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Feb 25 13:23:19 kernel: ata7.00: status: { DRDY }
Feb 25 13:23:19 kernel: ata7.00: failed command: READ FPDMA QUEUED
Feb 25 13:23:19 kernel: ata7.00: cmd 60/98:00:00:3a:8f/03:00:04:00:00/40 tag 21 ncq dma 471040 in
                                 res 40/00:ff:ff:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
Feb 25 13:23:19 kernel: ata7.00: status: { DRDY }
Feb 25 13:23:19 kernel: ata7.00: failed command: WRITE FPDMA QUEUED
Feb 25 13:23:19 kernel: ata7.00: cmd 61/20:00:d0:c2:06/00:00:46:02:00/40 tag 22 ncq dma 16384 out
                                 res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4 (timeout)
Feb 25 13:23:19 kernel: ata7.00: status: { DRDY }
Feb 25 13:23:19 kernel: ata7: hard resetting link
Feb 25 13:23:19 kernel: sas: ata8: end_device-7:1: dev error handler
Feb 25 13:23:19 kernel: sas: ata9: end_device-7:2: dev error handler
Feb 25 13:23:19 kernel: drivers/scsi/mvsas/mv_sas.c 1417:mvs_I_T_nexus_reset for device[0]:rc= 0
Feb 25 13:23:19 kernel: sas: sas_ata_task_done: SAS error 0x8a
Feb 25 13:23:19 kernel: ------------[ cut here ]------------
Feb 25 13:23:19 kernel: WARNING: CPU: 11 PID: 7118 at drivers/ata/libata-core.c:4561 __ata_qc_complete+0x102/0x120
Feb 25 13:23:19 kernel: Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables ip6table_fil>
Feb 25 13:23:19 kernel:  crc32c_intel drm firewire_ohci ghash_clmulni_intel mvsas firewire_core uas tg3 crc_itu_t usb_storage libsas scsi_transport_sas wmi fuse
Feb 25 13:23:19 kernel: CPU: 11 PID: 7118 Comm: kworker/u34:0 Not tainted 5.10.16-200.fc33.x86_64 #1
Feb 25 13:23:19 kernel: Hardware name: LENOVO 4158D6U/Lenovo, BIOS 61KT50AUS 01/14/2014
Feb 25 13:23:19 kernel: Workqueue: events_unbound async_run_entry_fn
Feb 25 13:23:19 kernel: RIP: 0010:__ata_qc_complete+0x102/0x120
Feb 25 13:23:19 kernel: Code: 00 00 00 00 00 00 48 8b 45 50 eb 9c 8b 4d 68 8b 55 64 45 31 c0 48 8b bb 40 35 00 00 e8 17 41 93 ff 48 8b 45 50 e9 49 ff ff ff <0f> 0b e9 18 ff ff ff 0f 0b e9 05 ff ff ff 0f 0b e9 29 ff ff ff 66
Feb 25 13:23:19 kernel: RSP: 0018:ffffaa12c7a37b60 EFLAGS: 00010046
Feb 25 13:23:19 kernel: RAX: 0000000000010010 RBX: ffffaa12c7a37c48 RCX: 0000000000000010
Feb 25 13:23:19 kernel: RDX: 0000000000000046 RSI: ffff8d2d63d6dfe8 RDI: ffff8d2d63d6df30
Feb 25 13:23:19 kernel: RBP: ffff8d2d63d6df30 R08: ffff8d2d6736f3e0 R09: 0000000c23d6f9c0
Feb 25 13:23:19 kernel: R10: 0000000c23d6f9c0 R11: 00000000db7a0000 R12: ffff8d2d63d6e4c0
Feb 25 13:23:19 kernel: R13: 0000000000000001 R14: 0000000000000000 R15: ffff8d2d63d6c000
Feb 25 13:23:19 kernel: FS:  0000000000000000(0000) GS:ffff8d353fd40000(0000) knlGS:0000000000000000
Feb 25 13:23:19 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Feb 25 13:23:19 kernel: CR2: 00007fead0312080 CR3: 00000010a0a10006 CR4: 00000000000206e0
Feb 25 13:23:19 kernel: Call Trace:
Feb 25 13:23:19 kernel:  ata_exec_internal_sg+0x2b8/0x560
Feb 25 13:23:19 kernel:  ata_dev_read_id+0x3c5/0x460
Feb 25 13:23:19 kernel:  ata_dev_reread_id+0x38/0xc0
Feb 25 13:23:19 kernel:  ata_dev_revalidate+0x4d/0xb0
Feb 25 13:23:19 kernel:  ata_eh_recover+0x635/0x1330
Feb 25 13:23:19 kernel:  ? ata_eh_link_autopsy+0x411/0xbc0
Feb 25 13:23:19 kernel:  ? sas_ata_sched_eh+0x60/0x60 [libsas]
Feb 25 13:23:19 kernel:  ? sas_ata_prereset+0x50/0x50 [libsas]
Feb 25 13:23:19 kernel:  ? sas_ata_sched_eh+0x60/0x60 [libsas]
Feb 25 13:23:19 kernel:  ? sas_ata_prereset+0x50/0x50 [libsas]
Feb 25 13:23:19 kernel:  ata_do_eh+0x71/0xd0
Feb 25 13:23:19 kernel:  ata_scsi_port_error_handler+0x3cd/0x870
Feb 25 13:23:19 kernel:  async_sas_ata_eh+0x44/0x7b [libsas]
Feb 25 13:23:19 kernel:  async_run_entry_fn+0x39/0x160
Feb 25 13:23:19 kernel:  process_one_work+0x1b6/0x350
Feb 25 13:23:19 kernel:  worker_thread+0x53/0x3e0
Feb 25 13:23:19 kernel:  ? process_one_work+0x350/0x350
Feb 25 13:23:19 kernel:  kthread+0x11b/0x140
Feb 25 13:23:19 kernel:  ? __kthread_bind_mask+0x60/0x60
Feb 25 13:23:19 kernel:  ret_from_fork+0x22/0x30
Feb 25 13:23:19 kernel: ---[ end trace 62f71487916db9f9 ]---
Feb 25 13:23:19 kernel: ata7.00: failed to IDENTIFY (I/O error, err_mask=0x11)
Feb 25 13:23:19 kernel: ata7.00: revalidation failed (errno=-5)
Feb 25 13:23:19 kernel: ata7: hard resetting link
Feb 25 13:23:19 kernel: ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
Feb 25 13:23:19 kernel: ata7.00: revalidation failed (errno=-5)
Feb 25 13:23:19 kernel: ata7: hard resetting link
Feb 25 13:23:19 kernel: ata7.00: qc timeout (cmd 0xec)
Feb 25 13:23:19 kernel: ata7.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Feb 25 13:23:19 kernel: ata7.00: revalidation failed (errno=-5)
Feb 25 13:23:19 kernel: ata7.00: disabled
Feb 25 13:23:19 kernel: drivers/scsi/mvsas/mv_sas.c 1417:mvs_I_T_nexus_reset for device[0]:rc= 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#115 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=54s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#115 Sense Key : Not Ready [current]
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#115 Add. Sense: Logical unit not ready, hard reset required
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#115 CDB: Read(16) 88 00 00 00 00 00 04 8f 30 00 00 00 07 f0 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 76492800 op 0x0:(READ) flags 0x84700 phys_seg 64 prio class 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#116 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=54s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#116 Sense Key : Not Ready [current]
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#116 Add. Sense: Logical unit not ready, hard reset required
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#116 CDB: Read(16) 88 00 00 00 00 00 04 8f 37 f0 00 00 02 10 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 76494832 op 0x0:(READ) flags 0x80700 phys_seg 17 prio class 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#117 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=54s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#117 Sense Key : Not Ready [current]
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#117 Add. Sense: Logical unit not ready, hard reset required
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#117 CDB: Read(16) 88 00 00 00 00 00 04 8f 3a 00 00 00 03 98 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 76495360 op 0x0:(READ) flags 0x80700 phys_seg 30 prio class 0
Feb 25 13:23:19 kernel: ata7: EH complete
Feb 25 13:23:19 kernel: sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 4 tries: 1
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#922 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=51s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#922 CDB: Write(16) 8a 00 00 00 00 02 46 06 c2 d0 00 00 00 20 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 9764782800 op 0x1:(WRITE) flags 0x800 phys_seg 4 prio class 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#923 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#923 CDB: Write(16) 8a 00 00 00 00 02 a0 7b 08 00 00 00 00 08 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 11282352128 op 0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 0
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1410293760, lost async page write
Feb 25 13:23:19 kernel: Aborting journal on device sde1-8.
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#926 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#926 CDB: Write(16) 8a 00 00 00 00 02 a6 40 08 10 00 00 00 48 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 11379148816 op 0x1:(WRITE) flags 0x103000 phys_seg 9 prio class 0
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393346, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393347, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393348, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393349, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393350, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393351, lost async page write
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#927 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393352, lost async page write
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393353, lost async page write
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#927 CDB: Write(16) 8a 00 00 00 00 02 46 04 08 00 00 00 00 08 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 9764603904 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Feb 25 13:23:19 kernel: Buffer I/O error on dev sde1, logical block 1422393354, lost async page write
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 9764603904 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
Feb 25 13:23:19 kernel: JBD2: Error -5 detected when updating journal superblock for sde1-8.
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#928 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#928 CDB: Write(16) 8a 00 00 00 00 00 00 00 1d 38 00 00 00 08 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 7480 op 0x1:(WRITE) flags 0x103000 phys_seg 1 prio class 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#929 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#929 CDB: Write(16) 8a 00 00 00 00 01 53 00 13 f8 00 00 00 90 00 00
Feb 25 13:23:19 kernel: blk_update_request: I/O error, dev sde, sector 5687481336 op 0x1:(WRITE) flags 0x103000 phys_seg 18 prio class 0
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#930 FAILED Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
Feb 25 13:23:19 kernel: sd 7:0:0:0: [sde] tag#930 CDB: Read(16) 88 00 00 00 00 00 04 8f 30 00 00 00 00 08 00 00
Feb 25 13:23:19 kernel: EXT4-fs (sde1): Delayed block allocation failed for inode 152174593 at logical offset 97986880 with max blocks 2048 with error 30
Feb 25 13:23:19 kernel: EXT4-fs (sde1): This should not happen!! Data will be lost
Feb 25 13:23:19 kernel: EXT4-fs error (device sde1) in ext4_writepages:2814: Journal has aborted
Feb 25 13:23:19 kernel: EXT4-fs (sde1): I/O error while writing superblock
Feb 25 13:23:19 kernel: EXT4-fs (sde1): I/O error while writing superblock
Feb 25 13:23:19 kernel: EXT4-fs error (device sde1): ext4_journal_check_start:83: Detected aborted journal
Feb 25 13:23:19 kernel: EXT4-fs (sde1): Remounting filesystem read-only
Feb 25 13:23:19 kernel: EXT4-fs error (device sde1) in ext4_da_write_end:3117: IO failure
Feb 25 13:23:19 kernel: EXT4-fs (sde1): I/O error while writing superblock
Feb 25 13:23:19 kernel: mvsas 0000:01:00.0: Phy1 : No sig fis

