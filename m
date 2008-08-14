From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands
 concurrently
Date: Thu, 14 Aug 2008 15:49:02 -0400
Message-ID: <48A48C2E.7020902@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru> <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru> <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru> <48A30920.5030803@rtr.ca> <48A33CDC.3000809@ngs.ru> <48A36FE5.5000706@rtr.ca> <48A3E1FF.4030502@ngs.ru> <48A427C0.1070500@rtr.ca> <48A43054.80605@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51386 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754015AbYHNTtE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Aug 2008 15:49:04 -0400
In-Reply-To: <48A43054.80605@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Artem Bokhan wrote:
> Now I spend ~1.9 seconds to serve one bad sector. That's great.
> 0.75 of 1.9 seconds is a time spent on hard reset, 1.15 seconds are 
> spent on reallocation try.
> Is hard reset real necessary to return disk to life after media error?
..

It is necessary in many cases, but not in all.
But the observed behaviour (reset) is the safest way to
guarantee that things will nearly always work by default.

If the drive is NOT using NCQ, and the host controller does not get confused
by the incomplete data transfers (many do), then the reset is not necessary.

You can try hacking it out, if you want to.

Cheers

