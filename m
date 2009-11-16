From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 18:00:58 -0800
Message-ID: <20091115180058.55caa36f@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
	<20091115094630.1785b5ca@infradead.org>
	<4B004328.8060807@kernel.org>
	<20091115102334.1396eea6@infradead.org>
	<4B0047CB.5080509@kernel.org>
	<20091115103313.4691924d@infradead.org>
	<4B00B034.5010908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54655 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZKPB7Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 20:59:24 -0500
In-Reply-To: <4B00B034.5010908@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 10:51:48 +0900
Tejun Heo <tj@kernel.org> wrote:

> 11/16/2009 03:33 AM, Arjan van de Ven wrote:
> >> Enabling DIPM means that the drive will be in charge of
> >> transitioning the link into powersave modes, so if sampling
> >> SStatus is necessary to determine how much time the link spends in
> >> powersave mode.
> > 
> > do we get a link interrupt when the state changes?
> > (with ALPM we do.. optionally.. which is where the flag comes in)
> 
> It will depend on the controller I suppose but we can always poll.
> 

I appreciate the possibility but at this point... it's only that.
To be honest, nothing in the last 2 or 3 years has moved forward in
this area that I can see, even DIPM seems to be AHCI only based on a
grep.

If a polling controller comes forward it's going to need a whole bunch
of infrastructure; a sysfs flag to control the polling and its frequency
being the least of the technical problems.

Moving the base accounting logic to libata wasn't too painful (see the
patch); moving this very driver specific logic gets a much more
intertwigned relationship that at this point in time is just overkill.
If someone comes around with a driver that also need it, can we just
please resolve it at that time?


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
