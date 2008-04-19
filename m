From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 0/8] sata_mv interrupt/eh fixes etc..
Date: Sat, 19 Apr 2008 14:42:54 -0400
Message-ID: <480A3D2E.4040503@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3963 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900AbYDSSmv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 14:42:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Here are eight more patches for sata_mv.

The focus this time is on a revamp of the interrupt and error handling code,
and re-enabling hotplug (primary ports only) at the end.

The Marvell chips cannot support Asynchronous Notification (AN)
due to errata issues, so hotplug on PM ports is not supported for now.
Hotplug on PM ports would require Tejun's HP polling framework.

Cheers

