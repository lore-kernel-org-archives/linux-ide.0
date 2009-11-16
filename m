From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Mon, 16 Nov 2009 11:15:44 +0900
Message-ID: <4B00B5D0.4010707@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org>	<20091115103313.4691924d@infradead.org>	<4B00B034.5010908@kernel.org> <20091115180058.55caa36f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42807 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbZKPCOZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 21:14:25 -0500
In-Reply-To: <20091115180058.55caa36f@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Hello,

11/16/2009 11:00 AM, Arjan van de Ven wrote:
> I appreciate the possibility but at this point... it's only that.
> To be honest, nothing in the last 2 or 3 years has moved forward in
> this area that I can see, even DIPM seems to be AHCI only based on a
> grep.

I'm fairly sure some controllers will happily generate phy event
interrupts on power state transitions.

> If a polling controller comes forward it's going to need a whole bunch
> of infrastructure; a sysfs flag to control the polling and its frequency
> being the least of the technical problems.
> 
> Moving the base accounting logic to libata wasn't too painful (see the
> patch); moving this very driver specific logic gets a much more
> intertwigned relationship that at this point in time is just overkill.
> If someone comes around with a driver that also need it, can we just
> please resolve it at that time?

I don't know.  On PM front, it's true that ahci is way more important
than others.  Implementing things just for ahci has been happening for
some time now and in the long run it's just not healthy.  It lowers
maintainability and may even hinder generic implementation.  In this
case, for example, you're associating link power management with the
host port, not the link.  Your specific case may be fine but what
about DIPM on devices attached via PMP?  Internal implementation is
one thing but you're adding externally visible attribute to the host
part.  This one thing might be fine but we can't allow things like
this to pile up.

Thanks.

-- 
tejun
