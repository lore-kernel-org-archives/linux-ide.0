From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/2] libata: Fix race condition in ata_pio_task()
Date: Mon, 27 Jun 2005 17:40:45 +0800
Message-ID: <42BFC99D.60304@tw.ibm.com>
References: <42BA775B.1050601@tw.ibm.com> <42BB826A.6040209@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040009010702000404060506"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:16878 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261991AbVF0JlM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jun 2005 05:41:12 -0400
In-Reply-To: <42BB826A.6040209@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040009010702000404060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

> 
> 
> This is patch 1/2. (The previous subject is incorrect. Resend it here.)
> Problem:
>    'assert(qc != NULL)' failed in ata_pio_block() and ata_pio_complete().
> 
> Root cause:
>    Race condition in ata_pio_task() when accessing 'ap->pio_task_state' 
> after ata_qc_complete():
> If the next command is queued after ata_qc_complete() and before 
> ata_pio_task() checks 'ap->pio_task_state',
> 'ap->pio_task_state' might have been changed from PIO_ST_IDLE to PIO_ST 
> by ata_qc_issue_prot().
> This will cause ata_pio_task() to run extra steps even if the command is 
> finished.
> The extra steps race with the next command and causing trouble.
> 

Attached please find the detailed debug trace with annotation for the problem.
Hopefully it can help to make the problem description clearer.


Albert

--------------040009010702000404060506
Content-Type: text/plain;
 name="debug_trace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug_trace.txt"

<3>ata_scsi_dump_cdb: CDB (1:0,0,0) be 00 00 04 0c b4 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 0, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xA0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT      
 
<== Oops! ata_pio_complete() does not return yet, and the next command comes in!
    The missing ata_pio_complete() will cause trouble later.

<3>ata_scsi_dump_cdb: CDB (1:0,1,0) be 00 00 04 0d 24 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 1, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xB0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT

<== This "READ CD" completed normally.

<3>ata_scsi_dump_cdb: CDB (1:0,1,0) be 00 00 04 0d 24 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 1, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xB0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT

<== This "READ CD" completed normally.

<3>ata_scsi_dump_cdb: CDB (1:0,0,0) be 00 00 04 0c b6 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 0, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xA0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>ata_pio_complete: EXIT   <== The previous missing ata_pio_complete().
                            <== Since pio_task_state was changed to 4 now, 
                            <== it will queue an extra ata_pio_task() and
                            <== starts racing with the current command.
<3>ata_pio_task: pio_task_state 4   (Oop! Extra ata_pio_task() queued!)
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>__atapi_pio_bytes: ata1: padding 2336 bytes  (Oop! extra data read!)
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT

<== The ata_pio_complete() was called twice!

<3>ata_scsi_dump_cdb: CDB (1:0,1,0) be 00 00 04 0d 26 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 1, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xB0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT
<3>ata_scsi_dump_cdb: CDB (1:0,0,0) be 00 00 04 0c b6 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 0, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xA0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT
<3>ata_scsi_dump_cdb: CDB (1:0,1,0) be 00 00 04 0d 26 00 00 01
<3>ata_scsi_translate: ENTER
<3>ata_dev_select: ENTER, ata1: device 1, wait 1
<3>ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
<3>ata_tf_load_pio: device 0xB0
<3>ata_exec_command_pio: ata1: cmd 0xA0
<3>ata_scsi_translate: EXIT
<3>atapi_packet_task: busy wait
<3>atapi_packet_task: send cdb
<3>atapi_packet_task: EXIT
<3>ata_pio_task: pio_task_state 4
<3>ata_pio_block: ENTER
<3>__atapi_pio_bytes: data read
<3>ata_pio_block: EXIT 2
<3>ata_pio_task: pio_task_state 5
<3>ata_pio_complete: ENTER
<3>ata_qc_complete: ENTER
<3>__ata_qc_complete: ENTER
<3>__ata_qc_complete: EXIT
<3>ata_qc_complete: EXIT
<3>ata_pio_complete: EXIT
<3>ata_pio_block: EXIT 2     

<== stopped in kdb. tcp/ip stack is victim.

[12]kdb> bt
Stack traceback for pid 13774
0xc000000123f60210    13774    13509  1   12   R  0xc000000123f606c0 *hxecom
          SP(esp)            PC(eip)      Function(args)
0xc0000001220eb4e0  0xc0000000002fff60  .skb_release_data +0x120
0xc0000001220eb4e0  0xc0000000002ffb74 (lr) .kfree_skbmem +0x20
0xc0000001220eb570  0xc0000000002ffb74  .kfree_skbmem +0x20
0xc0000001220eb600  0xc0000000002ffce8  .__kfree_skb +0x148
0xc0000001220eb6b0  0xc000000000339e2c  .tcp_recvmsg +0x6e8
0xc0000001220eb830  0xc0000000003631b8  .inet_recvmsg +0x58
--- Exception: c0000001220eb9d8:  NO_SYMBOL or Userspace
0xc0000001220ebb20  0xc00000021fcd1b80  NO_SYMBOL or Userspace +0x58
0xc0000001220ebb20  0xc0000000000cd2cc (lr) .fget +0x2c
0xc00000000006ffa0  0x7c2004ac38000000  NO_SYMBOL or Userspace
    kdb: Not a kernel-space address 0x60000000e81c0048 
0x60000000e81c0038  0x0000000000000000  
<Stack contents outside of kernel space.  60000000e81c0038>


--------------040009010702000404060506--


