From: "Paul Check" <paul@thechecks.ca>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 21 Jan 2010 11:55:14 -0500
Message-ID: <e27693c84c301b2ed78339b217f27bc5.squirrel@thechecks.ca>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>
    <4B58858C.5080502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from d72-38-7-254.commercial1.cgocable.net ([72.38.7.254]:1316 "EHLO
	max" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753201Ab0AUQzR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2010 11:55:17 -0500
In-Reply-To: <4B58858C.5080502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Paul Check <paul@thechecks.ca>, linux-ide@vger.kernel.org


> Link-down means the hardware is reporting that the link between host and
> drive disconnected.  Removing unused or PATA drivers will probably not
> have any effect.
>
> Check your SATA cables and/or power supply.

I have checked the cables and power already. Note that I have two
different power cables attached, one to each pair of drives, and I am
getting the messages on different drives from time to time, not nearly
every time.  I would say it's happening approximately 15% of the time, and
always only occurring on one drive at a time despite having two drives per
power cable.

Given that, it seems unlikely to me to be a cable problem.  Do my symptoms
indicate a possibly faulty SATA controller?  The system is fairly new
(last 1 1/2 months).  It is dual boot but I don't use 2 of the drives in
Windows. That being said, on the other two drives I haven't noticed the
problem occurring there.  So, I am wondering if it is a linux-specific
problem, perhaps with the ahci driver.

P

