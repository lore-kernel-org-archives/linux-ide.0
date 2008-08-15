From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Fri, 15 Aug 2008 08:27:27 -0400
Message-ID: <48A5762F.7000502@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru> <48A36FE5.5000706@rtr.ca> <48A3E1FF.4030502@ngs.ru> <48A427C0.1070500@rtr.ca> <48A43054.80605@ngs.ru> <48A48C2E.7020902@rtr.ca> <48A5159E.2010508@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53401 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbYHOM10 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Aug 2008 08:27:26 -0400
In-Reply-To: <48A5159E.2010508@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org

Artem Bokhan wrote:
> It uses ncq. Thanks, Mark.
..

Okay, so the ATA specs explicitly require a reset there.
Not much to do about that.

If you were super-keen, though, you could crawl through libata
and try reducing various delays and polling intervals that are
associated with a hard reset for that specific (ahci?) driver
and the core libata routines.

Might shave that 0.75sec down to perhaps 100ms or so.
But again, the optimal numbers in your specific case
will not work for the general case.  It might be possible
to parameterize it all, though, permitting different
values for differing hardware.

Cheers
