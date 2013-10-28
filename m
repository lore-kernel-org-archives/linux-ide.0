From: Shan Hai <shan.hai@windriver.com>
Subject: [PATCH 0/1] Add a quirk for Slimtype DVD drive
Date: Mon, 28 Oct 2013 16:08:00 +0800
Message-ID: <1382947681-32619-1-git-send-email-shan.hai@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46391 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3J1IIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Oct 2013 04:08:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org


The Slimtype DVD DS8A9SH drive could not work with sector size smaller than
65535 bytes, the write would hang on smaller sector sizes, add a qurik to set
the max sector size to 65535 bytes.

drivers/ata/libata-core.c |    1 +
1 files changed, 1 insertions(+), 0 deletions(-)

Thanks
Shan Hai

