From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-core.c: restore configuration boot messages in
 ata_dev_configure()
Date: Tue, 27 Jun 2006 22:33:38 +0900
Message-ID: <44A133B2.2090306@gmail.com>
References: <20060627073335.GA6237@zmei.tnic> <44A123B6.20000@gmail.com> <20060627131259.GA24191@gollum.tnic> <44A132D6.9010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:24655 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932181AbWF0NdV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 09:33:21 -0400
Received: by wr-out-0506.google.com with SMTP id i34so103615wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 06:33:20 -0700 (PDT)
In-Reply-To: <44A132D6.9010408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux IDE ML <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Actually, how about...
> 
> enum {
>     ATA_MSG_ERR,
>     ATA_MSG_WARNING,
>     ...
> };
> 
> const char *__ata_msg_lvs[] = {
>     [ATA_MSG_ERR]        = KERN_ERR,
>     [ATA_MSG_WARNING]    = KERN_WARNING,
>     ...
> };
> 
> #define ata_port_printk(ap, lv, fmt, args...) do { \
>     if (unlikely((ap)->msg_enable & (1 << (lv))))
>         printk(__ata_msg_lvs[lv]"ata%u: "fmt, (ap)->id , #args);

Oops,
	printk("%sata%u: "fmt, __ata_msg_lvs[lv], (ap)->id, #args);

-- 
tejun
