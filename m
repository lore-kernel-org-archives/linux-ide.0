From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata.h: Don't do a SATA check for 40wire_relaxed
Date: Fri, 23 Nov 2007 20:23:39 -0500
Message-ID: <47477D1B.9050305@garzik.org>
References: <20071119152434.45363e5d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58058 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbXKXBXl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 20:23:41 -0500
In-Reply-To: <20071119152434.45363e5d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Without the valid bits at least one set of TSScorp drives report 0 in
> word 93 for PATA 40 wire, which we (and the specs) say actually means
> SATA. (The SATA version seems to report 80 wire...)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

SATA version on what controller?  Have you verified where the bridge is, 
if it's not reporting word93==0 ?

Is this for 2.6.24-rc, considering that we are late in -rc?

	Jeff



