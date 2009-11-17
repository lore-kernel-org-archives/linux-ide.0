From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Mon, 16 Nov 2009 21:25:49 -0800
Message-ID: <20091116212549.199523f8@infradead.org>
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
	<20091115215531.23edcf5e@infradead.org>
	<4B00EDAC.4080904@kernel.org>
	<4B0109BC.1020204@pobox.com>
	<20091116064308.741b9a5b@infradead.org>
	<4B01C256.1070502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41313 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbZKQFYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 00:24:12 -0500
In-Reply-To: <4B01C256.1070502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 16:21:26 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> On 11/16/2009 09:43 AM, Arjan van de Ven wrote:
> > is there a hardware way to ask for the link status via a link level
> > thing? I thought the sata_scr_read() was by definition a host thing
> 
> It is by definition a link-level thing, which is why sata_scr_read() 
> takes struct ata_link * as its first argument.
> 
> Think about it...  a port multiplier has downstream links, each with 
> their own link status, and link-related statistics.

but also think about it... we can neither call this function with one
of those as argument (since the function is called from irq context,
and not the EH context) nor represent the result.

The former would make it an unsafe API, while right now it's a safe API.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
