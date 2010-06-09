From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: [PATCH] Add hook for custom xfer function in PATA Platform driver
Date: Wed, 09 Jun 2010 22:36:01 +1000
Message-ID: <4C0F8AB1.3000403@gmail.com>
References: <1273382493-5859-1-git-send-email-graeme.russ@gmail.com>	 <4BE6910D.9070504@ru.mvista.com> <4BE69C81.2070703@gmail.com>	 <4BE6BA74.10200@mvista.com> <4BE74EEE.5060307@gmail.com>	 <4BE7D714.9010006@ru.mvista.com> <4BE8A3FE.4070402@gmail.com>	 <4BEB166B.5030007@ru.mvista.com> <4BEB7960.40007@gmail.com>	 <4BEC68E6.1020305@mvista.com> <AANLkTikruHKM8W7m9sMHtyApxwLdi6R-I62S54vDsXcO@mail.gmail.com> <4BFD2A8E.7080907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:50141 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755565Ab0FIMgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jun 2010 08:36:06 -0400
Received: by pzk6 with SMTP id 6so2860447pzk.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jun 2010 05:36:04 -0700 (PDT)
In-Reply-To: <4BFD2A8E.7080907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 27/05/10 00:05, Sergei Shtylyov wrote:
> Hello.
> 
> Graeme Russ wrote:
> 
>    Sorry for the belated reply, I've been somewhat busy.

Ditto - I really have not had much time to think more on this one.

To briefly sum up all the arguments, I see three options:

1) Write a new driver based on the PATA Platform driver specifically for my
needs
2) Add the 'custom data xfer hook' to both the PATA and IDE Platform
drivers and implement the 8-bit data xfer functions outside the driver
(board specific code)
3) Add an '8-bit xfer' flag to the PATA and IDE Platform drivers and add
the 8-bit data xfer in the driver

I see #1 as the lowest (zero) impact on current kernel code but #2 is by
far the most flexible and appears to follow driver design philosophy. #3 is
very restrictive and opens up a Pandora's Box of driver code hacks to
support each and every esoteric implementation.

If the consensus is on #2, I'll respin a new patch for both the PATA and
IDE Platform drivers

Regards,

Graeme
