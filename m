From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Mon, 18 Feb 2008 15:47:38 +0000
Message-ID: <20080218154738.41fc0a03@core>
References: <47B97EFA.2040805@caiway.nl>
	<20080218143636.3394eece@core>
	<47B9A25D.4020107@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55267 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753208AbYBRP4J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 10:56:09 -0500
In-Reply-To: <47B9A25D.4020107@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

> I think, but didn't look real good nor test yet, that pata_legacy also 
> needs something comparable to select_proc? Or is that implemented in 
> some generic manner?

It sets it in the timing routine:
	pata_legacy:ht6560b_set_piomode

