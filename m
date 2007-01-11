From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 0/2] drivers/ata: PATA driver
	for Celleb
Date: Thu, 11 Jan 2007 17:56:10 +0900
Message-ID: <200701110853.l0B8rjOe018394@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:33292 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030240AbXAKI5w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 03:57:52 -0500
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l0B8vnAD019329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 17:57:50 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0B8rlKx027045
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 17:53:47 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l0B8rl6B027646
	for linux-ide@vger.kernel.org; Thu, 11 Jan 2007 17:53:47 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0B8rjMb010539
	for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 17:53:45 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org

Dear everyone,

This is the patchset (based on 2.6.20-rc4) for PATA controller of
Toshiba Cell reference set(Celleb). I hope this patchset will be
merged to 2.6.21, so please give me any comments.

Best regards,
Akira Iguchi
