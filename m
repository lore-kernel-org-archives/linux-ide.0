From: Mark Lord <liml@rtr.ca>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Sat, 12 Jan 2008 00:08:44 -0500
Message-ID: <47884B5C.8060704@rtr.ca>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>	 <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>	 <7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>	 <20080111195521.7e771e45@lxorguk.ukuu.org.uk>	 <7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>	 <20080111210557.390271a0@lxorguk.ukuu.org.uk>	 <7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>	 <20080111213415.56d90f0d@lxorguk.ukuu.org.uk> <7f68de3e0801111349i2518924bj7bcfd7b5e9c604e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2391 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbYALFIq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Jan 2008 00:08:46 -0500
In-Reply-To: <7f68de3e0801111349i2518924bj7bcfd7b5e9c604e2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Kristin Vadas Marsicano wrote:
>..
> For now, my desired action is to overwrite the drives with random
> characters.  My understanding is that security erase commands are
> implemented in the firmware, and that it may be buggy.  Please correct
> me if my understanding is incorrect.  Also, is there a way to invoke
> the firmware security erase with a linux command?
..

For libata managed drives (/dev/sd*):

    hdparm --security-erase ...

(see also:  hdparm --security-help)
