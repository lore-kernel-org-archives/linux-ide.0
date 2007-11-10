From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Fri, 09 Nov 2007 22:08:05 -0500
Message-ID: <47352095.4010502@garzik.org>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org> <20071109120425.543971bf@the-village.bc.nu> <20071109233215.GA22498@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49248 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbXKJDIM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Nov 2007 22:08:12 -0500
In-Reply-To: <20071109233215.GA22498@citd.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>, Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

Matthias Schniedermeyer wrote:
> And on the topic of "broken" BIOSes. I have a little empathy for the MB 
> manufactures as non-RAID AHCI royaly screws Windos, so not supporting it 
> reduces their support costs enough to overlook screwing the non-windos 
> faction.

non-RAID AHCI works just fine on Windows.

	Jeff


