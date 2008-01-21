From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata error codes
Date: Mon, 21 Jan 2008 17:04:18 +0900
Message-ID: <47945202.8090107@gmail.com>
References: <5d96567b0801150939y3802a73aqcbab553af5fe6015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:8259 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbYAUIEY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 03:04:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3550071wah.23
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 00:04:24 -0800 (PST)
In-Reply-To: <5d96567b0801150939y3802a73aqcbab553af5fe6015@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raz <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Raz wrote:
> Mr Garzik Hello
> ata errors are some times cryptic. I am refering to this line, in the
> ata_qc_timeout which holds lots of information.
> printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
>  ap->id,
>  qc->tf.command,
>  drv_stat,
>  host_stat)
> 
> These errors varries , and many times SMART cannot help. Is there a
> repository for these error codes, (  ata_dump_status isn't enough ).
> Is there an API to get these error codes translated to human readable format ?
> thank you

Those values are directly from hardware registers and can be decoded
with information from ATA and SFF specs.  It could be nice to have
decoded strings but I'm not too sure.  Even when decoded, they're pretty
cryptic and don't carry too much information by themselves.

-- 
tejun
