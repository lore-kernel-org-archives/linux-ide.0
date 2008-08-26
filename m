From: Mark Lord <liml@rtr.ca>
Subject: Re: [regression] sata_mv: harddisk activity led no longer responsive
 on QNAP TS-109
Date: Tue, 26 Aug 2008 10:03:22 -0400
Message-ID: <48B40D2A.1090109@rtr.ca>
References: <200808261124.39282.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58557 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbYHZODY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 10:03:24 -0400
In-Reply-To: <200808261124.39282.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> (Resend with correct address for linux-arm list; with apologies.)
> 
> Starting with kernel 2.6.26 I've noticed that the harddisk (HDD) led on my 
> QNAP TS-109 (which has a Marvel SATA controller as platform device) no 
> longer flashes when there is disk activity. Instead it will just 
> stay "on" all the time. The led worked fine with 2.6.25.
..
> Lennert Buytenhek suggested to try disabling NCQ, and that does indeed 
> make a difference.
..

Well, if you can get us the schematics for that QNAP TS-109 board,
then perhaps we can figure out what controls that LED, and then
determine whether or not it is possible to have it working with NCQ.

Or maybe you can get Saeed Bishara (of Marvell) to investigate.
There may be a standard LED control bit in the chipset somewhere
that is known to internal Marvell engineers.

Cheers
