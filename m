From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 18:30:17 +0200
Message-ID: <4C6AB919.7060203@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>	<4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38544 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab0HQQdo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2010 12:33:44 -0400
In-Reply-To: <20100817174257.3691ed68@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/17/2010 06:42 PM, Alan Cox wrote:
>> This looks scary to me.  Is this something documented somewhere?  It's
>> not like we can avoid adding PCI device IDs completely anyway, so I
>> would suggest just doing it good old fashioned way.
> 
> The trouble with adding all the ids is it will keep needing updates every
> chipset (and a lot of existing idents).

But we do that for some controllers anyway so it's not something new.
ata_piix already has list of all the devices it supports, so maybe
it's safe to grab all intel IDE devices from ata_generic?  ata_piix
always has higher priority than ata_generic anyway and if a device
isn't grabbed by ata_piix, we don't lose anything by grabbing it from
ata_generic.

> Is it documented ? The instructions it was written to came from the
> people who do the chips.

Yeap, that's much better, but I still think it would be better to
avoid such detection magics if possible.

Thanks.

-- 
tejun
