From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Inclusion of patch for Promise SATAII 150 TX4 in mainline 2.6
 kernel?
Date: Mon, 7 Feb 2005 16:03:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0502071601140.31011-100000@coffee.psychology.mcmaster.ca>
References: <42061E0E.2020302@xor.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:27060 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261295AbVBGVDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Feb 2005 16:03:36 -0500
In-Reply-To: <42061E0E.2020302@xor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, Johannes Resch <jr@xor.at>

> has no builtin support for Promise SATAII 150 TX4 yet; a separate patch 
> (http://marc.theaimsgroup.com/?l=linux-ide&m=110426005503319&q=raw) is 
> needed to recognize this hardware.

I had good luck with this patch as well.  I think the SATA-SMART patches
should go in too, even if they aren't perfect yet...

regards, mark hahn.

