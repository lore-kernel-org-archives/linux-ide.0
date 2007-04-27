From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: sata_mv BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Date: Fri, 27 Apr 2007 12:20:44 +0200
Message-ID: <4631CE7C.3000703@wpkg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000808070004080107070709"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:33267 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbXD0K4L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Apr 2007 06:56:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id 25A115C51D
	for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2007 12:21:58 +0200 (CEST)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03813-15 for <linux-ide@vger.kernel.org>;
 Fri, 27 Apr 2007 12:21:25 +0200 (CEST)
Received: from postfix1.syneticon.net (postfix1.syneticon.net [192.168.112.6])
	by mail2.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2007 12:21:25 +0200 (CEST)
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by postfix1.syneticon.net (Postfix) with ESMTP id EEC2A9487
	for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2007 12:21:42 +0200 (CEST)
Received: from postfix1.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id Mlzp66pdL-BR for <linux-ide@vger.kernel.org>;
	Fri, 27 Apr 2007 10:16:51 +0000 (UTC)
Received: from [192.168.10.145] (xdsl-87-78-250-190.netcologne.de [87.78.250.190])
	by postfix1.syneticon.net (Postfix) with ESMTP
	for <linux-ide@vger.kernel.org>; Fri, 27 Apr 2007 12:21:32 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000808070004080107070709
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Today at night, I had a serious sata_mv driver failure on one of the 
servers.

I tested the drive in question with both smart and badblocks, but none 
shown any errors - so my quick conclusion is that something is not right 
with the sata_mv driver.


The server has two drives; sda1 and sdb1 are connected into a RAID-1 
array. 38 seconds after the failure started to happen, sda1 was kicked 
out of RAID-1.

The server is also running IET (iSCSI Enterprise Target) from 
http://iscsi-target.sf.net - unfortunately, most iSCSI initiators didn't 
survive this failure, and were remounted ro.


I attach the log, perhaps it gives some more info to some of you? I hope 
the log is not too big for this list (~50 kB).

execute_task_management, cmnd_abort and sess_param come from the 
iscsi_trgt driver (IET).


The machine is running 2.6.20.1 x86 kernel from the moment it was 
released, and there were never problems like that before.


After 2.6.20.1, sata_mv had following fixes according to the kernel 
changelog:

2.6.20.5: Fix 50xx irq mask
2.6.20.5: don't touch reserved bits in EDMA config register

2.6.21: don't touch reserved bits in EDMA config register
2.6.21: fix pci_enable_msi() error handling
2.6.21: drivers/ata/sata_mv.c:2056:55: warning: Using plain integer as 
NULL pointer

So basically, there were two important fixes, which first went to the 
kernel in 2.6.20.5.


Is it possible that the issue was fixes then? Or, perhaps, there is 
another explanation for that?


-- 
Tomasz Chmielewski

--------------000808070004080107070709
Content-Type: text/x-log;
 name="broken.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="broken.log"

Apr 27 03:34:59 st kernel: ATA: abnormal status 0x7F on port 0xD092211C
Apr 27 03:34:59 st kernel: ATA: abnormal status 0x7F on port 0xD092211C
Apr 27 03:34:59 st kernel: ata1: translated ATA stat/err 0x7f/00 to SCSI SK/ASC/ASCQ 0x4/00/00
Apr 27 03:34:59 st kernel: ata1: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Apr 27 03:35:00 st kernel: ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 0xb/47/00
Apr 27 03:35:00 st kernel: ata1: status=0x80 { Busy }
Apr 27 03:35:00 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:35:00 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:35:00 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:35:00 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:35:00 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:35:00 st kernel:  [<c0110b35>] scheduler_tick+0xa/0x4d
Apr 27 03:35:00 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:35:00 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:35:00 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:35:00 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:35:00 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:35:00 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:35:00 st kernel:  [<c020a92b>] scsi_queue_insert+0x4d/0x53
Apr 27 03:35:00 st kernel:  [<c0196603>] blk_done_softirq+0x4a/0x55
Apr 27 03:35:00 st kernel:  [<c01164d4>] __do_softirq+0x35/0x75
Apr 27 03:35:00 st kernel:  [<c0116536>] do_softirq+0x22/0x26
Apr 27 03:35:00 st kernel:  [<c0104e32>] do_IRQ+0x61/0x73
Apr 27 03:35:00 st kernel:  [<c0113c48>] profile_tick+0x39/0x55
Apr 27 03:35:00 st kernel:  [<c01034ab>] common_interrupt+0x23/0x28
Apr 27 03:35:00 st kernel:  [<c0101b10>] default_idle+0x27/0x39
Apr 27 03:35:00 st kernel:  [<c0101326>] cpu_idle+0x39/0x4e
Apr 27 03:35:00 st kernel:  [<c031e69e>] start_kernel+0x2ee/0x2f2
Apr 27 03:35:00 st kernel:  [<c031e1ae>] unknown_bootoption+0x0/0x202
Apr 27 03:35:00 st kernel:  =======================
Apr 27 03:35:29 st kernel: execute_task_management(1212) b0a0040 1 40000067
Apr 27 03:35:29 st kernel: cmnd_abort(1143) 67000040 1 0 42 8192 0 0
Apr 27 03:35:30 st kernel: execute_task_management(1212) 50a0030 1 30000035
Apr 27 03:35:30 st kernel: cmnd_abort(1143) 35000030 1 0 42 8192 0 0
Apr 27 03:35:31 st kernel: execute_task_management(1212) 1f0a0000 1 10
Apr 27 03:35:31 st kernel: cmnd_abort(1143) 10000000 1 0 42 8192 0 0
Apr 27 03:35:31 st kernel: execute_task_management(1212) 1f0a0000 1 48
Apr 27 03:35:31 st kernel: cmnd_abort(1143) 48000000 1 0 42 4096 0 0
Apr 27 03:35:33 st kernel: execute_task_management(1212) 80a0030 1 3000004f
Apr 27 03:35:33 st kernel: cmnd_abort(1143) 4f000030 1 0 42 4096 0 0
Apr 27 03:35:34 st kernel: execute_task_management(1212) 40a0050 1 50000012
Apr 27 03:35:34 st kernel: cmnd_abort(1143) 12000050 1 0 42 4096 0 0
Apr 27 03:35:37 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:35:37 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:35:37 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:35:37 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:35:37 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:35:37 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:35:37 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:35:37 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:35:37 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:35:37 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:35:37 st kernel:         00 80 80 80 
Apr 27 03:35:37 st kernel: end_request: I/O error, dev sda, sector 93628215
Apr 27 03:35:37 st kernel: raid1: Disk failure on sda1, disabling device. 
Apr 27 03:35:37 st kernel: ^IOperation continuing on 1 devices
Apr 27 03:35:37 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:35:37 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:35:37 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:35:37 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:35:37 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:35:37 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:35:37 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:35:37 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:35:37 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:35:37 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:35:37 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:35:37 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:35:37 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:35:37 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:35:37 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:35:37 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:35:37 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:35:37 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:35:37 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:35:37 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:35:37 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:35:37 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:35:37 st kernel:  =======================
Apr 27 03:35:37 st kernel: execute_task_management(1212) 170a0000 1 16
Apr 27 03:35:37 st kernel: cmnd_abort(1143) 16000000 1 0 40 0 0 0
Apr 27 03:35:37 st kernel: execute_task_management(1212) 30a0030 1 30000001
Apr 27 03:35:37 st kernel: cmnd_abort(1143) 1000030 1 0 40 0 0 0
Apr 27 03:35:39 st kernel: execute_task_management(1212) 1f0a0000 1 22
Apr 27 03:35:39 st kernel: cmnd_abort(1143) 22000000 1 0 42 4096 0 0
Apr 27 03:35:40 st kernel: execute_task_management(1212) 120a0020 1 20000026
Apr 27 03:35:40 st kernel: cmnd_abort(1143) 26000020 1 0 42 4096 0 0
Apr 27 03:35:40 st kernel: execute_task_management(1212) 1f0a0000 1 9
Apr 27 03:35:40 st kernel: cmnd_abort(1143) 9000000 1 0 42 8192 0 0
Apr 27 03:35:40 st kernel: execute_task_management(1212) 1f0a0000 1 22
Apr 27 03:35:40 st kernel: cmnd_abort(1143) 22000000 1 0 42 4096 0 0
Apr 27 03:35:42 st kernel: execute_task_management(1212) 1f0a0000 1 3e
Apr 27 03:35:42 st kernel: cmnd_abort(1143) 3e000000 1 0 42 4096 0 0
Apr 27 03:35:44 st kernel: execute_task_management(1212) 10a0000 1 75
Apr 27 03:35:44 st kernel: cmnd_abort(1143) 75000000 1 0 42 4096 0 0
Apr 27 03:35:55 st kernel: execute_task_management(1212) 1f0a0000 1 52
Apr 27 03:35:55 st kernel: cmnd_abort(1143) 52000000 1 0 42 16384 0 0
Apr 27 03:36:06 st kernel: execute_task_management(1212) 40a0010 1 10000058
Apr 27 03:36:06 st kernel: cmnd_abort(1143) 58000010 1 0 42 8192 0 0
Apr 27 03:36:07 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:36:07 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:36:07 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:36:07 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:36:07 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:36:07 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:36:07 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:36:07 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:36:07 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:36:07 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:36:07 st kernel:         00 80 80 80 
Apr 27 03:36:07 st kernel: end_request: I/O error, dev sda, sector 36602303
Apr 27 03:36:07 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:36:07 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:36:07 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:36:07 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:36:07 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:36:07 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:36:07 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:36:07 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:36:07 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:36:07 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:36:07 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:36:07 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:36:07 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:07 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:36:07 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:36:07 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:36:07 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:36:07 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:07 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:07 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:36:07 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:36:07 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:36:07 st kernel:  =======================
Apr 27 03:36:38 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:36:38 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:36:38 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:36:38 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:36:38 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:36:38 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:36:38 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:36:38 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:36:38 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:36:38 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:36:38 st kernel:         00 80 80 80 
Apr 27 03:36:38 st kernel: end_request: I/O error, dev sda, sector 35553727
Apr 27 03:36:38 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:36:38 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:36:38 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:36:38 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:36:38 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:36:38 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:36:38 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:36:38 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:36:38 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:36:38 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:36:38 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:36:38 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:36:38 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:38 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:36:38 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:36:38 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:36:38 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:36:38 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:38 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:36:38 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:36:38 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:36:38 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:36:38 st kernel:  =======================
Apr 27 03:37:09 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:37:09 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:37:09 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:37:09 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:37:09 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:37:09 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:37:09 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:37:09 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:37:09 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:37:09 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:37:09 st kernel:         00 80 80 80 
Apr 27 03:37:09 st kernel: end_request: I/O error, dev sda, sector 56440751
Apr 27 03:37:09 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:37:09 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:37:09 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:37:09 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:37:09 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:37:09 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:37:09 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:37:09 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:37:09 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:37:09 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:37:09 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:37:09 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:37:09 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:09 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:37:09 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:37:09 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:37:09 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:37:09 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:09 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:09 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:37:09 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:37:09 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:37:09 st kernel:  =======================
Apr 27 03:37:39 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:37:39 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:37:39 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:37:39 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:37:39 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:37:39 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:37:39 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:37:39 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:37:39 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:37:39 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:37:39 st kernel:         00 80 80 80 
Apr 27 03:37:39 st kernel: end_request: I/O error, dev sda, sector 94937535
Apr 27 03:37:39 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:37:39 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:37:39 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:37:39 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:37:39 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:37:39 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:37:39 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:37:39 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:37:39 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:37:39 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:37:39 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:37:39 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:37:39 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:39 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:37:39 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:37:39 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:37:39 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:37:39 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:39 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:37:39 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:37:39 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:37:39 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:37:39 st kernel:  =======================
Apr 27 03:38:10 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:38:10 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:38:10 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:38:10 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:38:10 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:38:10 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:38:10 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:38:10 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:38:10 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:38:10 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:38:10 st kernel:         00 80 80 80 
Apr 27 03:38:10 st kernel: end_request: I/O error, dev sda, sector 94937887
Apr 27 03:38:10 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:38:10 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:38:10 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:38:10 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:38:10 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:38:10 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:38:10 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:38:10 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:38:10 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:38:10 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:38:10 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:38:10 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:38:10 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:10 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:38:10 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:38:10 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:38:10 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:38:10 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:10 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:10 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:38:10 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:38:10 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:38:10 st kernel:  =======================
Apr 27 03:38:41 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:38:41 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:38:41 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:38:41 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:38:41 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:38:41 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:38:41 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:38:41 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:38:41 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:38:41 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:38:41 st kernel:         00 80 80 80 
Apr 27 03:38:41 st kernel: end_request: I/O error, dev sda, sector 22886031
Apr 27 03:38:41 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:38:41 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:38:41 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:38:41 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:38:41 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:38:41 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:38:41 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:38:41 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:38:41 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:38:41 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:38:41 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:38:41 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:38:41 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:41 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:38:41 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:38:41 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:38:41 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:38:41 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:41 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:38:41 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:38:41 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:38:41 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:38:41 st kernel:  =======================
Apr 27 03:39:11 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:39:11 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:39:11 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:39:11 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:39:11 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:39:11 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:39:11 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:39:11 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:39:11 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:39:11 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:39:11 st kernel:         00 80 80 80 
Apr 27 03:39:11 st kernel: end_request: I/O error, dev sda, sector 61709151
Apr 27 03:39:11 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:39:11 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:39:11 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:39:11 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:39:11 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:39:11 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:39:11 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:39:11 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:39:11 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:39:11 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:39:11 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:39:11 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:39:11 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:11 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:39:11 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:39:11 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:39:11 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:39:11 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:11 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:11 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:39:11 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:39:11 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:39:11 st kernel:  =======================
Apr 27 03:39:42 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:39:42 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:39:42 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:39:42 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:39:42 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:39:42 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:39:42 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:39:42 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:39:42 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:39:42 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:39:42 st kernel:         00 80 80 80 
Apr 27 03:39:42 st kernel: end_request: I/O error, dev sda, sector 94937903
Apr 27 03:39:42 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:39:42 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:39:42 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:39:42 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:39:42 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:39:42 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:39:42 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:39:42 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:39:42 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:39:42 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:39:42 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:39:42 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:39:42 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:42 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:39:42 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:39:42 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:39:42 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:39:42 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:42 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:39:42 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:39:42 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:39:42 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:39:42 st kernel:  =======================
Apr 27 03:40:13 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:40:13 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:40:13 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:40:13 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:40:13 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:40:13 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:40:13 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:40:13 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:40:13 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:40:13 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:40:13 st kernel:         00 80 80 80 
Apr 27 03:40:13 st kernel: end_request: I/O error, dev sda, sector 17234399
Apr 27 03:40:13 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:40:13 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:40:13 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:40:13 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:40:13 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:40:13 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:40:13 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:40:13 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:40:13 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:40:13 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:40:13 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:40:13 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:40:13 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:13 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:40:13 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:40:13 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:40:13 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:40:13 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:13 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:13 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:40:13 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:40:13 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:40:13 st kernel:  =======================
Apr 27 03:40:43 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:40:43 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:40:43 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:40:43 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:40:43 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:40:43 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:40:43 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:40:43 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:40:43 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:40:43 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:40:43 st kernel:         00 80 80 80 
Apr 27 03:40:43 st kernel: end_request: I/O error, dev sda, sector 22585591
Apr 27 03:40:43 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:40:43 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:40:43 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:40:43 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:40:43 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:40:43 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:40:43 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:40:43 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:40:43 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:40:43 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:40:43 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:40:43 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:40:43 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:43 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:40:43 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:40:43 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:40:43 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:40:43 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:43 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:40:43 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:40:43 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:40:43 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:40:43 st kernel:  =======================
Apr 27 03:41:14 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:41:14 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:41:14 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:41:14 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:41:14 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:41:14 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:41:14 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:41:14 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:41:14 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:41:14 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:41:14 st kernel:         00 80 80 80 
Apr 27 03:41:14 st kernel: end_request: I/O error, dev sda, sector 94938655
Apr 27 03:41:14 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:41:14 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:41:14 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:41:14 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:41:14 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:41:14 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:41:14 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:41:14 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:41:14 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:41:14 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:41:14 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:41:14 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:41:14 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:14 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:41:14 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:41:14 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:41:14 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:41:14 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:14 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:14 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:41:14 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:41:14 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:41:14 st kernel:  =======================
Apr 27 03:41:44 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:41:44 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:41:44 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:41:44 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:41:44 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:41:44 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:41:44 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:41:44 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:41:44 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:41:44 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:41:44 st kernel:         00 80 80 80 
Apr 27 03:41:44 st kernel: end_request: I/O error, dev sda, sector 206268759
Apr 27 03:41:44 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:41:44 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:41:44 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:41:44 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:41:44 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:41:44 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:41:44 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:41:44 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:41:44 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:41:44 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:41:44 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:41:44 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:41:44 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:44 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:41:44 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:41:44 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:41:44 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:41:44 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:44 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:41:44 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:41:44 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:41:44 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:41:44 st kernel:  =======================
Apr 27 03:42:15 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:42:15 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:42:15 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:42:15 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:42:15 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:42:15 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:42:15 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:42:15 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:42:15 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:42:15 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:42:15 st kernel:         00 80 80 80 
Apr 27 03:42:15 st kernel: end_request: I/O error, dev sda, sector 206269839
Apr 27 03:42:15 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:42:15 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:42:15 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:42:15 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:42:15 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:42:15 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:42:15 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:42:15 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:42:15 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:42:15 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:42:15 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:42:15 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:42:15 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:15 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:42:15 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:42:15 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:42:15 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:42:15 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:15 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:15 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:42:15 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:42:15 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:42:15 st kernel:  =======================
Apr 27 03:42:46 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:42:46 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:42:46 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:42:46 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:42:46 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:42:46 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:42:46 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:42:46 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:42:46 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:42:46 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:42:46 st kernel:         00 80 80 80 
Apr 27 03:42:46 st kernel: end_request: I/O error, dev sda, sector 246047223
Apr 27 03:42:46 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:42:46 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:42:46 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:42:46 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:42:46 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:42:46 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:42:46 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:42:46 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:42:46 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:42:46 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:42:46 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:42:46 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:42:46 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:46 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:42:46 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:42:46 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:42:46 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:42:46 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:46 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:42:46 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:42:46 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:42:46 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:42:46 st kernel:  =======================
Apr 27 03:43:16 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:43:16 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:43:16 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:43:16 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:43:16 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:43:16 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:43:16 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:43:16 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:43:16 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:43:16 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:43:16 st kernel:         00 80 80 80 
Apr 27 03:43:16 st kernel: end_request: I/O error, dev sda, sector 252076743
Apr 27 03:43:16 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:43:16 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:43:16 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:43:16 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:43:16 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:43:16 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:43:16 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:43:16 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:43:16 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:43:16 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:43:16 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:43:16 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:43:16 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:16 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:43:16 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:43:16 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:43:16 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:43:16 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:16 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:16 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:43:16 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:43:16 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:43:16 st kernel:  =======================
Apr 27 03:43:47 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:43:47 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:43:47 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:43:47 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:43:47 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:43:47 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:43:47 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:43:47 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:43:47 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:43:47 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:43:47 st kernel:         00 80 80 80 
Apr 27 03:43:47 st kernel: end_request: I/O error, dev sda, sector 256795127
Apr 27 03:43:47 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:43:47 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:43:47 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:43:47 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:43:47 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:43:47 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:43:47 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:43:47 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:43:47 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:43:47 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:43:47 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:43:47 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:43:47 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:47 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:43:47 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:43:47 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:43:47 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:43:47 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:47 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:43:47 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:43:47 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:43:47 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:43:47 st kernel:  =======================
Apr 27 03:44:18 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:44:18 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd cfa50080 &cmnd cfa500b8
Apr 27 03:44:18 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:44:18 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:44:18 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:44:18 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:44:18 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:44:18 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:44:18 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:44:18 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:44:18 st kernel:         00 80 80 80 
Apr 27 03:44:18 st kernel: end_request: I/O error, dev sda, sector 256811511
Apr 27 03:44:18 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:44:18 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:44:18 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:44:18 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:44:18 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:44:18 st kernel:  [<c020f59a>] sd_rw_intr+0x15d/0x186
Apr 27 03:44:18 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:44:18 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:44:18 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:44:18 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:44:18 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:44:18 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:44:18 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:18 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:44:18 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:44:18 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:44:18 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:44:18 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:18 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:18 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:44:18 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:44:18 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:44:18 st kernel:  =======================
Apr 27 03:44:48 st kernel: ata1: Entering mv_eng_timeout
Apr 27 03:44:48 st kernel: mmio_base d0900000 ap cfb602bc qc cfb60cdc scsi_cmnd ce09ae40 &cmnd ce09ae78
Apr 27 03:44:48 st kernel: ata1: no sense translation for status: 0x40
Apr 27 03:44:48 st kernel: ata1: translated ATA stat/err 0x40/00 to SCSI SK/ASC/ASCQ 0xb/00/00
Apr 27 03:44:48 st kernel: ata1: status=0x40 { DriveReady }
Apr 27 03:44:48 st kernel: sd 0:0:0:0: SCSI error: return code = 0x08000002
Apr 27 03:44:48 st kernel: sda: Current [descriptor]: sense key=0xb
Apr 27 03:44:48 st kernel:     ASC=0x0 ASCQ=0x0
Apr 27 03:44:48 st kernel: Descriptor sense data with sense descriptors (in hex):
Apr 27 03:44:48 st kernel:         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Apr 27 03:44:48 st kernel:         00 80 80 80 
Apr 27 03:44:48 st kernel: end_request: I/O error, dev sda, sector 5506991
Apr 27 03:44:48 st kernel: BUG: at drivers/ata/sata_mv.c:1236 mv_qc_issue()
Apr 27 03:44:48 st kernel:  [<c021be6b>] mv_qc_issue+0x97/0x10b
Apr 27 03:44:48 st kernel:  [<c0212923>] ata_qc_issue+0x425/0x47b
Apr 27 03:44:48 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:44:48 st kernel:  [<c0217204>] ata_scsi_translate+0xb5/0xfb
Apr 27 03:44:48 st kernel:  [<c0206fac>] scsi_done+0x0/0x16
Apr 27 03:44:48 st kernel:  [<c0218430>] ata_scsi_queuecmd+0x107/0x10e
Apr 27 03:44:48 st kernel:  [<c0216571>] ata_scsi_rw_xlat+0x0/0x1b6
Apr 27 03:44:48 st kernel:  [<c02073d9>] scsi_dispatch_cmd+0x17a/0x1b5
Apr 27 03:44:48 st kernel:  [<c020b1ae>] scsi_request_fn+0x1f2/0x273
Apr 27 03:44:48 st kernel:  [<c01957ed>] blk_remove_plug+0x4e/0x5a
Apr 27 03:44:48 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:48 st kernel:  [<c01966ca>] blk_run_queue+0x2a/0x4b
Apr 27 03:44:48 st kernel:  [<c020a882>] scsi_run_host_queues+0x10/0x22
Apr 27 03:44:48 st kernel:  [<c0209a25>] scsi_error_handler+0x55a/0x590
Apr 27 03:44:48 st kernel:  [<c010fba4>] __wake_up_common+0x31/0x4f
Apr 27 03:44:48 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:48 st kernel:  [<c02094cb>] scsi_error_handler+0x0/0x590
Apr 27 03:44:48 st kernel:  [<c0120ab4>] kthread+0xa0/0xc8
Apr 27 03:44:48 st kernel:  [<c0120a14>] kthread+0x0/0xc8
Apr 27 03:44:48 st kernel:  [<c010362b>] kernel_thread_helper+0x7/0x10
Apr 27 03:44:48 st kernel:  =======================
Apr 27 03:44:48 st kernel: sess_param(173) 1 1 1 8192 8192 262144 65536 2 0 1 1 1 0 1 1
Apr 27 03:44:49 st last message repeated 25 times
Apr 27 03:44:49 st kernel: RAID1 conf printout:
Apr 27 03:44:49 st kernel:  --- wd:1 rd:2
Apr 27 03:44:49 st kernel:  disk 0, wo:1, o:0, dev:sda1
Apr 27 03:44:49 st kernel:  disk 1, wo:0, o:1, dev:sdb1
Apr 27 03:44:49 st kernel: sess_param(173) 1 1 1 8192 8192 262144 65536 2 0 1 1 1 0 1 1
Apr 27 03:44:49 st last message repeated 3 times
Apr 27 03:44:49 st kernel: RAID1 conf printout:
Apr 27 03:44:49 st kernel:  --- wd:1 rd:2
Apr 27 03:44:49 st kernel:  disk 1, wo:0, o:1, dev:sdb1
Apr 27 03:44:49 st kernel: sess_param(173) 1 1 1 8192 8192 262144 65536 2 0 1 1 1 0 1 1
Apr 27 03:45:15 st last message repeated 102 times

--------------000808070004080107070709--
