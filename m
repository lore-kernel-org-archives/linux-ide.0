From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 12 Oct 2011 18:59:52 +0100
Message-ID: <20111012185952.3f36718b@lxorguk.ukuu.org.uk>
References: <20091117.043002.224755438.davem@davemloft.net>
	<20111011.150504.1435090249037873103.davem@davemloft.net>
	<20111011203950.44b714d0@lxorguk.ukuu.org.uk>
	<201110121638.09605.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45983 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753756Ab1JLR74 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 13:59:56 -0400
In-Reply-To: <201110121638.09605.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Miller <davem@davemloft.net>, mpatocka@redhat.com, linux-ide@vger.kernel.org

> > The last state on this I saw it seemd that exactly one person had seen it
> > on exactly one machine ? Has that changed ?
> 
> No, you're right here.

So as far as is known its a weird glitch on one persons box with one
device with one firmware that's not been replicated ?

That's not a patch candidate really is it.

Alan
