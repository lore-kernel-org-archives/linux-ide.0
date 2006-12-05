From: Jeff Garzik <jeff@garzik.org>
Subject: Re: -mm merge plans for 2.6.20
Date: Mon, 04 Dec 2006 23:56:42 -0500
Message-ID: <4574FC0A.8090607@garzik.org>
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42368 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968357AbWLEE5A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Dec 2006 23:57:00 -0500
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Andrew Morton wrote:
> via-pata-controller-xfer-fixes.patch
> via-pata-controller-xfer-fixes-fix.patch

Tejun's 3d3cca37559e3ab2b574eda11ed5207ccdb8980a has been ack'd by the 
reporter as fixing things, so these two shouldn't be needed.


> libata_resume_fix.patch

I thought this was resolved long ago?  Are there still open reports that 
this solves, where upstream doesn't work?


> ahci-ati-sb600-sata-support-for-various-modes.patch

With the PCI quirk, I thought ATI was finally sorted?

	Jeff


