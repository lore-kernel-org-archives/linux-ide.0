From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH] libata-core.c: restore configuration boot messages in ata_dev_configure()
Date: Tue, 27 Jun 2006 15:13:00 +0200
Message-ID: <20060627131259.GA24191@gollum.tnic>
References: <20060627073335.GA6237@zmei.tnic> <44A123B6.20000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.plus.mail.re2.yahoo.com ([206.190.53.27]:40814 "HELO
	smtp102.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932096AbWF0NNE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jun 2006 09:13:04 -0400
Content-Disposition: inline
In-Reply-To: <44A123B6.20000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, linux IDE ML <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Tue, Jun 27, 2006 at 09:25:26PM +0900, Tejun Heo wrote:

Hi, 
> IMHO, this should be done in the following steps.
> 
> * define ATA_MSG_* and ata_msg_* macros which map 1:1 to the current 
> message levels.

How about we pin down these final dbg levels to the following (both proposals 
merged):

ATA_MSG_ERR
ATA_MSG_WARNING
ATA_MSG_DRV ("standard" driver info, initial cfg messages)

ATA_MSG_INFO maybe) /* revalidation messages, EH progress, more verbose msgs,
                       feats */
ATA_MSG_VDEBUG  /* verbose hot path */, by the way, which are those hotpaths?
ATA_MSG_CMD     /* issue / completion */
ATA_MSG_SG      /* SG map/unmap handling */
ATA_MGS_TRACE   /* function enter/exit */

> * make ata_*_prink()s use ATA_MSG_* instead of KERN_* and embed 
> ata_msg_enable() into ata_*_printk()s.  Convert ALL ata_*_printk()s and 
> convertible DEBUG/VDEBUG()s in single sweep - it doesn't have to be a 
> single patch but post them together.  These conversions touch a lot of 
> places and other patches have to be regenerated afterward.

then do something like

#define ata_(ap|dev)_printk((ap|dev), lv, fmt, args...) \
    if (ata_msg_err(ap)) \
        printk(KERN_ERR"ata%u: "fmt, ...); \
    else if (ata_msg_warn(ap)) \
        printk(KERN_WARNING"ata%u: "fmt, ...); \
        .
        .
        .

and then call them like so:

ata_dev_printk(dev, ATA_MSG_ERR, "Error!%d", i);

and so on. This looks pretty compact to me, no?

Regards,
    Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

