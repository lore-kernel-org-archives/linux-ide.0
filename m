From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH] libata-core.c: restore configuration boot messages in ata_dev_configure()
Date: Wed, 28 Jun 2006 08:36:55 +0200
Message-ID: <20060628063655.GA10640@gollum.tnic>
References: <20060627073335.GA6237@zmei.tnic> <44A123B6.20000@gmail.com> <20060627131259.GA24191@gollum.tnic> <44A132D6.9010408@gmail.com> <44A133B2.2090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:39055 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030394AbWF1Gg7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:36:59 -0400
Content-Disposition: inline
In-Reply-To: <44A133B2.2090306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux IDE ML <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Tue, Jun 27, 2006 at 10:33:38PM +0900, Tejun Heo wrote:
> Tejun Heo wrote:
> >Actually, how about...
> >
> >enum {
> >    ATA_MSG_ERR,
> >    ATA_MSG_WARNING,
> >    ...
> >};
> >
> >const char *__ata_msg_lvs[] = {
> >    [ATA_MSG_ERR]        = KERN_ERR,
> >    [ATA_MSG_WARNING]    = KERN_WARNING,
> >    ...
> >};
> >
> >#define ata_port_printk(ap, lv, fmt, args...) do { \
> >    if (unlikely((ap)->msg_enable & (1 << (lv))))
> >        printk(__ata_msg_lvs[lv]"ata%u: "fmt, (ap)->id , #args);
> 
> Oops,
> 	printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id, #args);
Tejun,
    are you sure about that, printk gets as first arg the KERN_* message level,
    so your first suggestion should be right as passing __ata_msg_lvs[lv] is the
    first arg, no?

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

