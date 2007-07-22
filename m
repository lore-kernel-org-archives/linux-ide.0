From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: ide patches
Date: Mon, 23 Jul 2007 09:55:06 +1000
Message-ID: <1185148506.5439.80.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52993 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765654AbXGVXzL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 19:55:11 -0400
In-Reply-To: <200707222019.03684.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Note that with all your patches applied, it doesn't seem to auto-tune
the speed at boot anymore and doesn't enable DMA. I can make it do so
with hdparm -d1, in which case, for example, on this wallstreet, I get
MDMA2 which is correct, however, it seems to also set PIO0 which it
should set PIO4...

Ben.


