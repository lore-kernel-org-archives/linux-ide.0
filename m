From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 01 May 2007 15:40:36 +0200
Message-ID: <46374354.7040307@gmail.com>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <20070501121703.GH5942@electro-mechanical.com> <46373AEE.6070908@rtr.ca> <20070501131818.GA18521@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:57551 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423499AbXEANl4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 09:41:56 -0400
Received: by py-out-1112.google.com with SMTP id a29so1568101pyi
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2007 06:41:55 -0700 (PDT)
In-Reply-To: <20070501131818.GA18521@electro-mechanical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: William Thompson <wt@electro-mechanical.com>
Cc: Mark Lord <liml@rtr.ca>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, Jeff Garzik <jgarzik@pobox.com>

Hello,

William Thompson wrote:
> On Tue, May 01, 2007 at 09:04:46AM -0400, Mark Lord wrote:
>>> +ata_dev_classify: found ATA device by sig
>>> +ata_dev_classify: unknown device
>>> +ata_std_softreset: EXIT, classes[0]=1 [1]=5
>>> +ata_std_postreset: ENTER
>>> +ata_std_postreset: EXIT
>>> +ata_eh_thaw_port: ata2 port thawed
>>> +ata_eh_revalidate_and_attach: ENTER
>>> +ata2.00: ata_dev_read_id: ENTER, host 2, dev 0
>>> +ata_exec_command_pio: ata2: cmd 0xEC
>>> +ata_hsm_move: ata2: protocol 2 task_state 1 (dev_stat 0x51)
>>> +ata_hsm_move: ata2: protocol 2 task_state 3 (dev_stat 0x51)
>>> +ata_port_flush_task: ENTER
>>> +ata_port_flush_task: flush #1
>>> +ata2: ata_port_flush_task: flush #2
>>> +ata2: ata_port_flush_task: EXIT
>>> +ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
>>> +ata_eh_revalidate_and_attach: EXIT
>> ..
>>
>> Yep.  Libata seems to be treating the ATAPI drive as ATA.

Yeah, indeed.

>> Tejun, don't we have a fallback for when IDENTIFY fails?
>> If the drive rejects it (err=0x04), then this can mean only one thing:
>> unsupported command, so we next must try PACKET_IDENTIFY.

Up until now, we've been depending on the device giving us the correct
signature on reset.  This is the first reported case which screws that
up.  Gee... Two crazy screwed up devices today.  What's going on?

> Is it doing that just for this drive?  I use libata on another machine (Dell
> Dimension 2400) and it finds the cdrom just fine.

That specific cdrom is crazy.  It's telling libata that it's a disk when
it apparently isn't.

> The one thing I do know, the machine with the non-working libata cdrom also
> does not work with the ide driver *ONLY IF* DMA is turned on.

This is probably as Mark explained in the other thread.

Anyways, oh well, it looks like we need fallback mechanism to the other
IDENTIFY command after all.  Jeff, any ideas or objections?

-- 
tejun
