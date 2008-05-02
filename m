From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 00/12] sata_mv: The last big set for 2.6.26
Date: Fri, 02 May 2008 02:07:00 -0400
Message-ID: <481AAF84.40501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4328 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYEBGHD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 02:07:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff,

Here's my final series of (12) patches, to complete the overhaul of interrupt
and error handling for sata_mv.  With these patches in place, I actually
*would* trust sata_mv with my data.  :)

So perhaps another patch may follow to remove the "HIGHLY EXPERIMENTAL" label.

The only other stuff planned for 2.6.26, are some small errata workarounds
for various chipset "features", as I get to them.  Not many, but a few for sure. 

Please apply for 2.6.26.   Thanks.
