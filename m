From: kernel <kernel@nea-fast.com>
Subject: A little confused - Silicon Image 3112
Date: Mon, 17 Jan 2005 12:25:57 -0500
Message-ID: <41EBF525.4090500@nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.nea-fast.com ([66.35.146.201]:47310 "EHLO
	int1.nea-fast.com") by vger.kernel.org with ESMTP id S262343AbVAQRZ5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jan 2005 12:25:57 -0500
Received: from nea-fast.com (unknown [192.168.1.101])
	by int1.nea-fast.com (Postfix) with ESMTP id ADDD328058B8
	for <linux-ide@vger.kernel.org>; Mon, 17 Jan 2005 12:25:56 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm wanting to set up a sata raid 1 (non booting) array with a SIL 3112 
chipset (2.4.28 kernel).  I'm assuming I need to configure the sata 
driver in and not the MEDLEY driver. Is that correct ? Also, is the 3112 
a software or hardware raid. drivers/ide/raid/medley.c calls it software 
raid but is that only if it's set up as an ide device ??

Thanks !
walt

