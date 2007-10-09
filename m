From: Stian Jordet <liste@jordet.net>
Subject: Linux, SATA and Port Multiplier
Date: Tue, 09 Oct 2007 09:53:56 +0200
Message-ID: <470B3394.5040305@jordet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buick.jordet.net ([193.91.240.190]:52169 "EHLO buick.jordet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbXJIIf7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 04:35:59 -0400
Received: from [82.147.32.178] (port=28799 helo=[32.53.42.95])
	by buick.jordet.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.68)
	(envelope-from <liste@jordet.net>)
	id 1If9qq-0003fw-7F
	for linux-ide@vger.kernel.org; Tue, 09 Oct 2007 09:50:00 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm just trying to be a little proactive. I need to buy a sata card to 
use with an older Intel SC450NX server. I want to use this cabinet:

http://www.stardom.com.tw/sohotank%20st6600.htm

Thus I need port multiplier support. I would also like to have a card 
with both eSATA og interne SATA connectors. I have looked around, and 
found this:

http://www.highpoint-tech.com/USA/rr1742.htm

It seems to use the Marvell 88SX6042 chipset. Does this support port 
multiplier? If not, do you have any recommendations for any PCI 
sata-controller that supports port multiplier? It doesn't have to have 
eSATA, but it needs to have internal sata, and eSATA is a plus.

Regards,
Stian
