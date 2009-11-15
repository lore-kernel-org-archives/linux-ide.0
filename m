From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 09:00:04 -0800
Message-ID: <20091115090004.2037838b@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41977 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZKOQ62 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 11:58:28 -0500
In-Reply-To: <4AFFB65F.3020201@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, akpm@linux-foundation.org

On Sun, 15 Nov 2009 17:05:51 +0900
Tejun Heo <tj@kernel.org> wrote:

> Most of logic seems to belong to libata generic part rather than in
> ahci itself.  Wouldn't it be better to implement the thing as generic
> libata feature which ahci uses?

maybe. AHCI is the only one using it then (2 years ago there was
discussion about having others do alpm as well but.. well nothing has
happened).

Doing "most" in libata means that at best you end up with stuff no
longer local and static, and at worst that you get a bunch of
new function pointers via method tables going around... for
something only one driver is using (with no sight of other users).

If there were going to be more users... I'd absolutely agree with you.
But for only 1 user... I tend to prefer simplicity ;)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
