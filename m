From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: PATA_ARTOP oppes in 2.6.38
Date: Mon, 28 Mar 2011 09:25:27 +0200
Message-ID: <19856.14311.395203.113370@pilspetsen.it.uu.se>
References: <4D8FD6D1.2020501@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:43451 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab1C1HZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Mar 2011 03:25:30 -0400
In-Reply-To: <4D8FD6D1.2020501@danielpalmer.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Palmer <me@danielpalmer.co.uk>
Cc: linux-ide@vger.kernel.org

Daniel Palmer writes:
 > Hi,
 > 
 > I posted this on the linux-sh list too 
 > (http://marc.info/?l=linux-sh&m=130121196319157&w=2).
 > With vanilla 2.6.38 the board/arch specific code was generating the 
 > wrong address for one of the IO ports associated with the PATA 
 > controller (I don't really understand how PCI works, I'm just guessing 
 > here based on the dmesg output really.. ;)). In vanilla 2.6.38 
 > pata_artop oops on "Unable to handle kernel paging request at virtual 
 > address 000013ff" instead.. this is now fixed so it's not accessing 
 > outside of the assigned ranges but it still oops.
 > 
 > I've attached the full output from the board below.. you should be able 
 > to see where I load modules and it oops when pata_artop is loaded.
 > 
 > If someone could help me debug this I would be very grateful.

pata_artop works fine with 2.6.38 on one of my older ARM boxes
(a Synology DS101 NAS, arm/mach-ixp4xx/, BSP not in upstream kernel).

I'd suspect an issue with your platform (sh?).  A kernel bisection
should identify the offending commit.
