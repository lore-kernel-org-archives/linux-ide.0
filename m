From: Mark Lord <liml@rtr.ca>
Subject: Re: IDE driver in polling mode
Date: Thu, 12 Apr 2007 09:43:07 -0400
Message-ID: <461E376B.5030101@rtr.ca>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	<461B9D04.2000109@ru.mvista.com>	<20070410171125.3aeed29d@the-village.bc.nu>	<461BB8C7.9050900@garzik.org>	<20070410172942.7f63d49c@the-village.bc.nu>	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com> <20070411094702.74774d25@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:4825 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbXDLNnG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2007 09:43:06 -0400
In-Reply-To: <20070411094702.74774d25@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael <michaelzwrk@gmail.com>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Michael <michaelzwrk@gmail.com> wrote:
> 
>> Wouldn't it work just to call ide_intr() explicitly from some polling
>> function, as Mark suggested?
> 
> No. See the ATA spec - polling command issue is subtly different.

I beg to differ, and have posted a patch to demonstrate it.

Cheers!
