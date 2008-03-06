From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 13:24:31 -0500
Message-ID: <47D036DF.1050200@pobox.com>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D029BF.8040000@pobox.com> <47D02BB2.9000609@rtr.ca> <47D03080.8070405@pobox.com> <47D035D6.1060604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50361 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbYCFSYl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 13:24:41 -0500
In-Reply-To: <47D035D6.1060604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> The big difference here, is that a single SATA controller in a system
> can have up to eight quasi-independent ports.  So when we lock, we block
> activity on all 8 interfaces, rather than just the one we care about.

  ...hence the mention of multi-port NICs.

	Jeff



