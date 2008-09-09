From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] ahci: Fix long standing Marvell regressions
Date: Tue, 09 Sep 2008 18:18:44 -0400
Message-ID: <48C6F644.9080905@redhat.com>
References: <20080903000538.7500eaf8@lxorguk.ukuu.org.uk>	<48BDCF09.7000603@garzik.org>	<20080903142941.3f25d235@lxorguk.ukuu.org.uk> <20080903144834.35276de7@lxorguk.ukuu.org.uk> <48C54EFF.3060603@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbYIIWV1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Sep 2008 18:21:27 -0400
In-Reply-To: <48C54EFF.3060603@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> applied.  I edited the text a bit, for formatting and clarity only (see 
> attached)
> 
 >   ahci, pata_marvell: play nicely together

I can't see how that's going to work with a 6145 adapter and no PATA devices
attached. The AHCI driver will always defer to pata_marvell (unless
marvell_enable=1 is passed) and pata_marvell will defer to ahci when it doesn't
see any PATA devices.

