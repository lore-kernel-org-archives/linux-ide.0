From: Leon Woestenberg <leonw@mailcan.com>
Subject: Marvell SATA for libata?
Date: Sun, 09 May 2004 03:08:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409D84A9.1090107@mailcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:26822 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264251AbUEIBI7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 May 2004 21:08:59 -0400
Received: from mailcan.com (t-indiv3-100.athome.tue.nl [131.155.240.100])
	by www.fastmail.fm (Postfix) with ESMTP id D135CB3174E
	for <linux-ide@vger.kernel.org>; Sat,  8 May 2004 21:08:56 -0400 (EDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all, Jeff Garzik in particular,

we have interest in having the Marvell 88sx5040 SATA controller work
under libata.

Did you happen to start development for this controller, as your
latest libata status report seems to tell so?

We have the Marvell datasheet available (but under NDA) as well as
the source code from SuperMicro and we would like to convert it to
the libata framework.

Regards,

Leon.
