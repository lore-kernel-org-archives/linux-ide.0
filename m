From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH 0/2] pci to dma
Date: Thu,  9 Apr 2015 13:46:26 +0200
Message-ID: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33479 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998AbbDILrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 07:47:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

The first patch removes deprecated use of the pci api.

The second patch depends on the first, it replaces uses of GFP_ATOMIC
with GFP_KERNEL. I could not find evidence that the concerned functions
were called from a context were sleep is not allowed.


---
 cs5520.c    |    2 +-
 pmac.c      |    7 +++----
 setup-pci.c |    2 +-
 sgiioc4.c   |    6 +++---
 4 files changed, 8 insertions(+), 9 deletions(-)

