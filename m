From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 15:23:26 +0000
Message-ID: <20070316152326.300ae389@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
	<45FA8D7A.3040504@rtr.ca>
	<20070316150129.5bd65c9d@lxorguk.ukuu.org.uk>
	<45FAA692.8080507@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38328 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964871AbXCPOUQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 10:20:16 -0400
In-Reply-To: <45FAA692.8080507@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> Ugh.  The drives default to 520 bytes (always),
> but can specify a different, preferred, length in
> the IDENTIFY data.  A SETFEATURES command is required
> to change the setting from the default of 520.

Thats fine so long as we know the "worst case" length - or I can make it
fall back if the worst case length is over 4K. 

Alan
