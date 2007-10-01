From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Mon, 01 Oct 2007 08:38:42 -0400
Message-ID: <4700EA52.10701@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com>	<46FD1C4A.8010101@garzik.org>	<46FD306C.3050205@gmail.com>	<46FD5DE1.8000206@rtr.ca> <20070928220309.7c9ed816@the-village.bc.nu> <46FDADD9.9050007@garzik.org> <46FE45CE.1050007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44561 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbXJAMiq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Oct 2007 08:38:46 -0400
In-Reply-To: <46FE45CE.1050007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Linux kernel development is supposed to happen incrementally nowadays.
> Get a nice working solution in place, and then enhance/tune it.

It's not about enhancing and tuning.

It's about me (and/or James B) having to __undo__ the current code, just 
to get things working on an entire class of SATA-capable controllers out 
in the field.

	Jeff


