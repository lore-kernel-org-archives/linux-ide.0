From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] drivers: ata: Read Rx water mark value from device-tree
Date: Wed, 02 Mar 2016 12:42:12 +0100
Message-ID: <1798710.nJonRpmlxx@wuerfel>
References: <1455974302-7082-1-git-send-email-anuragku@xilinx.com> <3012728.7zDNPtQ7kR@wuerfel> <56D6B217.2000701@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:54514 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbcCBLm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2016 06:42:29 -0500
In-Reply-To: <56D6B217.2000701@xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Anurag Kumar Vulisha <anuragku@xilinx.com>, Rob Herring <robh@kernel.org>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "tj@kernel.org" <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anirudha Sarangi <anirudh@xilinx.com>, Srikanth Vemula <svemula@xilinx.com>, Punnaiah Choudary Kalluri <punnaia@xilinx.com>

On Wednesday 02 March 2016 10:27:51 Michal Simek wrote:
> 
> No problem with default value in driver. Something has to be setup.
> Reset value based on reg spec I was checking is 0x20. Based on our
> testing we saw some issues that's why 0x40 was setup as default value.
> There is a need to be able to configure this value for example for
> testing different values that's why I think module parameter should be
> the right way to go.

I don't object to the module parameter, but I don't understand how important
that kind of testing is to normal users. Who would set it, aside from
the person writing that driver to come up with the correct default?

> If this should be DT parameters there should be different ceva IP which
> allows different fifo size and different watermark level to be setup by
> user.
> 
> What do you think? Does it sound reasonable.

Having a property for the actual hardware fifo size once you get
different implementations seems like the correct approach, but it's
moot as long as all implementations are hardwired to 128 entries.

	Arnd
