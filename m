From: Mark Lord <lkml@rtr.ca>
Subject: Re: new tool:  blktool
Date: Thu, 19 Aug 2004 14:04:01 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4124EB91.60706@rtr.ca>
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca> <4124E9F6.6030000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:11709 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266910AbUHSSFU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2004 14:05:20 -0400
In-Reply-To: <4124E9F6.6030000@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

 >* I don't mind HDIO_DRIVE_TASK nearly as much as HDIO_DRIVE_CMD,
 >* since the command protocol is available.

That's not HDIO_DRIVE_TASKFILE, by the way..  a different beast there.

HDIO_DRIVE_TASK is just a slightly different form of HDIO_DRIVE_CMD
for non-data commands (specifically, some SMART commands),
with a more complete register set being exchanged.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
