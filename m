From: Vladimir Stavrinov <vs@inist.ru>
Subject: hardware raid with sata_promise
Date: Wed, 2 Jun 2004 15:09:45 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040602110945.GE6278@svi.inist.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from svi.inist.ru ([195.54.196.230]:12212 "EHLO svi.inist.ru")
	by vger.kernel.org with ESMTP id S261862AbUFBLQI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2004 07:16:08 -0400
Received: from vs by svi.inist.ru with local (Exim 4.34)
	id 1BVTj4-00069i-99
	for linux-ide@vger.kernel.org; Wed, 02 Jun 2004 15:16:06 +0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com

Hi Jeff!

The main question is in subject: does the driver sata_promise
will support hardware raid?

I have 2 sata drives attached to pdc20319 and configured as raid
level 1 (mirror) in it's bios. I should use kernel 2.4.26 with
driver ft3xx to get hardware raid work. I want to use kernel
2.6.6, but the driver sata_promise see 2 (sda and sdb) drives
instead 1 raid array (sda), that mean it don't support raid. I
read somewhere recommendation to use Linux software raid instead
promise hardware raid, because it is better. I don't think so. I
prefer hardware raid. 

Do You plan to add raid support to sata_promise?

-- 

*****************************
****  Vladimir Stavrinov  ***
*******  vs@inist.ru  *******
*****************************
