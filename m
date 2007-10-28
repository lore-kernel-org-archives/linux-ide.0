From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH-RFC] Promise SATA300 TX4
Date: Sun, 28 Oct 2007 04:29:02 -0400
Message-ID: <4724484E.4060908@garzik.org>
References: <200710271453.l9RErRj9020770@harpo.it.uu.se> <47235A09.7090409@lxnt.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60649 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbXJ1I3I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 04:29:08 -0400
In-Reply-To: <47235A09.7090409@lxnt.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Sabourenkov <screwdriver@lxnt.info>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, htejun@gmail.com, jgarzik@pobox.com

Alexander Sabourenkov wrote:
> Hmm. sata_promise.c says:
> 
> *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>

That should be changed :)  I wrote the code but Mikael is now the 
primary maintainer.


>> Meanwhile I'll check the Promise driver(s) to see if there's
>> something about SG table formatting restrictions there.
> 
> Take a look at:
> 
> cam_ata.c:6190
> cam_ata.c:6259
> 
> The fix is also conditioned on sg segment length == 0, which I did not
> implement. Is this at all possible in libata ?

The block layer should never pass us a scatterlist element of length zero.

	Jeff


