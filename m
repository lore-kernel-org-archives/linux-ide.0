From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: regarding ata_msg_*()
Date: Mon, 26 Jun 2006 10:34:59 +0200
Message-ID: <20060626083459.GA13039@gollum.tnic>
References: <449E7FB9.4080305@gmail.com> <20060626074132.GA10695@gollum.tnic> <449F9427.1080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp101.plus.mail.re2.yahoo.com ([206.190.53.26]:62836 "HELO
	smtp101.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964930AbWFZIfD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:35:03 -0400
Content-Disposition: inline
In-Reply-To: <449F9427.1080806@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Jun 26, 2006 at 05:00:39PM +0900, Tejun Heo wrote:

Hi Tejun,

<snip>
> My suggestion is to keep the current (pre-msg_enable) model for the 
> first conversion and categorize debug messages further after that.  So, 
> message categories will be...
> 
> ATA_MSG_ERR
> ATA_MSG_WARN
> ATA_MSG_INFO
> -------------> all above are enabled by default
> ATA_MSG_DEBUG
> ATA_MSG_VDEBUG
> 
> Then, you have 1-to-1 mapping w/ the existing messages.  You can simply 
> incorporate message enabled tests into ata_*_printk() functions and the 
> conversion would be trivial.
>
> After that's complete, we can diversify ATA_MSG_DEBUG and ATA_MSG_VDEBUG 
> by separating out chatty ones out.  e.g. you can separate out SG 
> mapping/unmapping (including padding) debug messages, which produce 
> massive amount of logs when enabled, into ATA_MSG_SG or something. 
> After several such separations, debug messages should be quite 
> manageable && the categories wouldn't be too elaborate.

Yes, this sounds logical, I like it, it really fits libata more but at the time
I made that msg classification I kinda wanted to stick closely to Becker's
initial implementation :). But you're perfectly right, this is the way to go so
I'll do that after reading what the others have to say. However, as I said
before, IMHO it would be of higher priority now to convert to this new scheme
and changing the dbg levels later would be trivial once we got all of libata
done.

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

