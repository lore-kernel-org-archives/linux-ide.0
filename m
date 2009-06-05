From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH bug fix 13378] pata_legacy: wait for async probing
Date: Fri, 05 Jun 2009 11:31:19 -0400
Message-ID: <4A293A47.90708@garzik.org>
References: <1244212899.3922.8.camel@mulgrave.site>	<18985.13323.190252.350912@pilspetsen.it.uu.se> <20090605162637.5095972f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57978 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbZFEPb3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Jun 2009 11:31:29 -0400
In-Reply-To: <20090605162637.5095972f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, James Bottomley <James.Bottomley@HansenPartnership.com>, Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, torvalds@linux-foundation.org

Alan Cox wrote:
>> It's not apparent from this description, but the bug is worse
>> than some warnings from the kernel: the kernel hangs hard.
> 
> Jeff seems to have vanished - some of the other trivial ATA one liners
> haven't gone upstream either. He's posted 3 replies since 20th May so
> I've no idea what he is up to (Fedora 11 mad panics perhaps) but this
> patch probably wants to go direct to Linus.

Sorry, yeah that stuff looks good.  Will push today.

	Jeff



