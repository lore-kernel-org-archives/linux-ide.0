From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 13:29:49 +0200
Message-ID: <463F0DAD.5060307@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com> <463ED8B9.4060501@gmail.com> <463F0B25.40103@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:31359 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbXEGLaH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 07:30:07 -0400
Received: by py-out-1112.google.com with SMTP id a29so1153983pyi
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 04:30:07 -0700 (PDT)
In-Reply-To: <463F0B25.40103@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

Hello, Albert.

Albert Lee wrote:
> Tejun Heo wrote:
>> Also, this is a problem for not only IDENTIFY but all polling commands.
> 
> Yes, other command might also assert INTRQ during polling.
> However, for the specific BENQ DW1620 drive, only IDENTIFY_PACKET_DEVICE
> has such behavior; other commands like READ or REQUEST_SENSE are ok.

Oh I see.

>> One solution I can think of is to let IRQ handler ack IRQ
>> unconditionally during polling commands - ie. just read the TF Status
>> register once and tell the IRQ subsystem that the IRQ is handled.  This
>> shouldn't affect the operation of polling as the only side effect of
>> reading Status is clearing pending IRQ && will give us a nice way to
>> deal with the SATA bridge chip which chokes on nIEN.  Considering the
>> sorry state of nIEN in SATA, I guess this might be the best way to deal
>> with this.
>>
>> Albert, can you please test whether this works?  Modifying
>> ata_interrupt() such that it reads TF Status if ATA_TFLAG_POLLING should
>> do the trick.
> 
> Yes, reading the Status register and acking interrupt also fixes the
> problem (patch attached below). 

Good to know it works.  With or without nIEN, I think this change is a
good thing to have.  IRQ handler shouldn't interfere with polling as
both acquire lock during operation.  Polling is safer this way and
non-SFF drivers are doing something similar anyway.  I also think it
would be nice to have the SFF irq_handler clear IRQ while the port is
frozen.  This again is the default behavior of non-SFF drivers.

Any objections?

-- 
tejun
