From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Wed, 21 Sep 2005 19:27:23 +0100
Message-ID: <1127327243.18840.34.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:43956 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751221AbVIUSBO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Sep 2005 14:01:14 -0400
In-Reply-To: <433196B6.8000607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> In the case of CF cards in ide-cs, removing the card is equivalent
> to removing the entire IDE controller, not just the media.

It isn't the same as removing the entire PCMCIA controller layer. As far
as PCMCIA is concerned there has been no change. Thus we have no media
change event and we need ->removable = 1

If the PCMCIA card disappeared each time it would be different

