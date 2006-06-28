From: Albert Lee <albertcc@tw.ibm.com>
Subject: libata new EH issue - ATAPI device error not properly reported
Date: Wed, 28 Jun 2006 16:27:34 +0800
Message-ID: <44A23D76.30307@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:41898 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161083AbWF1I1l
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 04:27:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5S8Rfuv003723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 04:27:41 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5S8RvLk186472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 02:27:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5S8RdlZ007505
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 02:27:40 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@bebe.enoyolf.org>

Hi Tejun,

Unicorn is doing some test with the current upstream branch and something
looks strange in the log.

With the new EH, when the ATAPI device reports dev_status 0x51,
the err_mask is reported as 0x0. This does not look right.
Maybe we should report AC_ERR_DEV error back to the upper layers?
(Test log attached for your review.)

--
albert

============================================================================================
(Test log with new EH.
Error transaction with 0x51 dev_status)

Jun 27 18:10:57 xlinux19 kernel: ata_scsi_dump_cdb: CDB (3:0,0,0) 1e 00 00 00 01 00 00 00 00
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_translate: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata3: ata_dev_select: ENTER, ata3: device 0, wait 1
Jun 27 18:10:57 xlinux19 kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 18:10:57 xlinux19 kernel: ata_tf_load_pio: device 0xA0
Jun 27 18:10:57 xlinux19 kernel: ata_exec_command_pio: ata3: cmd 0xA0
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_translate: EXIT
Jun 27 18:10:57 xlinux19 kernel: ata_host_intr: ata3: protocol 6 task_state 5
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 5 (dev_stat 0x58)
Jun 27 18:10:57 xlinux19 kernel: atapi_send_cdb: send cdb
Jun 27 18:10:57 xlinux19 kernel: ata_host_intr: ata3: protocol 6 task_state 3
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 3 (dev_stat 0x51) <== device cannot do it
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 4 (dev_stat 0x51) 
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_timed_out: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_timed_out: EXIT, ret=0
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_error: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_port_flush_task: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_port_flush_task: flush #1
Jun 27 18:10:57 xlinux19 kernel: ata_eh_autopsy: ENTER
Jun 27 18:10:57 xlinux19 kernel: atapi_eh_request_sense: ATAPI request sense
Jun 27 18:10:57 xlinux19 kernel: ata3: ata_dev_select: ENTER, ata3: device 0, wait 1
Jun 27 18:10:57 xlinux19 kernel: ata_tf_load_pio: feat 0x64 nsect 0x3 lba 0x0 0x0 0x20
Jun 27 18:10:57 xlinux19 kernel: ata_tf_load_pio: device 0xA0
Jun 27 18:10:57 xlinux19 kernel: ata_exec_command_pio: ata3: cmd 0xA0
Jun 27 18:10:57 xlinux19 kernel: ata_host_intr: ata3: protocol 5 task_state 5
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 5 task_state 5 (dev_stat 0x58)
Jun 27 18:10:57 xlinux19 kernel: atapi_send_cdb: send cdb
Jun 27 18:10:57 xlinux19 kernel: ata_host_intr: ata3: protocol 5 task_state 2
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 5 task_state 2 (dev_stat 0x58)
Jun 27 18:10:57 xlinux19 kernel: atapi_pio_bytes: ata3: xfering 18 bytes
Jun 27 18:10:57 xlinux19 kernel: __atapi_pio_bytes: data read
Jun 27 18:10:57 xlinux19 kernel: ata_host_intr: ata3: protocol 5 task_state 2
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 5 task_state 2 (dev_stat 0x50)
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: protocol 5 task_state 3 (dev_stat 0x50)
Jun 27 18:10:57 xlinux19 kernel: ata_hsm_move: ata3: dev 0 command complete, drv_stat 0x50
Jun 27 18:10:57 xlinux19 kernel: ata_port_flush_task: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_port_flush_task: flush #1
Jun 27 18:10:57 xlinux19 kernel: ata_eh_autopsy: EXIT
Jun 27 18:10:57 xlinux19 kernel: ata_eh_recover: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_eh_revalidate_and_attach: ENTER
Jun 27 18:10:57 xlinux19 kernel: ata_eh_revalidate_and_attach: EXIT
Jun 27 18:10:57 xlinux19 kernel: ata_eh_recover: EXIT, rc=0
Jun 27 18:10:57 xlinux19 kernel: atapi_qc_complete: ENTER, err_mask 0x0  <== Doesn't look right. Should report error.
Jun 27 18:10:57 xlinux19 kernel: ata_scsi_error: EXIT

===============================================================================================
(Test log with new EH.
Normal transaction.)

Jun 27 18:11:02 xlinux19 kernel: ata_scsi_dump_cdb: CDB (3:0,0,0) 1e 00 00 00 01 00 00 00 00
Jun 27 18:11:02 xlinux19 kernel: ata_scsi_translate: ENTER
Jun 27 18:11:02 xlinux19 kernel: ata3: ata_dev_select: ENTER, ata3: device 0, wait 1
Jun 27 18:11:02 xlinux19 kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 18:11:02 xlinux19 kernel: ata_tf_load_pio: device 0xA0
Jun 27 18:11:02 xlinux19 kernel: ata_exec_command_pio: ata3: cmd 0xA0
Jun 27 18:11:02 xlinux19 kernel: ata_scsi_translate: EXIT
Jun 27 18:11:02 xlinux19 kernel: ata_host_intr: ata3: protocol 6 task_state 5
Jun 27 18:11:02 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 5 (dev_stat 0x58)
Jun 27 18:11:02 xlinux19 kernel: atapi_send_cdb: send cdb
Jun 27 18:11:02 xlinux19 kernel: ata_host_intr: ata3: protocol 6 task_state 3
Jun 27 18:11:02 xlinux19 kernel: ata_hsm_move: ata3: protocol 6 task_state 3 (dev_stat 0x50)
Jun 27 18:11:02 xlinux19 kernel: ata_hsm_move: ata3: dev 0 command complete, drv_stat 0x50
Jun 27 18:11:02 xlinux19 kernel: atapi_qc_complete: ENTER, err_mask 0x0    <== Everything is fine.


