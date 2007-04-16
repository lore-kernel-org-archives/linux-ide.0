From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH pata-2.6] cmd64x: procfs code fixes/cleanups (take 2)
Date: Mon, 16 Apr 2007 16:15:21 +0400
Message-ID: <462368D9.8060407@ru.mvista.com>
References: <200704142011.l3EKBBhf025590@harpo.it.uu.se> <462136AF.9060505@ru.mvista.com> <46215347.2000403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:43527 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1030493AbXDPMOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 08:14:24 -0400
In-Reply-To: <46215347.2000403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mikael Pettersson <mikpe@it.uu.se>, bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Mark Lord wrote:

>>>> - correct the chipset names (from CMDxxx to PCI-xxx)

>>> Please explain why this rename is a correction.

>>   Because the chips are officially named PCI064[036] and PCI-64[89].
 
> We normally name things with a combination of brand and chip number.
> Lots of companies could have chips with PCI in the name,
> but the CMD64x designator makes it quite clear what we're dealing with 
> here.

   Note that I'm only changing designator in the procfs output, i.e. not something important to end user.

> In the machines I have here with these chips,
> they are clearly labelled as "CMD" and then "PCI646.."

   Although I've never seen the chip, I guess that should be logo, not the name.

> -ml

MBR, Sergei
