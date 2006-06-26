From: Tejun Heo <htejun@gmail.com>
Subject: Re: regarding ata_msg_*()
Date: Mon, 26 Jun 2006 17:00:39 +0900
Message-ID: <449F9427.1080806@gmail.com>
References: <449E7FB9.4080305@gmail.com> <20060626074132.GA10695@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:19016 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932444AbWFZIAm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 04:00:42 -0400
Received: by py-out-1112.google.com with SMTP id t32so1370914pyc
        for <linux-ide@vger.kernel.org>; Mon, 26 Jun 2006 01:00:41 -0700 (PDT)
In-Reply-To: <20060626074132.GA10695@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Borislav.

Borislav Petkov wrote:
>> * By default, ATA_MSG_INFO is turned off, which means 
>> ata_dev_configure() doesn't print anything about newly detected and 
>> configured device, which isn't good (BTW, why is @print_info completely 
>> ignored in that function?  It's needed.  We don't want to print those 
>> messages when we're just revalidating devices.)  Unfortunately, if I 
>> enable ATA_MSG_INFO, I enable some of function ENTER/EXIT messages, too. 
>>  Bah...
> 
> These all are different debugging levels which I proposed leaning on D. Becker's
> mail, see linux-ide archives from 25 Aug 2005. I agree that the debugging levels
> are somewhat "off-course" but this was not the main concern when sending the
> patches. Instead, we aimed first at the complete conversion to the new scheme 
> and then reajusting dbbg levels, so this is that...

I'm sorry that I'm whining now not back then, but better late than 
never, I guess.

>> * In ata_dev_read_id(), ENTER message is CTL, what is CTL?  What makes 
> In this mail it says also what CTL means and since nobody opposed to that I went
> on preparing the patches.

I'll look that up, but whatever it is, please make it apparent in the 
code - please add some comments after constant definitions at the very 
least.

[--snip--]
> I guess you're right about the laziness/carelessness (no insinuations
>  whatsoever :)) factor with developers but I still 

I would be one of the first ones being lazy/careless.  Insinuations 
welcomed.  :-)

> think it is a good thing to have different debugging levels for different
> message semantics and messages origin like interrupts, mem allocation, hardware probing,

To some degree, I agree but for example you mentioned mem allocation as 
one of the categories.  The thing is that libata almost never allocates 
anything during normal operation.  Even hotplug/unplugs are performed 
w/o any memory allocation.  Allocations only occur during driver 
attachment and if allocation fails during that, there's nothing much to 
do than printing error message and giving up - no need for separate 
category.

I'm not saying debug message categorization is unnecessary.  It will be 
useful, but let's do it only on as-needed basis.  IMHO, that will lead 
to the least amount of confusion.

> etc. I think, though, it would be better to have the debugging scheme running
> first and then rehash and reconfigure which debugging levels are appropriate and
> enough for libata-dev...

My suggestion is to keep the current (pre-msg_enable) model for the 
first conversion and categorize debug messages further after that.  So, 
message categories will be...

ATA_MSG_ERR
ATA_MSG_WARN
ATA_MSG_INFO
-------------> all above are enabled by default
ATA_MSG_DEBUG
ATA_MSG_VDEBUG

Then, you have 1-to-1 mapping w/ the existing messages.  You can simply 
incorporate message enabled tests into ata_*_printk() functions and the 
conversion would be trivial.

After that's complete, we can diversify ATA_MSG_DEBUG and ATA_MSG_VDEBUG 
by separating out chatty ones out.  e.g. you can separate out SG 
mapping/unmapping (including padding) debug messages, which produce 
massive amount of logs when enabled, into ATA_MSG_SG or something. 
After several such separations, debug messages should be quite 
manageable && the categories wouldn't be too elaborate.

Thanks.

-- 
tejun
