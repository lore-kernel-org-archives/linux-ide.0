From: Richard Kang <turquesa@malgn.com>
Subject: qc timeout on a marvell 88F6282 board
Date: Wed, 29 Jun 2011 18:04:49 +0900
Message-ID: <4E0AEAB1.4090106@malgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [125.7.223.35] ([125.7.223.35]:51988 "EHLO mail.malgn.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab1F2JMO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Jun 2011 05:12:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

Hello.

I have a sil3132 pci-e card and a DB-88F6282-A-BP(Marvell development
board based on Arm9).
I compiled sata_sil24 driver as a module with a cross-compiler.

But, when loading the driver, qc timeout error was occurred during
ata_read_dev_id.
What is wrong, IRQ or DMA ?

I have 2.6.31.8

libata version 3.00 loaded.
bus: 'pci': add driver sata_sil24
bus: 'pci': driver_probe_device: matched device 0000:01:01.0 with driver
sata_sil24
bus: 'pci': really_probe: probing driver sata_sil24 with device 0000:01:01.0
sil24_init_one: @@@ ENTER
sata_sil24 0000:01:01.0: version 1.1
(arch/arm/mm/ioremap.c) __arm_ioremap: phys_addr=e8084000
(arch/arm/mm/ioremap.c) __arm_ioremap_pfn: addr=e0a22000
(arch/arm/mm/ioremap.c) __arm_ioremap: phys_addr=e8080000
(arch/arm/mm/ioremap.c) __arm_ioremap_pfn: addr=e0a28000
ata_host_alloc: ### ENTER: max_ports=2
ata_port_alloc: ENTER
(libata-core.c) ata_link_init
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_port_alloc: LEAVE
ata_port_alloc: ENTER
(libata-core.c) ata_link_init
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
ata_port_alloc: LEAVE
ata_host_alloc: ### LEAVE
sil24_init_one: DMA_MASK_64 rc=0
sil24_init_controller: === ENTER : sil24_init_controller
sil24_init_controller: host_base=e0a22000 HOST_CTRL(0x40)=81000000
sil24_init_controller: === LEAVE: HOST_CTRL=1000003
sil24_init_one: @@@ LEAVE
sil24_port_start: ENTER ap=d1898000 ata4294967295
sil24_port_start: kernel va=ffc08000 cb_dma=118a0000
sil24_port_start: LEAVE
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata4294967295 port frozen
sil24_port_start: ENTER ap=d1630000 ata4294967295
sil24_port_start: kernel va=ffc27000 cb_dma=11800000
sil24_port_start: LEAVE
__ata_port_freeze: ENTER: ap=d1630000
__ata_port_freeze: LEAVE: ata4294967295 port frozen
sil24_interrupt: ***** ENTER: sil24_interrupt
sil24_interrupt: host_base=e0a22000 HOST_IRQ_STAT=0
sil24_interrupt: ***** LEAVE
(libata-core.c) ata_host_register *ENTER*
scsi2 : sata_sil24
device: 'host2': device_add
bus: 'scsi': add device host2
device: 'host2': device_add
scsi3 : sata_sil24
device: 'host3': device_add
bus: 'scsi': add device host3
device: 'host3': device_add
ata1: SATA max UDMA/100 host m128@0xe8084000 port 0xe8080000 irq 10
ata2: SATA max UDMA/100 host m128@0xe8084000 port 0xe8082000 irq 10
(libata-core.c) ata_host_register *LEAVE*
driver: '0000:01:01.0': driver_bound: bound to device 'sata_sil24'
bus: 'pci': really_probe: bound device 0000:01:01.0 to driver sata_sil24
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
(libata-eh.c) ata_scsi_error
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
sil24_error_handler: ENTER
sil24_init_port: +++ ENTER port_base=e0a28000
sil24_init_port: +++ LEAVE
ata_eh_link_autopsy: ENTER
ata_eh_recover: ENTER
ata_dev_init: (libata-core.c) ENTER
ata_dev_init: (libata-core.c) LEAVE
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
sil24_softreset: ENTER
sil24_init_port: +++ ENTER port_base=e0a28000
sil24_init_port: +++ LEAVE
sil24_softreset: call -> sil24_exec_polled_cmd:
sil24_exec_polled_cmd: ENTER: irq_enabled=0
(libata-core.c) ata_tf_to_fis: 27 0f 00 00
sil24_exec_polled_cmd: LEAVE: PORT_IRQ_STAT=b40000 rc=0
sil24_softreset: call -> sil24_read_tf
sil24_read_tf: ENTER: tag=0
(libata-core.c) ata_tf_from_fis
sil24_read_tf: LEAVE: 27 0f 50 01 01 00 00 00 [01]
ata_dev_classify: found ATA device by sig
sil24_softreset: EXIT, class=1
sil24_thaw: ENTER
sil24_thaw: LEAVE: irq_enabled=8d3
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata1.00: ata_dev_read_id: ENTER
(libata-core.c) ata_dev_read_id
ata_do_dev_read_id: (libata-core.c) call -> ata_exec_internal
ata_exec_internal_sg: (libata-core.c) ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: qc->sg=d15cfd2c
ata_sg_setup: 1 sg elements mapped
sil24_qc_prep: cb=ffc08000 sil24(qc->tag)=0
sil24_qc_prep: cmd_block[0]=ffc08000 cmd_block[1]=ffc09000
cmd_block[2]=ffc0a000
sil24_qc_prep: pp=d122a6f8 prb=ffc08000 sge=ffc08020
(libata-core.c) ata_tf_to_fis: 27 80 ec 00
sil24_fill_sg: ENTER: sge=ffc08020
sil24_fill_sg: sg_dma_addr=0x11899578 -> cpu_to_le64=0x11899578 ->
cpu_to_le32=0x11899578
sil24_fill_sg: LEAVE
sil24_qc_issue: (sata_sil24.c) ENTER:
sil24_qc_issue: (sata_sil24.c) LEAVE:
ata_exec_internal_sg: (libata-core.c) call ->
wait_for_completion_timeout rc=0
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
(libata-core.c) ata_qc_complete
(sata_sil24.c) sil24_qc_fill_rtf
sil24_read_tf: ENTER: tag=0
(libata-core.c) ata_tf_from_fis
sil24_read_tf: LEAVE: 00 00 8a 11 00 00 00 00 [00]
ata_sg_clean: unmapping 1 sg elements
(libata-core.c) ata_qc_complete_internal: waiting=d15cfcdc
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
ata1.00: qc timeout (cmd 0xec)
(sata_sil24.c) sil24_post_internal_cmd: qc->flag=10010
sil24_init_port: +++ ENTER port_base=e0a28000
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
(sata_sil24.c) sil24_post_internal_cmd <- ata_eh_freeze_port
ata_exec_internal_sg: (libata-core.c) LEAVE: err_mask=4
(libata-core.c) ata_dev_read_id <- ata_do_dev_read_id: err_mask=4
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata_eh_revalidate_and_attach: EXIT rc=-5
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
ata1: controller in dubious state, performing PORT_RST
sil24_softreset: ENTER
sil24_init_port: +++ ENTER port_base=e0a28000
sil24_init_port: +++ LEAVE
sil24_softreset: call -> sil24_exec_polled_cmd:
sil24_exec_polled_cmd: ENTER: irq_enabled=0
(libata-core.c) ata_tf_to_fis: 27 0f 00 00
sil24_exec_polled_cmd: LEAVE: PORT_IRQ_STAT=b40000 rc=0
sil24_softreset: call -> sil24_read_tf
sil24_read_tf: ENTER: tag=0
(libata-core.c) ata_tf_from_fis
sil24_read_tf: LEAVE: 27 0f 50 01 01 00 00 00 [01]
ata_dev_classify: found ATA device by sig
sil24_softreset: EXIT, class=1
sil24_thaw: ENTER
sil24_thaw: LEAVE: irq_enabled=8d3
ata_eh_thaw_port: ata1 port thawed
ata_std_postreset: ENTER
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata_std_postreset: EXIT
ata_eh_revalidate_and_attach: ENTER
ata1.00: ata_dev_read_id: ENTER
(libata-core.c) ata_dev_read_id
ata_do_dev_read_id: (libata-core.c) call -> ata_exec_internal
ata_exec_internal_sg: (libata-core.c) ENTER
ata_sg_setup: ENTER, ata1
ata_sg_setup: qc->sg=d15cfd2c
ata_sg_setup: 1 sg elements mapped
sil24_qc_prep: cb=ffc08000 sil24(qc->tag)=0
sil24_qc_prep: cmd_block[0]=ffc08000 cmd_block[1]=ffc09000
cmd_block[2]=ffc0a000
sil24_qc_prep: pp=d122a6f8 prb=ffc08000 sge=ffc08020
(libata-core.c) ata_tf_to_fis: 27 80 ec 00
sil24_fill_sg: ENTER: sge=ffc08020
sil24_fill_sg: sg_dma_addr=0x11899578 -> cpu_to_le64=0x11899578 ->
cpu_to_le32=0x11899578
sil24_fill_sg: LEAVE
sil24_qc_issue: (sata_sil24.c) ENTER:
sil24_qc_issue: (sata_sil24.c) LEAVE:
ata_exec_internal_sg: (libata-core.c) call ->
wait_for_completion_timeout rc=0
ata_port_flush_task: ENTER
ata1: ata_port_flush_task: EXIT
(libata-core.c) ata_qc_complete
(sata_sil24.c) sil24_qc_fill_rtf
sil24_read_tf: ENTER: tag=0
(libata-core.c) ata_tf_from_fis
sil24_read_tf: LEAVE: 00 00 8a 11 00 00 00 00 [00]
ata_sg_clean: unmapping 1 sg elements
(libata-core.c) ata_qc_complete_internal: waiting=d15cfcdc
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
ata1.00: qc timeout (cmd 0xec)
(sata_sil24.c) sil24_post_internal_cmd: qc->flag=10010
sil24_init_port: +++ ENTER port_base=e0a28000
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
(sata_sil24.c) sil24_post_internal_cmd <- ata_eh_freeze_port
ata_exec_internal_sg: (libata-core.c) LEAVE: err_mask=4
(libata-core.c) ata_dev_read_id <- ata_do_dev_read_id: err_mask=4
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata_eh_revalidate_and_attach: EXIT rc=-5
ata1: limiting SATA link speed to 1.5 Gbps
__ata_port_freeze: ENTER: ap=d1898000
__ata_port_freeze: LEAVE: ata1 port frozen
ata1: controller in dubious state, performing PORT_RST

Thank you,

