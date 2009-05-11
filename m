From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: use new sata phy register settings for new	devices
Date: Mon, 11 May 2009 14:34:16 -0400
Message-ID: <4A086FA8.4040102@garzik.org>
References: <20090411160809.GA10922@deprecation.cyrius.com> <da824cf30904111502u50d8f55dj2d0414bb45a49a22@mail.gmail.com> <c70ff3ad0904130026r4aac1ef4le36175ecdfed581c@mail.gmail.com> <49E2EAEC.5030606@garzik.org> <c70ff3ad0904220344x2e2d9ffat2285c76e0ab437c5@mail.gmail.com> <20090504185850.GA11630@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51871 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769AbZEKSeX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 14:34:23 -0400
In-Reply-To: <20090504185850.GA11630@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Mark Lord <liml@rtr.ca>, Grant Grundler <grundler@google.com>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> Mark, can this patch go in now?  It's needed to make SATA operational
> on my Kirkwood-based QNAP TS-219 with a Maxtor drive.
> 
> 
> Subject: [PATCH] sata_mv: use new sata phy register settings for new devices
> From: Saeed Bishara <saeed@marvell.com>
> 
> Marvell's new SoC (65 nano) needs different settings for its SATA
> PHY registers.
> 
> Tested-by: Martin Michlmayr <tbm@cyrius.com>
> Signed-off-by: Saeed Bishara <saeed@marvell.com>

applied -- though I still await answers to maintainer Mark Lord's 
questions:  was this tested with ATAPI and other features?

(rhetorical question... if not... test it!)


