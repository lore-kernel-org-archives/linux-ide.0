From: Mark Lord <lkml@rtr.ca>
Subject: Re: new tool:  blktool
Date: Thu, 19 Aug 2004 14:42:01 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4124F479.90905@rtr.ca>
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca> <4124E9F6.6030000@pobox.com> <4124EB91.60706@rtr.ca> <4124ED87.6040702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:18109 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267237AbUHSSnU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2004 14:43:20 -0400
In-Reply-To: <4124ED87.6040702@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Yup, that's how I implemented it:  they just piggy back onto
the ATA Passthrough feature.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
