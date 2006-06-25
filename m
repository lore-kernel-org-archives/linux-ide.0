From: Tejun Heo <htejun@gmail.com>
Subject: regarding ata_msg_*()
Date: Sun, 25 Jun 2006 21:21:13 +0900
Message-ID: <449E7FB9.4080305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:46707 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWFYMVR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Jun 2006 08:21:17 -0400
Received: by py-out-1112.google.com with SMTP id i49so1284092pyi
        for <linux-ide@vger.kernel.org>; Sun, 25 Jun 2006 05:21:16 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Borislav Petkov <bbpetkov@yahoo.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Jeff, Borislav.

I looked through the ata_msg_*() changes and read Donald Becker's 
message about network driver message control.  This is needed facility 
and I agree with general direction, but I have slightly different ideas 
about details.

We currently have the following message categories.

	ATA_MSG_DRV	= 0x0001,
	ATA_MSG_INFO	= 0x0002,
	ATA_MSG_PROBE	= 0x0004,
	ATA_MSG_WARN	= 0x0008,
	ATA_MSG_MALLOC	= 0x0010,
	ATA_MSG_CTL	= 0x0020,
	ATA_MSG_INTR	= 0x0040,
	ATA_MSG_ERR	= 0x0080,

* I have no idea what CTL means or why DRV is used in ata_dev_disable().

* By default, ATA_MSG_INFO is turned off, which means 
ata_dev_configure() doesn't print anything about newly detected and 
configured device, which isn't good (BTW, why is @print_info completely 
ignored in that function?  It's needed.  We don't want to print those 
messages when we're just revalidating devices.)  Unfortunately, if I 
enable ATA_MSG_INFO, I enable some of function ENTER/EXIT messages, too. 
  Bah...

* In ata_dev_configure(), some ENTER/EXIT messages are INFO while others 
are PROBE.

* In ata_dev_read_id(), ENTER message is CTL, what is CTL?  What makes 
ata_port_flush_task() and ata_dev_read_id() share CTL?  And, why are 
flush#2/EXIT messages CTL while ENTER/flush#1 are left as DPRINTK?

All of the above problems are introduced during single sweep conversion 
over libata-core.c.  It might be that it simply was a bad sweep, but 
with the current ambiguous definitions, I don't think things will be any 
better when different people try to use those message types on various LLDs.

So, please make things *much* simpler.  I think it's overly elaborate to 
categorize normal (non-debug) messages by message types.  In my 
experience, such categorization usually ends up mis-categorization - you 
know, "Is this PROBE or CTL? who cares? make it INFO.  Is INFO debug or 
normal message?  WTF..."

IMHO, it's enough to have non-debug messages categorized by verbosity - 
CRIT, ERR, WARN and INFO and all of them enabled by default.  This also 
forces developers to suppress the urge to be whiny and refine their 
messages.  Maybe we can add one more level below INFO for 
slightly-verbose but not quite debug, but I think we're better off 
without it.

For debug messages, we probably need some categorization to separate LLD 
message from core messages and suppress command issue/completion debug 
messages unless strictly necessary, etc...  But, those categories MUST 
be made by necessities (e.g. issue/completion messages suffocates other 
messages, so they need separate slot.) not by some logical 
out-of-the-blue categorization.  Otherwise, we end up with categories 
which may be obvious to some but not so to others and things will get messy.

Thanks.

-- 
tejun
