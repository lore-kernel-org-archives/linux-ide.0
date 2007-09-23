From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 23 Sep 2007 18:40:45 +0100
Message-ID: <20070923184045.6358014a@the-village.bc.nu>
References: <46C69913.1060505@g7.org>
	<46C799E8.8080407@rtr.ca>
	<20070819175632.349d11c5@the-village.bc.nu>
	<46EC70A0.1000800@g7.org>
	<20070922191248.5f2bc74a@the-village.bc.nu>
	<46F693BD.8070604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53009 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757209AbXIWReR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 13:34:17 -0400
In-Reply-To: <46F693BD.8070604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Malcolm Gillies <malcolm@g7.org>, linux-ide@vger.kernel.org

> The solution is beginning to look more and more obvious:  default to not use MDMA
> modes for CF devices at boot.  And eventually provide a sysfs or libata parameter
> (or support/snoop SET_XFER_MODE) to change the mode later.

I strongly disagree.

We need to understand *why*, we need to fix any actual bugs we have.
Lots and lots of people have no problems here. The people with problems
and pure PATA all seem to have piix chips.

Alan
