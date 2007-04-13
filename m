From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Fri, 13 Apr 2007 11:56:26 +0100
Message-ID: <20070413115626.097aadac@the-village.bc.nu>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
	<20070323130315.7ed48121.randy.dunlap@oracle.com>
	<20070413031615.GA21061@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52524 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753368AbXDMKxs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 06:53:48 -0400
In-Reply-To: <20070413031615.GA21061@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

> Pondering about this, it's ATA_LBA according to the docs, specifying
> that the address is an LBA.

This is true for some commands, but not all. It gets used for other stuff
too.
