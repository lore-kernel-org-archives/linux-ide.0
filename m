From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: pdc20619, ata_promise
Date: Sun, 14 Nov 2004 19:08:32 -0500
Message-ID: <4197F380.6090408@pobox.com>
References: <1100110864.809.4.camel@server.lorenz.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261385AbUKOAIo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Nov 2004 19:08:44 -0500
In-Reply-To: <1100110864.809.4.camel@server.lorenz.priv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias Lorenz <tobias.lorenz@gmx.net>
Cc: linux-ide@vger.kernel.org

Tobias Lorenz wrote:
> Hi,
> 
> will my pdc20619 support in sata_promise be added ?
> Or is anything left to do ?
> 
> I saw that you applied the renamings (s/sata/ata/). Will the module be
> renamed too, as we discussed (sata_promise->ata_promise) ?

Yes, it will be renamed...  I just need to get off my slacker ass and 
make the change for 2.4.x (involves renaming to ata_promise.o, then 
creating sata_promise.o for compatibility)

	Jeff



