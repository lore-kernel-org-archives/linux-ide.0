From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: regarding ata_msg_*()
Date: Mon, 26 Jun 2006 09:41:32 +0200
Message-ID: <20060626074132.GA10695@gollum.tnic>
References: <449E7FB9.4080305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:956 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751041AbWFZHlg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 03:41:36 -0400
Content-Disposition: inline
In-Reply-To: <449E7FB9.4080305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Jun 25, 2006 at 09:21:13PM +0900, Tejun Heo wrote:

Morning,
 
> 	ATA_MSG_DRV	= 0x0001,
> 	ATA_MSG_INFO	= 0x0002,
> 	ATA_MSG_PROBE	= 0x0004,
> 	ATA_MSG_WARN	= 0x0008,
> 	ATA_MSG_MALLOC	= 0x0010,
> 	ATA_MSG_CTL	= 0x0020,
> 	ATA_MSG_INTR	= 0x0040,
> 	ATA_MSG_ERR	= 0x0080,
> 
> * I have no idea what CTL means or why DRV is used in ata_dev_disable().
> 
> * By default, ATA_MSG_INFO is turned off, which means 
> ata_dev_configure() doesn't print anything about newly detected and 
> configured device, which isn't good (BTW, why is @print_info completely 
> ignored in that function?  It's needed.  We don't want to print those 
> messages when we're just revalidating devices.)  Unfortunately, if I 
> enable ATA_MSG_INFO, I enable some of function ENTER/EXIT messages, too. 
>  Bah...

These all are different debugging levels which I proposed leaning on D. Becker's
mail, see linux-ide archives from 25 Aug 2005. I agree that the debugging levels
are somewhat "off-course" but this was not the main concern when sending the
patches. Instead, we aimed first at the complete conversion to the new scheme 
and then reajusting dbbg levels, so this is that...
 
> * In ata_dev_read_id(), ENTER message is CTL, what is CTL?  What makes 
In this mail it says also what CTL means and since nobody opposed to that I went
on preparing the patches.
> ata_port_flush_task() and ata_dev_read_id() share CTL?  And, why are 
> flush#2/EXIT messages CTL while ENTER/flush#1 are left as DPRINTK?
My bad, it seems I've missed those, but there are some cases like
ata_dev_classify(), for ex., where you simply
don't have an access to ata_dev or ata_port struct in order to issue a message
according to the msg_enable status so I left those out for further discussion
concerning replacement.

> All of the above problems are introduced during single sweep conversion 
> over libata-core.c.  It might be that it simply was a bad sweep, but 
> with the current ambiguous definitions, I don't think things will be any 
> better when different people try to use those message types on various LLDs.
> 
> So, please make things *much* simpler.  I think it's overly elaborate to 
> categorize normal (non-debug) messages by message types.  In my 
> experience, such categorization usually ends up mis-categorization - you 
> know, "Is this PROBE or CTL? who cares? make it INFO.  Is INFO debug or 
> normal message?  WTF..."
> 
> IMHO, it's enough to have non-debug messages categorized by verbosity - 
> CRIT, ERR, WARN and INFO and all of them enabled by default.  This also 
> forces developers to suppress the urge to be whiny and refine their 
> messages.  Maybe we can add one more level below INFO for 
> slightly-verbose but not quite debug, but I think we're better off 
> without it.
> 
> For debug messages, we probably need some categorization to separate LLD 
> message from core messages and suppress command issue/completion debug 
> messages unless strictly necessary, etc...  But, those categories MUST 
> be made by necessities (e.g. issue/completion messages suffocates other 
> messages, so they need separate slot.) not by some logical 
> out-of-the-blue categorization.  Otherwise, we end up with categories 
> which may be obvious to some but not so to others and things will get messy.

I guess you're right about the laziness/carelessness (no insinuations
 whatsoever :)) factor with developers but I still 
think it is a good thing to have different debugging levels for different
message semantics and messages origin like interrupts, mem allocation, hardware probing,
etc. I think, though, it would be better to have the debugging scheme running
first and then rehash and reconfigure which debugging levels are appropriate and
enough for libata-dev...

Regards,
    Boris.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

