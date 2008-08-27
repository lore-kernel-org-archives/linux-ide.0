From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [regression] sata_mv: harddisk activity led no longer
	responsive on QNAP TS-109
Date: Wed, 27 Aug 2008 17:56:20 +0300
Message-ID: <20080827145620.GJ3622@deprecation.cyrius.com>
References: <200808261124.39282.elendil@planet.nl> <48B40D2A.1090109@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3786 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779AbYH0O4h (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Aug 2008 10:56:37 -0400
Content-Disposition: inline
In-Reply-To: <48B40D2A.1090109@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Frans Pop <elendil@planet.nl>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

* Mark Lord <liml@rtr.ca> [2008-08-26 10:03]:
> Well, if you can get us the schematics for that QNAP TS-109 board,
> then perhaps we can figure out what controls that LED, and then
> determine whether or not it is possible to have it working with NCQ.
>
> Or maybe you can get Saeed Bishara (of Marvell) to investigate.
> There may be a standard LED control bit in the chipset somewhere
> that is known to internal Marvell engineers.

I'm being told that there's a standard LED control bit on Orion, but
hopefully Saeed can comment.  If it's a QNAP specific problem, I can
talk to my contacts at QNAP.
-- 
Martin Michlmayr
http://www.cyrius.com/
