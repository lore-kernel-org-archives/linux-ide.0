From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-core.c: restore configuration boot messages in
 ata_dev_configure()
Date: Tue, 27 Jun 2006 22:29:58 +0900
Message-ID: <44A132D6.9010408@gmail.com>
References: <20060627073335.GA6237@zmei.tnic> <44A123B6.20000@gmail.com> <20060627131259.GA24191@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:64051 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932260AbWF0N3q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 09:29:46 -0400
Received: by nz-out-0102.google.com with SMTP id z31so1638885nzd
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 06:29:46 -0700 (PDT)
In-Reply-To: <20060627131259.GA24191@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux IDE ML <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:
> On Tue, Jun 27, 2006 at 09:25:26PM +0900, Tejun Heo wrote:
> 
> Hi, 
>> IMHO, this should be done in the following steps.
>>
>> * define ATA_MSG_* and ata_msg_* macros which map 1:1 to the current 
>> message levels.
> 
> How about we pin down these final dbg levels to the following (both proposals 
> merged):
> 
> ATA_MSG_ERR
> ATA_MSG_WARNING
> ATA_MSG_DRV ("standard" driver info, initial cfg messages)
> 
> ATA_MSG_INFO maybe) /* revalidation messages, EH progress, more verbose msgs,
>                        feats */
> ATA_MSG_VDEBUG  /* verbose hot path */, by the way, which are those hotpaths?

I don't know but left VDEBUG()s after CMD/SG/TRACE conversion should be 
a good start.

> ATA_MSG_CMD     /* issue / completion */
> ATA_MSG_SG      /* SG map/unmap handling */
> ATA_MGS_TRACE   /* function enter/exit */

Looks okay to me.

>> * make ata_*_prink()s use ATA_MSG_* instead of KERN_* and embed 
>> ata_msg_enable() into ata_*_printk()s.  Convert ALL ata_*_printk()s and 
>> convertible DEBUG/VDEBUG()s in single sweep - it doesn't have to be a 
>> single patch but post them together.  These conversions touch a lot of 
>> places and other patches have to be regenerated afterward.
> 
> then do something like
> 
> #define ata_(ap|dev)_printk((ap|dev), lv, fmt, args...) \
>     if (ata_msg_err(ap)) \
>         printk(KERN_ERR"ata%u: "fmt, ...); \
>     else if (ata_msg_warn(ap)) \
>         printk(KERN_WARNING"ata%u: "fmt, ...); \
>         .

Actually, how about...

enum {
	ATA_MSG_ERR,
	ATA_MSG_WARNING,
	...
};

const char *__ata_msg_lvs[] = {
	[ATA_MSG_ERR]		= KERN_ERR,
	[ATA_MSG_WARNING]	= KERN_WARNING,
	...
};

#define ata_port_printk(ap, lv, fmt, args...) do { \
	if (unlikely((ap)->msg_enable & (1 << (lv))))
		printk(__ata_msg_lvs[lv]"ata%u: "fmt, (ap)->id , #args);
} while (0)

Note that regardless of message level, the msg_enable is unlikely to hit 
in hot patch, so the 'unlikely()' hint.

> and then call them like so:
> 
> ata_dev_printk(dev, ATA_MSG_ERR, "Error!%d", i);
> 
> and so on. This looks pretty compact to me, no?

Yeap, the call looks good.

Thanks.

-- 
tejun
