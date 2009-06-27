From: Sagar Borikar <sagar.borikar@gmail.com>
Subject: sil3132 is resetting continuously
Date: Sat, 27 Jun 2009 21:00:50 +0530
Message-ID: <3fb94e50906270830q436e5aa4n8a40741cd0d738b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:37335 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbZF0Pas (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Jun 2009 11:30:48 -0400
Received: by gxk26 with SMTP id 26so2068955gxk.13
        for <linux-ide@vger.kernel.org>; Sat, 27 Jun 2009 08:30:50 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hi list,

I am using sil3132 PCIe card on my ARM platform and I find that
whenever the system boots, the device gets hard reset. I am not able
see the device node as well. It always say that the controller is in
dubious state.  following is platform information:

CPU: cortex A8
kernel: 2.6.24

Here is the log:

<3>ata_host_alloc: ENTER
ata_host_alloc: ENTER
<3>ata_port_alloc: ENTER
ata_port_alloc: ENTER
<3>ata_port_alloc: ENTER
ata_port_alloc: ENTER
<3>__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
<3>__ata_port_freeze: ata4294967295 port frozen
__ata_port_freeze: ata4294967295 port frozen
<6>scsi0 : sata_sil24
scsi0 : sata_sil24
<6>scsi1 : sata_sil24
scsi1 : sata_sil24
<6>ata1: SATA max UDMA/100 host m128@0x81004000 port 0x81000000 irq 12
ata1: SATA max UDMA/100 host m128@0x81004000 port 0x81000000 irq 12
<6>ata2: SATA max UDMA/100 host m128@0x81004000 port 0x81002000 irq 12
ata2: SATA max UDMA/100 host m128@0x81004000 port 0x81002000 irq 12
<3>ata_host_register: probe begin
ata_host_register: probe begin
<3>ata_port_schedule_eh: port EH scheduled
ata_port_schedule_eh: port EH scheduled
<3>ata_scsi_error: ENTER
ata_scsi_error: ENTER
<3>ata_port_flush_task: ENTER
ata_port_flush_task: ENTER
<7>ata1: ata_port_flush_task: EXIT
<3>ata_eh_link_autopsy: ENTER
ata_eh_link_autopsy: ENTER
<3>ata_eh_recover: ENTER
ata_eh_recover: ENTER
<3>__ata_port_freeze: ata1 port frozen
__ata_port_freeze: ata1 port frozen
<3>sil24_do_softreset: ENTER
sil24_do_softreset: ENTER
softresetting the port
softresetting the port
<3>ata1: softreset failed (timeout)
ata1: softreset failed (timeout)
<4>ata1: controller in dubious state, performing PORT_RST
ata1: controller in dubious state, performing PORT_RST
<3>sil24_do_softreset: ENTER
sil24_do_softreset: ENTER
softresetting the port
softresetting the port
<3>ata1: softreset failed (timeout)
ata1: softreset failed (timeout)
<4>ata1: controller in dubious state, performing PORT_RST
ata1: controller in dubious state, performing PORT_RST
<3>sil24_do_softreset: ENTER
sil24_do_softreset: ENTER
softresetting the port
softresetting the port
<3>ata1: softreset failed (timeout)
ata1: softreset failed (timeout)
<4>ata1: limiting SATA link speed to 1.5 Gbps
ata1: limiting SATA link speed to 1.5 Gbps
<4>ata1: controller in dubious state, performing PORT_RST
ata1: controller in dubious state, performing PORT_RST
<3>sil24_do_softreset: ENTER
sil24_do_softreset: ENTER
softresetting the port
softresetting the port
<3>ata1: softreset failed (timeout)
ata1: softreset failed (timeout)
<3>ata1: reset failed, giving up
ata1: reset failed, giving up
<3>ata_eh_recover: EXIT, rc=-5
ata_eh_recover: EXIT, rc=-5
<3>ata_scsi_error: EXIT
ata_scsi_error: EXIT
<3>ata_port_schedule_eh: port EH scheduled
ata_port_schedule_eh: port EH scheduled
<3>ata_scsi_error: ENTER
ata_scsi_error: ENTER
<3>ata_port_flush_task: ENTER
ata_port_flush_task: ENTER
<7>ata2: ata_port_flush_task: EXIT
<3>ata_eh_link_autopsy: ENTER
ata_eh_link_autopsy: ENTER
<3>ata_eh_recover: ENTER
ata_eh_recover: ENTER
<3>__ata_port_freeze: ata2 port frozen
__ata_port_freeze: ata2 port frozen
<3>sil24_do_softreset: ENTER
sil24_do_softreset: ENTER
softresetting the port
softresetting the port
<3>sil24_do_softreset: PHY reports no device
sil24_do_softreset: PHY reports no device
PHY reports no device
PHY reports no device
<3>sil24_do_softreset: EXIT, class=9
sil24_do_softreset: EXIT, class=9
<3>ata_std_postreset: ENTER
ata_std_postreset: ENTER
<6>ata2: SATA link down (SStatus 0 SControl 0)
ata2: SATA link down (SStatus 0 SControl 0)
<3>ata_std_postreset: EXIT
ata_std_postreset: EXIT
<3>ata_eh_thaw_port: ata2 port thawed
ata_eh_thaw_port: ata2 port thawed
<3>ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: ENTER
<3>ata_eh_recover: EXIT, rc=0
ata_eh_recover: EXIT, rc=0
<3>ata_scsi_error: EXIT
ata_scsi_error: EXIT
<3>ata_host_register: host probe begin
ata_host_register: host probe begin
<3>ata_port_schedule_eh: port EH scheduled
ata_port_schedule_eh: port EH scheduled
<3>ata_port_schedule_eh: port EH scheduled
ata_port_schedule_eh: port EH scheduled
<3>ata_scsi_error: ENTER
ata_scsi_error: ENTER
<3>ata_port_flush_task: ENTER
ata_port_flush_task: ENTER
<7>ata1: ata_port_flush_task: EXIT
<3>ata_scsi_error: ENTER
ata_scsi_error: ENTER
<3>ata_port_flush_task: ENTER
ata_port_flush_task: ENTER
<7>ata2: ata_port_flush_task: EXIT
<3>ata_eh_link_autopsy: ENTER
ata_eh_link_autopsy: ENTER
<3>ata_eh_recover: ENTER
ata_eh_recover: ENTER
<3>ata_eh_revalidate_and_attach: ENTER
ata_eh_revalidate_and_attach: ENTER
<3>ata_eh_recover: EXIT, rc=0
ata_eh_recover: EXIT, rc=0
<3>ata_scsi_error: EXIT
ata_scsi_error: EXIT
<3>__ata_port_freeze: ata1 port frozen
__ata_port_freeze: ata1 port frozen
<3>ata_eh_link_autopsy: ENTER
ata_eh_link_autopsy: ENTER
<3>ata_eh_recover: ENTER
ata_eh_recover: ENTER
<3>__ata_port_freeze: ata1 port frozen
__ata_port_freeze: ata1 port frozen
<6>ata1: hard resetting link
ata1: hard resetting link
<4>ata1: controller in dubious state, performing PORT_RST
ata1: controller in dubious state, performing PORT_RST


Thanks
Sagar
