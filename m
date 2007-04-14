From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Sat, 14 Apr 2007 18:18:47 -0400
Message-ID: <46215347.2000403@rtr.ca>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se> <462136AF.9060505@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:2990 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbXDNWSu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Apr 2007 18:18:50 -0400
In-Reply-To: <462136AF.9060505@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>>> - correct the chipset names (from CMDxxx to PCI-xxx)
> 
>> Please explain why this rename is a correction.
> 
>   Because the chips are officially named PCI064[036] and PCI-64[89].

We normally name things with a combination of brand and chip number.
Lots of companies could have chips with PCI in the name,
but the CMD64x designator makes it quite clear what we're dealing with here.

In the machines I have here with these chips,
they are clearly labelled as "CMD" and then "PCI646.."

-ml
