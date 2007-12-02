From: saeed.bishara@gmail.com
Subject: [PATCH 0/2] [libata] sata_mv: Add support for Marvell's integrated SATA controller
Date: Sun,  2 Dec 2007 17:43:15 +0200
Message-ID: <11966101971581-git-send-email-saeed.bishara@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:55454 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750774AbXLBPl0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Dec 2007 10:41:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Saeed Bishara <saeed@marvell.com>

From: Saeed Bishara <saeed@marvell.com>

This patch series adds support for the integrated SATA controller that can be found in some of Marvell's SoC's. This controller is based on the 88SX7042, but it connected directly to the internal bus of the SoC and not via PCI.
