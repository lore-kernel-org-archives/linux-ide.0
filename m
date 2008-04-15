From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 0/2] libata: add HAVE_PATA_PLATFORM
Date: Tue, 15 Apr 2008 15:43:25 +0100
Message-ID: <20080415144325.363175912@fluff.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:60490 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbYDOP3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 11:29:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE List <linux-ide@vger.kernel.org>

This is an update set, without the PPC modifications
for adding HAVE_PATA_PLATFORM for selecting the
availability of the driver.

If this is acceptable and be queued, I will enqueue
the patches to remove the old bast-ide driver from
the simtec boards in arch/arm/mach-*/ and the base-ide
driver.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
