From: Andrei Martynov <andrei.martynov@web.de>
Subject: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 10:09:56 +0200
Message-ID: <323951117.20090625100956@web.de>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:39639 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZFYINZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 04:13:25 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id C68BD104FBF4D
	for <linux-ide@vger.kernel.org>; Thu, 25 Jun 2009 10:10:01 +0200 (CEST)
Received: from [80.66.20.180] (helo=PDBAMXP)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277)
	id 1MJk1x-0005MB-00
	for linux-ide@vger.kernel.org; Thu, 25 Jun 2009 10:10:01 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm porting Sigma IDE driver for EM85XX chipset from 2.4.17 to 2.6
kernel for an open-source project. Is there any upgrade guide
available? If not, what are the modern ATA equivalents for old
ide_dma_off, ide_dma_off_quietly and ide_dma_test_irq commands?

-- 
Best regards,
 Andrei                          mailto:andrei.martynov@web.de

