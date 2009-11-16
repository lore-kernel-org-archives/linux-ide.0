From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 21:55:31 -0800
Message-ID: <20091115215531.23edcf5e@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
	<20091115094630.1785b5ca@infradead.org>
	<4B004328.8060807@kernel.org>
	<20091115102334.1396eea6@infradead.org>
	<4B0047CB.5080509@kernel.org>
	<20091115103313.4691924d@infradead.org>
	<4B00B034.5010908@kernel.org>
	<20091115180058.55caa36f@infradead.org>
	<4B00B5D0.4010707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35760 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbZKPFx4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Nov 2009 00:53:56 -0500
In-Reply-To: <4B00B5D0.4010707@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 11:15:44 +0900
Tejun Heo <tj@kernel.org> wrote:

> > Moving the base accounting logic to libata wasn't too painful (see
> > the patch); moving this very driver specific logic gets a much more
> > intertwigned relationship that at this point in time is just
> > overkill. If someone comes around with a driver that also need it,
> > can we just please resolve it at that time?
> 
> I don't know.  On PM front, it's true that ahci is way more important
> than others.  Implementing things just for ahci has been happening for
> some time now and in the long run it's just not healthy.  It lowers
> maintainability and may even hinder generic implementation.  In this
> case, for example, you're associating link power management with the
> host port, not the link.  Your specific case may be fine but what
> about DIPM on devices attached via PMP?  Internal implementation is
> one thing but you're adding externally visible attribute to the host
> part.  This one thing might be fine but we can't allow things like
> this to pile up.

sigh. so I moved all the generic logic generic, and left the ahci
specific code specific to ahci. I put the logic there where it was
easy to implement, and there where the other link power management
controls are (in sysfs). If that's not good enough, I'm out of my skills
in the libata world to be honest, and would like to ask you to implement
that instead. let me know what sysfs looks like and I'll adjust
powertop to it....


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
