From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 0/4] libata: more irq driven pio follow-up patches
Date: Mon, 03 Oct 2005 19:46:34 +0800
Message-ID: <43411A1A.8050901@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56023 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750785AbVJCLq4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2005 07:46:56 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j93BkjpU032728
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:46:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j93Bkjm6096300
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:46:45 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j93Bki7Q032245
	for <linux-ide@vger.kernel.org>; Mon, 3 Oct 2005 07:46:45 -0400
In-Reply-To: <433D1FC7.2060401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Dear all,

More irq driven PIO follow-up patches per Jeff's advice:
 1. merge ata_dataout_task and ata_pio_task
 2. add read/write multiple support

patch 1/4: move functions
    - move atapi_send_cdb() and ata_dataout_task() to be near 
ata_pio_*() functions

patch 2/4: remove ap->dataout_task
    - remove ap->dataout_task
    - let ata_pio_task() handle the HSM_ST_FIRST state.
    - rename ata_dataout_task() to ata_pio_first_block()

patch 3/4: integrate ata_pio_first_block() with ata_pio_task()
    - change the return value of ata_pio_complete()
    - add return value for ata_pio_first_block()
    - rename variable "qc_completed" to "has_next" in ata_pio_task()

patch 4/4: add read/write multiple support
    - add ATA_CMD_READ_MULTI, etc. to ata.h
    - add multi_count to ata_device and initialize it with device 
identify data
    - merge ata_prot_to_cmd() with ata_dev_set_protocol()
    - ata_pio_complete(): change the wait condition from (ATA_BUSY | 
ATA_DRQ) to ATA_BUSY
    - add ata_pio_sectors() to support r/w multiple commands
    - ata_pio_block(): add ata_altstatus(ap) to prevent reading device 
status before it is valid

Patch against libata-dev irq-pio branch 
(54f00389563c80fa1de250a21256313ba01ca07d).

For your review and advice, thanks.

Albert


