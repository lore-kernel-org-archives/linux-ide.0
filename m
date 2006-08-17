From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: /dev/sd*
Date: Thu, 17 Aug 2006 11:58:16 +0400
Message-ID: <44E42198.3030500@tls.msk.ru>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:27480 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932250AbWHQH6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Aug 2006 03:58:23 -0400
In-Reply-To: <44E3DFD6.4010504@PicturesInMotion.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Lee Trager wrote:
> Jeff Garzik wrote:
>> Gabor Gombas wrote:
>>> AFAIR long ago Linus said he'd like just one major number (and thus only
>>> one naming scheme) for every disk in the system; with /dev/sd* we're now
>>> getting there.
>> Yep.  /dev/disk is a long term goal :)
[]
> I agree with Adrian, users are going to get confused if their devices
> are named something different once they switch to this new interface. So
> if we're going to confusing them why not just take the big leap and
> switch it over to /dev/disk? It seems to make more sense then to have
> all IDE and SATA users use /dev/sda for awhile only to down the road
> have to to switch to /dev/disk.

The reason, in my opinion anyway, is that not all the word is IDE now,
and it has been this way for a long time.  I mean, real scsi uses /dev/sd*
*right now*, and changing this to /dev/disk* will break just everything,
not only people using IDE.

/mjt

