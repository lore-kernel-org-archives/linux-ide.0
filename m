From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 15 Nov 2007 11:01:01 +0100 (MET)
Message-ID: <200711151001.lAFA11wC019059@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48058 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756484AbXKOKBb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Nov 2007 05:01:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, jeff@jab.org
Cc: alan@lxorguk.ukuu.org.uk, hancockr@shaw.ca, jeff@garzik.org, liml@rtr.ca, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Thu, 15 Nov 2007 12:32:14 +0900, Tejun Heo wrote:
> * sata_promise: Generally works okay; however there are still some
> problems with recent 3Gbps chips. (Mikael, please pitch in)

Right, 2nd-gen 3Gbps chips have had "intermittent" issues,
which we hope are cured by the recent ASIC bug workaround,
but it will take a while for that fix to propagate out.
To speed up that process I'm considering backporting the fix
to 2.6.23 and 2.6.22.

NCQ and PMP are supported in the hardware and in the vendor's
driver, but not yet in sata_promise. My intention is to add
NCQ soon, but there's no time-plan yet for this.

/Mikael
