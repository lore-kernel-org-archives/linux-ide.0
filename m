From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Tue, 17 Nov 2009 01:25:15 +0900
Message-ID: <4B017CEB.7050309@kernel.org>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org>	<20091115103313.4691924d@infradead.org>	<4B00B034.5010908@kernel.org>	<20091115180058.55caa36f@infradead.org>	<4B00B5D0.4010707@kernel.org>	<20091115215531.23edcf5e@infradead.org>	<4B00EDAC.4080904@kernel.org>	<4B0109BC.1020204@pobox.com>	<20091116064308.741b9a5b@infradead.org>	<4B0168DB.50109@kernel.org>	<20091116072114.65c6fbc2@infradead.org>	<4B017133.3060209@kernel.org> <20091116155734.13912158@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40438 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbZKPQ0S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 11:26:18 -0500
In-Reply-To: <20091116155734.13912158@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

Alan Cox wrote:
>> This is true for all link functions, so I'm suggesting the stats
>> helpers to follow the same convention.  This will also make slave link
>> configuration work properly (controllers which present two SATA links
>> as master/slave of the same port but still provide access to separate
>> SCR registers).  You know, it's a link function, make it take a link
>> as all other stuff is designed that way.
> 
> I don't see how you can do per link reporting on AHCI.
> 
> Sure maybe some devices should expose it per link, but it's so expensive
> and it'll get really ugly fast.

Not for ahci but ata_piix, sis and via already do it.

> I'd say it has to go in at host level for now. If some super whizzo
> future silicon exposes it per link without being beaten around the head
> by the software stack then it's easy enough to add per link data and a
> generic helper which provides a summary set of numbers at the host level
> for hardware that can report link data.
> 
> That gives us a useful API now and the ability to fix it in the future,
> not that I anticipate anyone ever needing to. AHCI (or AHCI-ish) seems to
> be what everyone is working to nowdays with little obvious pressure to
> move anywhere else.

Yeap, agreed.  It just is so ugly (not Arjan's fault).

Thanks.

-- 
tejun
