From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Mon, 16 Nov 2009 16:21:26 -0500
Message-ID: <4B01C256.1070502@pobox.com>
References: <20091113192429.4dfc9c39@infradead.org>	<4AFFB65F.3020201@kernel.org>	<4AFFBB75.7050601@pobox.com>	<20091115094630.1785b5ca@infradead.org>	<4B004328.8060807@kernel.org>	<20091115102334.1396eea6@infradead.org>	<4B0047CB.5080509@kernel.org>	<20091115103313.4691924d@infradead.org>	<4B00B034.5010908@kernel.org>	<20091115180058.55caa36f@infradead.org>	<4B00B5D0.4010707@kernel.org>	<20091115215531.23edcf5e@infradead.org>	<4B00EDAC.4080904@kernel.org>	<4B0109BC.1020204@pobox.com> <20091116064308.741b9a5b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34892 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbZKPVVr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2009 16:21:47 -0500
In-Reply-To: <20091116064308.741b9a5b@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On 11/16/2009 09:43 AM, Arjan van de Ven wrote:
> is there a hardware way to ask for the link status via a link level
> thing? I thought the sata_scr_read() was by definition a host thing

It is by definition a link-level thing, which is why sata_scr_read() 
takes struct ata_link * as its first argument.

Think about it...  a port multiplier has downstream links, each with 
their own link status, and link-related statistics.

	Jeff


