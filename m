From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Fri, 7 Nov 2008 06:09:21 +0900
Message-ID: <20081107060921.ad18bb83.komurojun-mbn@nifty.com>
References: <200811061144.35556.marc.pignat@hevs.ch>
	<20081106205522.1c86a44b.komurojun-mbn@nifty.com>
	<200811061309.26939.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userg501.nifty.com ([202.248.238.81]:33506 "EHLO
	userg501.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbYKFVOX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Nov 2008 16:14:23 -0500
In-Reply-To: <200811061309.26939.marc.pignat@hevs.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Pignat <marc.pignat@hevs.ch>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org


> > 
> > > +	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
> 
> I don't want to hardcode the size, however I'm not sure if other size have the
> same prod_id2. " 512MB" with the space at the begginning let me hope there is
> some card exists with 1024, 2048, ... or anything else in that place.
> 

OK. You are right.
Thanks!


Best Regards
Komuro
