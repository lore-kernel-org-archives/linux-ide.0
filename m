From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 00/12] sata_mv NCQ support
Date: Thu, 24 Jan 2008 15:56:08 -0500
Message-ID: <4798FB68.70400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2649 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbYAXU4K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 15:56:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Here is a set of 12 patches that gradually add working NCQ support to sata_mv.

The driver still has issues afterwards, but nothing new that wasn't broken already.
I am working on additional patches to correct the interrupt and error handling
problems that still exist in the driver, as well as PMP and ATAPI support (later).

Patches are against Jeff's #upstream git from this morning.

Cheers

Mark
