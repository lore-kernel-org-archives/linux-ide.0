From: Mark Lord <liml@rtr.ca>
Subject: Re: stable basic 4-port SATA card
Date: Wed, 14 Nov 2007 23:18:24 -0500
Message-ID: <473BC890.9020902@rtr.ca>
References: <e03b90ae0711132239l258677fbk724204998078a952@mail.gmail.com> <473BBDBE.7060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1804 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbXKOES0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 23:18:26 -0500
In-Reply-To: <473BBDBE.7060208@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Breidenbach <jeff@jab.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
>
> * marvell ones: I don't have much idea.  Jeff?  Mark?
..

Right now, support is rather primitive and incomplete in sata_mv.

That may change over the next few months, as Marvell is beginning to
show some desire to have their chips fully supported, to/beyond the
current levels that sata_sil24 driver currently enjoys.

But right now it is rather spotty.

I don't know much about the other Marvell chips that run under AHCI,
but I hear that they're just fine.

Cheers
