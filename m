From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 01 May 2007 09:04:46 -0400
Message-ID: <46373AEE.6070908@rtr.ca>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <20070501121703.GH5942@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1102 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031221AbXEANEt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 09:04:49 -0400
In-Reply-To: <20070501121703.GH5942@electro-mechanical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: William Thompson <wt@electro-mechanical.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

William Thompson wrote:
>
> +scsi2 : ata_piix
> +ata_port_schedule_eh: port EH scheduled
> +ata_scsi_error: ENTER
> +ata_port_flush_task: ENTER
> +ata_port_flush_task: flush #1
> +ata2: ata_port_flush_task: flush #2
> +ata2: ata_port_flush_task: EXIT
> +ata_eh_autopsy: ENTER
> +ata_eh_recover: ENTER
> +ata_eh_prep_resume: ENTER
> +ata_eh_prep_resume: EXIT
> +__ata_port_freeze: ata2 port frozen
> +ata_std_softreset: ENTER
> +ata_std_softreset: about to softreset, devmask=1
> +ata_bus_softreset: ata2: bus reset via SRST
> +ata_dev_classify: found ATA device by sig
> +ata_dev_classify: unknown device
> +ata_std_softreset: EXIT, classes[0]=1 [1]=5
> +ata_std_postreset: ENTER
> +ata_std_postreset: EXIT
> +ata_eh_thaw_port: ata2 port thawed
> +ata_eh_revalidate_and_attach: ENTER
> +ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
> +ata_exec_command_pio: ata2: cmd 0xEC
> +ata_hsm_move: ata2: protocol 2 task_state 1 (dev_stat 0x51)
> +ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x51)
> +ata_port_flush_task: ENTER
> +ata_port_flush_task: flush #1
> +ata2: ata_port_flush_task: flush #2
> +ata2: ata_port_flush_task: EXIT
> +ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
> +ata_eh_revalidate_and_attach: EXIT
..

Yep.  Libata seems to be treating the ATAPI drive as ATA.

Tejun, don't we have a fallback for when IDENTIFY fails?
If the drive rejects it (err=0x04), then this can mean only one thing:
unsupported command, so we next must try PACKET_IDENTIFY.

-ml
