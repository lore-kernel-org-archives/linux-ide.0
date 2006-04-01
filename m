From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Sat, 01 Apr 2006 21:24:38 +0800
Message-ID: <442E7F16.8060007@tw.ibm.com>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com> <441838B6.8060900@rtr.ca> <44183CDA.5010407@rtr.ca> <441845B6.2070200@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:44209 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751514AbWDANZC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Apr 2006 08:25:02 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k31DOugt029520
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 08:24:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k31DLfku167598
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 06:21:41 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k31DOtew024776
	for <linux-ide@vger.kernel.org>; Sat, 1 Apr 2006 06:24:56 -0700
In-Reply-To: <441845B6.2070200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> 
>>
>> Yup, I have two such drives here.
>>
>> One of them has a grease-pencil "NFG" marking on it,
>> and other other one doesn't.  They both powered up and
>> worked just now, and their identify blobs are attached
>> (you can interpret them with "hdparm --Istdin <blob").
> 
> ..
> 
> Oh, another note:  neither of these two drives works
> with DMA enabled, at least not in 2.6.12 using the IDE driver.
> 
> PIO mode appears to be functioning fine on both of them.
> 

Thanks for Mark's info, I have finally found two of such CD-ROM drives:
one is a 1998 AOpen CD-936E/AKW (36x), the other is a LITEON LTN-403 (40x), removed
from a 1999 IBM Aptiva PC.

Both of them generates CDB interrupts. The AOpen drive supports PIO4/MWDMA2 and
the LITEON drive supports UDMA/33. (So, CDB intr + UDMA drives do exist.)

I've tested the drives for about a week. The test result of the irq-pio code
looks good. DRQ is always set when CDB interrupt is generated. 
Both drives follow the behavior defined by the sff-8020i spec.
I did not hit the DRQ=0 during CDB interrupt problem mentioned by Mark.
(If we encounter such problem in the future, maybe we can add some 
waiting loops to the HSM_ST_FIRST state, waiting for DRQ to be set, something 
like what ata_wait_idle() does.)

Interrupt-driven PIO, polling PIO and (interrupt driven) DMA protocols are tested
with both drives. Results look good. (Sample logs attached below.)
Hard drives are also tested, result looks good, too.

Current upstream is also tested. Since CDB intr is not supported yet, the CDB intr
caused irq to be disabled.

Summary: 
The current known problem of the irq-pio branch is the DRQ=1 ERR=1 handling.
A revised patch has been sent per Jeff's IDE try_to_flush_leftover_data() pointer.
Otherwise the irq-pio branch looks ready for upstream (need your comments)
and integration with Tejun's EH and Alan's PATA works.

Thanks,

Albert

Sample transation logs of the LTN-403 drive (irq-pio and dma).
(Interrupt driven PIO)
Mar 23 19:30:26 p4ht-s kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 2c 30 00 00 32
Mar 23 19:30:26 p4ht-s kernel: ata_scsi_translate: ENTER
Mar 23 19:30:26 p4ht-s kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Mar 23 19:30:26 p4ht-s kernel: ata_tf_load_mmio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
Mar 23 19:30:26 p4ht-s kernel: ata_tf_load_mmio: device 0xA0
Mar 23 19:30:26 p4ht-s kernel: ata_exec_command_mmio: ata1: cmd 0xA0
Mar 23 19:30:26 p4ht-s kernel: ata_scsi_translate: EXIT
Mar 23 19:30:26 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 5  <== CDB intr
Mar 23 19:30:26 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 5 (dev_stat 0x58) <== DRQ=1, good.
Mar 23 19:30:26 p4ht-s kernel: atapi_send_cdb: send cdb
Mar 23 19:30:26 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:26 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:26 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:26 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:26 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 8192 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 2
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 2 (dev_stat 0x58)
Mar 23 19:30:27 p4ht-s kernel: atapi_pio_bytes: ata1: xfering 4096 bytes
Mar 23 19:30:27 p4ht-s kernel: __atapi_pio_bytes: data read
Mar 23 19:30:27 p4ht-s kernel: ata_host_intr: ata1: protocol 5 task_state 3
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: protocol 5 task_state 3 (dev_stat 0x50)
Mar 23 19:30:27 p4ht-s kernel: ata_hsm_move: ata1: command complete, drv_stat 0x50
Mar 23 19:30:27 p4ht-s kernel: atapi_qc_complete: ENTER, err_mask 0x0

================

(DMA)

Mar 23 19:38:13 p4ht-s kernel: ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 0c 30 00 00 32
Mar 23 19:38:13 p4ht-s kernel: ata_scsi_translate: ENTER
Mar 23 19:38:13 p4ht-s kernel: ata_sg_setup: ENTER, ata1
Mar 23 19:38:13 p4ht-s kernel: ata_sg_setup: 25 sg elements mapped
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[0] = (0x486F000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[1] = (0x10A7C000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[2] = (0x12BD6000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[3] = (0xF3DF000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[4] = (0xF242000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[5] = (0x9A25000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[6] = (0x4E9E000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[7] = (0x1E32B000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[8] = (0x7DC7000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[9] = (0xB4F3000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[10] = (0xDD63000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[11] = (0x115EB000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[12] = (0xDB6D000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[13] = (0x4CEC000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[14] = (0x100E1000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[15] = (0x776E000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[16] = (0xA947000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[17] = (0xAD8A000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[18] = (0x7036000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[19] = (0x13FA9000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[20] = (0xA5D5000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[21] = (0xBE62000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[22] = (0x2E8F000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[23] = (0x10DF3000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_fill_sg: PRD[24] = (0xA5D2000, 0x1000)
Mar 23 19:38:13 p4ht-s kernel: ata_dev_select: ENTER, ata1: device 0, wait 1
Mar 23 19:38:13 p4ht-s kernel: ata_tf_load_mmio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
Mar 23 19:38:13 p4ht-s kernel: ata_tf_load_mmio: device 0xA0
Mar 23 19:38:13 p4ht-s kernel: ata_exec_command_mmio: ata1: cmd 0xA0
Mar 23 19:38:13 p4ht-s kernel: ata_scsi_translate: EXIT
Mar 23 19:38:13 p4ht-s kernel: ata_host_intr: ata1: protocol 7 task_state 5  <== CDB intr
Mar 23 19:38:13 p4ht-s kernel: ata_hsm_move: ata1: protocol 7 task_state 5 (dev_stat 0x58) <== DRQ=1, good.
Mar 23 19:38:13 p4ht-s kernel: atapi_send_cdb: send cdb
Mar 23 19:38:13 p4ht-s kernel: ata_host_intr: ata1: protocol 7 task_state 3
Mar 23 19:38:13 p4ht-s kernel: ata_host_intr: ata1: host_stat 0x4
Mar 23 19:38:13 p4ht-s kernel: ata_hsm_move: ata1: protocol 7 task_state 3 (dev_stat 0x50)
Mar 23 19:38:13 p4ht-s kernel: ata_hsm_move: ata1: command complete, drv_stat 0x50
Mar 23 19:38:13 p4ht-s kernel: ata_sg_clean: unmapping 25 sg elements
Mar 23 19:38:13 p4ht-s kernel: atapi_qc_complete: ENTER, err_mask 0x0

