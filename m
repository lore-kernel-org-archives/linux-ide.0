From: Andi Kleen <andi@firstfloor.org>
Subject: reenabling disabled ata links from the command line
Date: Sun, 13 Jun 2010 11:06:00 +0200
Message-ID: <20100613090600.GA31086@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:42620 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab0FMJGH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jun 2010 05:06:07 -0400
Received: from basil.firstfloor.org (p5B3C97FE.dip0.t-ipconnect.de [91.60.151.254])
	by one.firstfloor.org (Postfix) with ESMTP id D2A131A980C3
	for <linux-ide@vger.kernel.org>; Sun, 13 Jun 2010 11:06:00 +0200 (CEST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I recently found myself in a situation where I had to recover some data
from a SATA disk with broken sata connector.

In the end I had to reboot quite often to get the sata hardware/driver
to retry to reconnect a link when I fixed the connector in a slightly
different angle.

On the first connect the hardware detected it by itself,
but the problem was that once it lost the link the ata interface
was disabled and only a reset could fix that, I think(?)

So I was wondering is there a way to reenable a link that has been
disabled to try again?

I presume a module reload would do it, but that's not practical when your
root fs is on another SATA port.

Should something like this be implemented?

Thanks,
-Andi

