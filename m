From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Wed, 18 Aug 2010 08:19:30 +0200
Message-ID: <4C6B7B72.4090405@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>	<4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55376 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab0HRGTP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Aug 2010 02:19:15 -0400
In-Reply-To: <20100817192353.3529733c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/17/2010 08:23 PM, Alan Cox wrote:
>> I don't really think it would be dangerous to grab intel IDE
>> controllers with ata_generic.  Again, that's what windows would do.
>> And for sysfs unbind case, if the user specifically unbinds the
>> controller from ata_piix, what is broken?
> 
> If the user changes the PCI id list what happens ?

Then that's upto the user, right?  That's what the (root) user wants.
You can add any random device ID to any random driver and if you do it
wrong something will break.  That's not different from any other
driver.

>> Maybe it's okay now but who's gonna remember what's going on there
>> after five years and nobody guarantees the above would continue to
> 
> Add a comment ?

Yeah, definitely.  Fat amount of them.

>> hold in the future.
> 
> It did occur to me to check this would be true in the future. Either way
> - an id table would go out of date more often.

Sure, the thing is that your patch doesn't mean we don't have to keep
ata_piix device table up-to-date.  We would still need to be
maintaining that table whether ata_generic can detect IDE-R by itself
or not.  The device ID table in ata_piix is given, and ata_generic
picking up the rest of intel IDE's wouldn't miss anything.  So, unless
IDE-R devices need some special treatment, I don't really see how the
detection code would be useful.

Thanks.

-- 
tejun
