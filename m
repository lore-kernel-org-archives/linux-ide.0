From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: /dev/sd*
Date: Fri, 18 Aug 2006 17:48:17 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0608181746220.11320@yvahk01.tjqt.qr>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu>
 <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net>
 <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch>
 <44E5B672.1010407@tmr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailer.gwdg.de ([134.76.10.26]:51161 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932216AbWHRPzq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2006 11:55:46 -0400
In-Reply-To: <44E5B672.1010407@tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>, Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>
> For discussion I suggest /proc/ata/devices, a single flat file

Ahem. /sys please. And do not just limit it to ATA.

> matching a name meaningful to open() with a vendor string and
> whatever other info is handy, like serial number and the like. If
> people are going to use ATA that allows them to generate their own
> tools using familiar methods like awk, sed, grep, perl, python or
> whatever. Having that information in an inobvious format will really
> slow adoption by triggering the "it's hard to use" or "I need to use
> all these new tools" responses.
>
> And those responses are not limited to newbies, experienced users are aware of
> the ratio of learning curve to functionality as well.

What would the contents of /ata/devices look like, can you give an
example?


Jan Engelhardt
-- 
