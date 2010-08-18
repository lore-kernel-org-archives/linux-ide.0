From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Wed, 18 Aug 2010 16:10:16 +0200
Message-ID: <4C6BE9C8.4030803@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>	<4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk>	<4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk>	<4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47642 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab0HROOB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Aug 2010 10:14:01 -0400
In-Reply-To: <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/18/2010 12:03 PM, Alan Cox wrote:
>> Sure, the thing is that your patch doesn't mean we don't have to keep
>> ata_piix device table up-to-date.  We would still need to be
>> maintaining that table whether ata_generic can detect IDE-R by itself
> 
> I'm not sure I follow

I was trying to say that IDE-R basically being the complement of Intel
IDE's not drive by ata_piix, we don't need to maintain a separate PCI
device ID table for IDE-R's.

>> or not.  The device ID table in ata_piix is given, and ata_generic
>> picking up the rest of intel IDE's wouldn't miss anything.  So, unless
>> IDE-R devices need some special treatment, I don't really see how the
>> detection code would be useful.
> 
> The trend is towards AHCI so the problem goes away for the other bits.

Yeah, it has helped a lot but ata_piix's are here to stay for the
foreseeable future and we'll be maintaining its device ID table.

> IDE-R is not ata_piix drivable, and lots of the ICH stuff really wants
> driving via ata_piix, so having the generic driver grab all intel stuff
> isn't as far as I can see going to be safe given a system may load the
> ata_generic module but not PIIX then meet a piix by hotplug.

That's the reason why we have module priorities.  The link priority
becomes module priority and modprobe will deterministically prefer
ata_piix over ata_generic if a controller is supported by both.

Thanks.

-- 
tejun
