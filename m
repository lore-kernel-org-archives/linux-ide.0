From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Fri, 2 Feb 2007 18:47:43 +0000
Message-ID: <20070202184743.1516d1f9@localhost.localdomain>
References: <20070202063748.GC1625@htj.dyndns.org>
	<45C33BCF.2040506@emc.com>
	<45C354CF.1020500@gmail.com>
	<20070202153929.33f4a806@localhost.localdomain>
	<45C36338.60803@rtr.ca>
	<311601c90702020843w16a67db8j5ead05f107161ec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45610 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946026AbXBBSf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 13:35:28 -0500
In-Reply-To: <311601c90702020843w16a67db8j5ead05f107161ec9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> generic PC market, as opposed to "RAID edition" or "MaxLine" or
> similar branding from other vendors, where the firmware may have been
> specifically optimized for quicker command completion, quicker status
> reporting and less exhaustive error recovery.  Many linux users I

Is there a way to detect RAID drives with this kind of timing, or does
someone need to take a baseball bat into the standards committee meeting
and add an identify field that gives command and "long command" timeouts
in seconds ?

If we can detect the "fast fail" drives (initially by say ident string
components) lets do it and the people who care can buy the right product
for the job.

Alan
