From: "Leon Woestenberg" <leonw@mailcan.com>
Subject: Marvell 88SX504x 88SX508x SATA host controller drivers?
Date: Wed, 05 May 2004 22:30:39 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1083789039.12945.185714943@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:24762 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264804AbUEEUal (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 May 2004 16:30:41 -0400
Received: from server2.messagingengine.com (server2.internal [10.202.2.133])
	by mail.messagingengine.com (Postfix) with ESMTP id 0A5A9B1D430
	for <linux-ide@vger.kernel.org>; Wed,  5 May 2004 16:30:39 -0400 (EDT)
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am aware of one open-source driver for the Marvell SATA host controller
series:

Marvell 88SX5040/88SX5041/88SX5080/88SX5081

1 = integrated flash interface
4 = four-port model
8 = eight-port model

It is available here: ftp://ftp.supermicro.com/driver/SATA/DAC_SATA-MV8/
(source code) and should compile under at least Red Hat kernels.

Are there reports on its proven quality, whether SMART works with
smartmontools,
and if/how hotplug/hot-add/hot-swap/hot-remove is handled?

I.e. can we run a 4 disk software RAID-5 from this controller and use
hot-swap
and SMART reliably?

Also, I noticed there is no driver yet for the libata framework by Jeff
Garzik.
Jeff reported to work on hotswap RSN so maybe a libata driver for Marvell
is
the way to go?

Given the host controller chip datasheet, would it be hard to add a
libata driver
(what are the hurdles to take?)

Regards,

Leon.
