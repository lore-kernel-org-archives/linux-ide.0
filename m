From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH/RFC]: recovery from power-up-in-standby feature
Date: Sun, 4 Mar 2007 22:32:06 +0000
Message-ID: <20070304223206.65195c66@lxorguk.ukuu.org.uk>
References: <45EB2F6D.7050407@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51737 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752519AbXCDV7U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 16:59:20 -0500
In-Reply-To: <45EB2F6D.7050407@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> (2) The more common method is for the drive to require an explicit
> set-features "spin-up" subcommand after the IDENTIFY.

I notice there is no ATA version check - was this feature in all versions
of ATA ?
