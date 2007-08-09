From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: pata error messages?
Date: Thu, 9 Aug 2007 12:22:02 -0500
Message-ID: <7ADFEAE9-1937-45AE-B4CA-BDE9FE200BF2@freescale.com>
References: <5E26159C-2122-4FE3-9CBF-F50644B7EE5C@freescale.com> <20070809181734.736e8ed4@the-village.bc.nu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:59297 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934812AbXHIRUe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:20:34 -0400
In-Reply-To: <20070809181734.736e8ed4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


On Aug 9, 2007, at 12:17 PM, Alan Cox wrote:

> On Thu, 9 Aug 2007 10:59:12 -0500
> Kumar Gala <kumar.gala@freescale.com> wrote:
>
>> I'm trying to figure out what could cause the following error
>> messages.  This is on a PPC host using a ULI 1575 southbridge:
>
> I'm still chasing problems with ATAPI DMA on some ALi host bridges.  
> I'd
> like to say I knew what was going on but the truth is I'm currently
> diffing lspci out and staring at spec sheets with little result.

yeah, the ALi spec I have for 1575 is terse at best.

I'd be interested in possible register dumps, I'm not sure if we are  
even setting up the controllers properly or not.

- k
