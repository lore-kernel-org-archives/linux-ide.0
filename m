From: Mark Lord <liml@rtr.ca>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sun, 23 Sep 2007 12:26:37 -0400
Message-ID: <46F693BD.8070604@rtr.ca>
References: <46C69913.1060505@g7.org>	<46C799E8.8080407@rtr.ca>	<20070819175632.349d11c5@the-village.bc.nu>	<46EC70A0.1000800@g7.org> <20070922191248.5f2bc74a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1584 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbXIWQ0f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 23 Sep 2007 12:26:35 -0400
In-Reply-To: <20070922191248.5f2bc74a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Malcolm Gillies <malcolm@g7.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I've acquired a new CF card that is capable of UDMA2, and with the same 
>> connectors, wiring and adaptor (i.e. I popped out the MWDMA card and 
>> inserted the UDMA one), I can now boot and read data on both devices 
>> without error at reasonable speeds.
> 
> Fascinating. Does point more to a driver funny you are right. At the
> moment I'm at a loss to guess what

We seem to have had a lot of reports of CF cards failing with MDMA modes recently.
Some of these reports are because of SATA<>PATA bridge chips that don't support MDMA,
others are due to unknowns.

The solution is beginning to look more and more obvious:  default to not use MDMA
modes for CF devices at boot.  And eventually provide a sysfs or libata parameter
(or support/snoop SET_XFER_MODE) to change the mode later.

Cheers
