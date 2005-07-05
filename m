From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: Fix failed assertion in ata_qc_complete()
Date: Tue, 05 Jul 2005 14:26:42 +0800
Message-ID: <42CA2822.9040803@tw.ibm.com>
References: <42C3C1C0.2040501@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000409040202010804010505"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:5111 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261383AbVGEG0z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jul 2005 02:26:55 -0400
In-Reply-To: <42C3C1C0.2040501@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000409040202010804010505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

> 
> (This is the patch #4 in the summary.)
> Problem:
>    'assert(qc->flags & ATA_QCFLAG_ACTIVE)' assertion failed in 
> ata_pio_complete().
> 
> Root cause:
>  Please see the detailed dmesg log in the follow-up mail.
> 
> 

Attached please find the detailed trace of the problem.

Albert

--------------000409040202010804010505
Content-Type: text/plain;
 name="log_check2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log_check2.txt"

The following is the log of the problematic transation:

Jun 27 07:14:46 lintest kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 43 00 00 00 00 00 00 00 0c
Jun 27 07:14:46 lintest kernel: ata_scsi_translate: ENTER
Jun 27 07:14:46 lintest kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: device 0xA0
Jun 27 07:14:46 lintest kernel: ata_exec_command_pio: ata1: cmd 0xA0
Jun 27 07:14:46 lintest kernel: ata_scsi_translate: EXIT
Jun 27 07:14:46 lintest kernel: atapi_packet_task: busy wait
Jun 27 07:14:46 lintest kernel: atapi_packet_task: send cdb
Jun 27 07:14:46 lintest kernel: atapi_packet_task: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
Jun 27 07:14:46 lintest kernel: ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: atapi_qc_complete: request check condition

                                 <== The scsi error handler comes in early, 
                                     before ata_qc_complete() clears the ATA_QCFLAG_ACTIVE flag.

Jun 27 07:14:46 lintest kernel: ata_scsi_error: ENTER
Jun 27 07:14:46 lintest kernel: ata_eng_timeout: ENTER
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: atapi_request_sense: ATAPI request sense
Jun 27 07:14:46 lintest kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: device 0xA0
Jun 27 07:14:46 lintest kernel: ata_exec_command_pio: ata1: cmd 0xA0  

                                 <= scsi error handler has done calling  __ata_qc_complete() 
                                    to full complete the original command.
                                    It is now trying to get sense data.
                                    The qc is made active again.
                                    So, ATA_QCFLAG_ACTIVE is set again.
                                    
Jun 27 07:14:46 lintest kernel: atapi_packet_task: busy wait             
Jun 27 07:14:46 lintest kernel: atapi_packet_task: send cdb              
Jun 27 07:14:46 lintest kernel: atapi_packet_task: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
                                
Jun 27 07:14:46 lintest kernel: ata_qc_complete: EXIT - need request sense later
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 1

                               <= ata_qc_complete() races with the scsi error handler here.
                                  ata_qc_complete() clears the ATA_QCFLAG_ACTIVE flag here.

                    <= ata_qc_complete() exits, leaving ATA_QCFLAG_ACTIVE flag cleared.                              

Jun 27 07:14:46 lintest kernel: __atapi_pio_bytes: data read
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 2
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
Jun 27 07:14:46 lintest kernel: Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,/root/build/linux-2.6.5-7.179/drivers/scsi/libata-core.c,ata_qc_complete,line=2906

                    <= The "get sense data" thread finds ATA_QCFLAG_ACTIVE flag to be cleared and displays error.

Jun 27 07:14:46 lintest kernel: ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 1
Jun 27 07:14:46 lintest kernel: atapi_request_sense: EXIT
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: Got sense data
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: EXIT
Jun 27 07:14:46 lintest kernel: ata_eng_timeout: EXIT
Jun 27 07:14:46 lintest kernel: ata_scsi_error: EXIT



==============
The following is the log of a normal transation:


Jun 27 07:14:46 lintest kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 43 00 00 00 00 00 00 00 0c
Jun 27 07:14:46 lintest kernel: ata_scsi_translate: ENTER
Jun 27 07:14:46 lintest kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: device 0xA0
Jun 27 07:14:46 lintest kernel: ata_exec_command_pio: ata1: cmd 0xA0
Jun 27 07:14:46 lintest kernel: ata_scsi_translate: EXIT
Jun 27 07:14:46 lintest kernel: atapi_packet_task: busy wait
Jun 27 07:14:46 lintest kernel: atapi_packet_task: send cdb
Jun 27 07:14:46 lintest kernel: atapi_packet_task: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
Jun 27 07:14:46 lintest kernel: ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: atapi_qc_complete: request check condition
Jun 27 07:14:46 lintest kernel: ata_qc_complete: EXIT - need request sense later
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 1
Jun 27 07:14:46 lintest kernel: ata_scsi_error: ENTER
Jun 27 07:14:46 lintest kernel: ata_eng_timeout: ENTER
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: atapi_request_sense: ATAPI request sense
Jun 27 07:14:46 lintest kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Jun 27 07:14:46 lintest kernel: ata_tf_load_pio: device 0xA0
Jun 27 07:14:46 lintest kernel: ata_exec_command_pio: ata1: cmd 0xA0
Jun 27 07:14:46 lintest kernel: atapi_packet_task: busy wait
Jun 27 07:14:46 lintest kernel: atapi_packet_task: send cdb
Jun 27 07:14:46 lintest kernel: atapi_packet_task: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
Jun 27 07:14:46 lintest kernel: __atapi_pio_bytes: data read
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 2
Jun 27 07:14:46 lintest kernel: ata_pio_task: pio_task_state 4
Jun 27 07:14:46 lintest kernel: ata_pio_block: ENTER
Jun 27 07:14:46 lintest kernel: ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: ENTER
Jun 27 07:14:46 lintest kernel: __ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: ata_qc_complete: EXIT
Jun 27 07:14:46 lintest kernel: ata_pio_block: EXIT 1
Jun 27 07:14:46 lintest kernel: atapi_request_sense: EXIT
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: Got sense data
Jun 27 07:14:46 lintest kernel: ata_qc_timeout: EXIT
Jun 27 07:14:46 lintest kernel: ata_eng_timeout: EXIT
Jun 27 07:14:46 lintest kernel: ata_scsi_error: EXIT

--------------000409040202010804010505--


