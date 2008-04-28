From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_mv performance; impact of NCQ
Date: Mon, 28 Apr 2008 18:53:38 +0100
Message-ID: <20080428185338.0368ff32@core>
References: <20080426001657.GD17369@modernduck.com>
	<da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com>
	<20080428171449.GI17369@modernduck.com>
	<48160C39.6000701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48104 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934630AbYD1SBB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 14:01:01 -0400
In-Reply-To: <48160C39.6000701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jody McIntyre <scjody@sun.com>, Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

> Or at least that's how I understood Tejun's last explanation of it.
> It is possible that the drive firmware in some brands may not follow
> spec for FLUSH_CACHE_EXT, but I don't know of a specific instance of this.

For an ATA device it should be ok - the standard purposefully specified
flush cache functions in a way that was intended to stop drives lying for
benchmarketing reasons and the like. So you should always get proper
behaviour on any drive which implements it providing barriers are enabled
on the fs.
