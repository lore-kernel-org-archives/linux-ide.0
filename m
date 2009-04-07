From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 01/03] sata_mv: revert SoC irq breakage
Date: Mon, 06 Apr 2009 20:16:26 -0400
Message-ID: <49DA9B5A.8050809@pobox.com>
References: <49DA2DFD.4010402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53325 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbZDGAQc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Apr 2009 20:16:32 -0400
In-Reply-To: <49DA2DFD.4010402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Maxime Bizon <mbizon@freebox.fr>, Lennert Buytenhek <buytenh@marvell.com>, Saeed Bishara <saeed@marvell.com>

Mark Lord wrote:
> Revert most of commit 6be96ac1d5e4d913e1f48299db083ada5321803b2,
> originally from Lennert Buijtenheck (Marvell) and Saeed Bishara (Marvell),
> since that commit causes sata_mv to oops at startup on SOC "Kirkwood".
> 
> The SOC variants do not have the hpriv->irq_{cause,mask}_ofs registers,
> so don't try to write to them!
> 
> This patch should also be considered for -stable.
> 
> Reported-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied 1-8


> Note: I am mostly in the dark about the sata_mv SOC stuff,
> since I have incomplete documentation and no hardware to test with.

As much as we'd like to always have a test kit for each bit of source 
under our perview, that almost never happens as the driver set expands 
[or, in sata_mv's case, as the driver expands].

You just do as best you can, and poke various people for 
testing/verification of other stuff

