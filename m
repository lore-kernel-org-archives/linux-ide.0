From: Ansgar Knappheide <aknapphe@uos.de>
Subject: ATAPI support on Promise controllers
Date: Wed, 09 Aug 2006 13:26:50 +0200
Message-ID: <44D9C67A.3030802@uos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sanode11eth0.rz.Uni-Osnabrueck.DE ([131.173.17.151]:14010 "EHLO
	sanode11.rz.uni-osnabrueck.de") by vger.kernel.org with ESMTP
	id S1030692AbWHIL0w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 07:26:52 -0400
Received: from [131.173.12.121] (cip41.informatik.Uni-Osnabrueck.DE [131.173.12.121])
	by sanode11.rz.uni-osnabrueck.de (8.13.0/8.13.0) with ESMTP id k79BQoXC007720
	for <linux-ide@vger.kernel.org>; Wed, 9 Aug 2006 13:26:50 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE-Kernelliste <linux-ide@vger.kernel.org>

I'm using a Promise Controller PDC40518 (SATAII150 TX4) and got a 
Samsung DVD-Writer SH163A a few month ago and since then I'mwaiting for 
ATAPI support on this driver (sata_promise).
I'm wondering what is missing on this driver, that it defines the 
NO_ATAPI flag.

P.S. I don't have access to the internet, but I'm willing to support 
developing this driver.
