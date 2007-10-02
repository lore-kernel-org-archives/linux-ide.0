From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 2 Oct 2007 15:25:54 +0100
Message-ID: <20071002152554.5e7e9b0b@the-village.bc.nu>
References: <1190521193410-git-send-email-htejun@gmail.com>
	<46F9BF3E.5050708@garzik.org>
	<46FA1B4E.8090103@gmail.com>
	<46FD079F.3010007@garzik.org>
	<46FD0D50.8030602@gmail.com>
	<46FD1C4A.8010101@garzik.org>
	<46FD306C.3050205@gmail.com>
	<46FD5DE1.8000206@rtr.ca>
	<20070928220309.7c9ed816@the-village.bc.nu>
	<46FDADD9.9050007@garzik.org>
	<46FDE1A7.6030102@gmail.com>
	<4700F6BE.3060904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35492 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072AbXJBOUn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 10:20:43 -0400
In-Reply-To: <4700F6BE.3060904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

> Polling PMP 2.6.24 is completely unacceptable.  It screws the 2.6.24 SAS 
> driver releases out of PMP.

No PMP in 2.6.24 screws PMP users, who outnumber SAS users by a few
thousand to one I suspect.
