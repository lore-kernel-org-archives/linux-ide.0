From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: /dev/sd*
Date: Wed, 16 Aug 2006 23:17:42 -0400
Message-ID: <44E3DFD6.4010504@PicturesInMotion.net>
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060809212124.GC3691@stusta.de>
 <1155160903.5729.263.camel@localhost.localdomain>
 <20060809221857.GG3691@stusta.de>
 <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta10.srv.hcvlny.cv.net ([167.206.4.205]:34269 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750925AbWHQDRc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 23:17:32 -0400
In-reply-to: <44DB289A.4060503@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Gabor Gombas wrote:
>> AFAIR long ago Linus said he'd like just one major number (and thus only
>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>> getting there.
>
> Yep.  /dev/disk is a long term goal :)
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
I agree with Adrian, users are going to get confused if their devices
are named something different once they switch to this new interface. So
if we're going to confusing them why not just take the big leap and
switch it over to /dev/disk? It seems to make more sense then to have
all IDE and SATA users use /dev/sda for awhile only to down the road
have to to switch to /dev/disk.
