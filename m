From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH 0/7] S3C64XX: Add platform support for Samsung S3C IDE controller driver
Date: Sun,  1 Nov 2009 13:47:55 +0900
Message-ID: <1257050875-7927-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:53530 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZKAEwk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 00:52:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

This patch set adds platform support for Samsung's S3C IDE controller 
driver. This patch set includes the following patches.

[PATCH 1/7] S3C64XX: Add physical address definition for Compact Flash controller
[PATCH 2/7] S3C64XX: Add MEM_SYS_CFG register definition
[PATCH 3/7] S3C64XX: Add IDE controller register definitions
[PATCH 4/7] S3C64XX: Add clock source definition for IDE controller
[PATCH 5/7] S3C64XX: Add platform data and driver resources for IDE controller driver
[PATCH 6/7] S3C6410: Add platform data for S3C IDE controller driver
[PATCH 7/7] S3C64XX: Include IDE device code in compilation

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
-- 
1.5.3.4

