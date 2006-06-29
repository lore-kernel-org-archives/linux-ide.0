From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 1/9] libata: change debugging macros/adjust dbg levels
Date: Thu, 29 Jun 2006 22:53:15 +0200
Message-ID: <20060629205315.GA27955@gollum.tnic>
References: <20060629160926.GB23122@zmei.tnic> <44A3FF72.8090404@gmail.com> <20060629172715.GA21339@gollum.tnic> <44A4174C.7020109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:49267 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932504AbWF2UxS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 16:53:18 -0400
Content-Disposition: inline
In-Reply-To: <44A4174C.7020109@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Fri, Jun 30, 2006 at 03:09:16AM +0900, Tejun Heo wrote:
> Please make
> 
> +	ATA_MSG_ERR	= 0,
> +	ATA_MSG_WARN	= 1,
> +	ATA_MSG_DRV	= 2,
> +	ATA_MSG_INFO	= 3, /* revalidation messages, EH progress */
> +	ATA_MSG_VDEBUG	= 4, /* verbose hot path */
> +	ATA_MSG_CMD	= 5, /* issue / completion */
> +	ATA_MSG_SG	= 6, /* SG map/unmap handling */
> +	ATA_MSG_TRACE	= 7, /* function tracing, e.g. enter/exit */
> 
> And test for msg_enable & (1 << (lv)).  Otherwise the array will be 
> unnecessarily large.
Yeah, but this won't work:
imagine default level is:
msg_enable = ATA_MSG_INFO;

which, if done with subsequent numbers will yield 3 decimal and 0011 binary. 
So if i do (1 << lv) and level is currently ATA_MSG_INFO = 3, it will
be decimal 4, and binary 0100. My msg_enable level is 0011 binary so if I do
msg_enable & (1 << lv) it will end up doing 0100 & 0011 and this is 0 although the
message levels are both INFO. In other words, with ATA_MSG_* I need the single
bits set and not consecutive numbers for the unary-and test.

Regards,
    Boris.


		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

