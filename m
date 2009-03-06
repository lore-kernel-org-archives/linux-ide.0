From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA "target mode" (or "Channel-to-Channel" comm mode)
Date: Fri, 06 Mar 2009 06:34:02 -0500
Message-ID: <49B10A2A.2010207@pobox.com>
References: <49AD34F4.8090008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59703 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbZCFLeL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Mar 2009 06:34:11 -0500
In-Reply-To: <49AD34F4.8090008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Oh BTW...  as a reminder, there is an AHCI clone from ATP out there, 
that also supports SATA target mode.

They didn't post a URL to docs, as I recall, but they did make the docs 
freely available to any who asked.  I have a copy and can email, if 
anyone wants to take a look.

Also FWIW, the AHCI driver needed a few modifications (that never got 
done) to support the ATP variant of AHCI.

	Jeff



