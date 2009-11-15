From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 10:23:34 -0800
Message-ID: <20091115102334.1396eea6@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
	<20091115094630.1785b5ca@infradead.org>
	<4B004328.8060807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55939 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZKOSWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 13:22:34 -0500
In-Reply-To: <4B004328.8060807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 03:06:32 +0900
Tejun Heo <tj@kernel.org> wrote:

> There's DIPM.

where in the code is this?
And just to be clear: DIPM is done by the hardware so that it needs
sampling/etc features, rather than just straightforward (free) software
accounting when you do software controller transitions ?



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
