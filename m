From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 19:48:08 +1000
Message-ID: <1217497688.11188.446.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <200807302111.54514.bzolnier@gmail.com>
	 <1217458152.11188.355.camel@pasglop>
	 <200807310248.29214.bzolnier@gmail.com>
	 <20080731094901.062a2602@lxorguk.ukuu.org.uk>
	 <1217495493.11188.441.camel@pasglop>
	 <20080731101322.18735e64@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38434 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbYGaJs2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 05:48:28 -0400
In-Reply-To: <20080731101322.18735e64@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Thu, 2008-07-31 at 10:13 +0100, Alan Cox wrote:
> > I could make the media-bay look like a controller hotplug if it was
> > going to make things easier...
> 
> I'm not sure it will. It may do nowdays, but the older IDE code
> historically was fairly broken for both cases except in 2.4. Also faking
> it as controller hotplug is the wrong path for libata which does real
> drive hot plug.

Yeah, that was my line of thinking initially, also the fact that it has
the nice side effect of keeping the minor number stable.

Ben.


