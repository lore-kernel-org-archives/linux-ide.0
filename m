From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
Date: Wed, 25 Jul 2007 14:17:41 -0500
Message-ID: <46A7A1D5.7020003@freescale.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com> <46A7A17C.8090505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:52664 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490AbXGYTRx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 15:17:53 -0400
In-Reply-To: <46A7A17C.8090505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Sergei Shtylyov wrote:
>> It doesn't buy us anything in here, but it's conceivable that someone 
>> may want to write a driver that uses a shift in the I/O accessor 
>> rather than an array of port offsets,
> 
> 
>    It wouldn't be IDE driver then, and neither it would be libata which 
> also does this another way this (despite pata_platform uses shifts too 
> -- not in the accessors, so no speed loss).

The device tree is not just for Linux.

>> equivalent of the cntlzw innstruction, and shift makes it clear that 
>> the stride must be power-of-two).  Plus, using shift is consistent 
>> with what we do on ns16550.
> 
> 
>    Why the heck should we care about the UART code taling about IDE?!

Consistency?

>    So, let me consider your argument purely speculative and invalid. ;-)

Consider it whatever you want. :-)

-Scott
