From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 20:19:19 +0300
Message-ID: <473DD117.1090808@ru.mvista.com>
References: <200711161626.25580.sshtylyov@ru.mvista.com>	<20071116164240.40b02300@the-village.bc.nu>	<473DC942.20803@ru.mvista.com> <20071116165629.6ba73708@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7416 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755421AbXKPRTH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 12:19:07 -0500
In-Reply-To: <20071116165629.6ba73708@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Alan Cox wrote:

>>>>Fix handling of  the PIO modes for the pre-EIDE drives that did not support
>>>>the PIO Flow Control Transfer Mode value (00001 nnn) of the Set Transfer Mode
>>>>feature by  skipping the actual mode programming.

>>>You also need to cater for CF 1.1 compliant devices which do not have set
>>>xfer mode.

>>    Do they have IORDY support?

> Good question. 

    I thought you know. :-)

> CF 1.4 says set features supports 01/0A/55/66/81/8A/9A/BB/CC
> (with 69/96/97 NOP or not recommended)

    Well, the same spec says IORDY may be supported and bit 11 of word 49 may 
be set.  Obviously, no PIO3/4 though.

> However it documents both the PIO mode and DMA word in identify. I've

    So what? That's PIO2 at max, and *default* mode at that, not changeable.

> never seen a CF 1.x card which does DMA or PIO > 2.

    That's something at least.  I hope they also don't set bit 11 -- 
otherwise, bad luck.  Or am I supposed to also check the CF signature? :-)

> CF 1.x is sort of ATA-2 ish but without some set features (eg its got
> idle immediate) and with some stuff that became general later (security
> features)

    Well, at least CF 2.1 documents every imaginable feature value, it seems, 
including Set Transfer Mode of all flavors.

> Alan

MBR, Sergei
