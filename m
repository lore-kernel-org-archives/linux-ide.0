From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] pata_hpt366: fix mode configuration
Date: Wed, 10 Dec 2008 16:00:22 +0900
Message-ID: <493F6906.9010407@kernel.org>
References: <493CC897.9080406@kernel.org> <493CF9A8.301@ru.mvista.com>	 <ce9d8ed60812081518g5d9166baia9fb9531b472dbff@mail.gmail.com>	 <493ECB6C.3040304@rtr.ca> <ce9d8ed60812091302k37b220d1l3dce6878274d8be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36859 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbYLJHAu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Dec 2008 02:00:50 -0500
In-Reply-To: <ce9d8ed60812091302k37b220d1l3dce6878274d8be2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob OpenSuSE <rob.opensuse.linux@googlemail.com>
Cc: Mark Lord <liml@rtr.ca>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Rob OpenSuSE wrote:
> 2008/12/9 Mark Lord <liml@rtr.ca>:
>> Rob OpenSuSE wrote:
>> There are tons of PCI add-on cards still out there with these chips,
>> and they will continue to work fine so long as PCI slots
>> and PATA drives exist.  So we may as well ensure Linux does the Right Things (tm).
> 
> Yes, my point was in support of pragmatism; so that new kernel builds
> and distro installs can have a chance to succeed in boxes with these
> cards used, without opening case,  reconfiguring, and finding special
> boot paramters.  Those cards need working code now, not next year.  So
> "The Right Thing (tm)" would be bad, if it caused perfectly capable
> kit to be non-functioning, whilst perfection is under discussion and
> development.

I already pushed those patches into openSUSE and in one form or
another it will make into upstream and other distros, so no worries.

>> Nice work, Tejun!
> 
> Seconded!  If you are the Mark who sent the card, thanks to you to
> from me to.

Yeap, he's the Mark who sends me old and weird hardwares from time to
time.  :-)

Thanks.

-- 
tejun
