From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: System freeze when transferring large files (libata)
Date: Fri, 09 Jul 2004 18:03:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <opsavn7spjfmr65f@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.broadpark.no ([217.13.4.2]:34705 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265022AbUGIQCA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jul 2004 12:02:00 -0400
Received: from mail.broadpark.no (37.80-203-48.nextgentel.com [80.203.48.37])
	by mail.broadpark.no (Postfix) with ESMTP id A1C963C79
	for <linux-ide@vger.kernel.org>; Fri,  9 Jul 2004 18:02:28 +0200 (MEST)
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I've been having this problem lately when transferring large amounts of  
data to my Maxtor DiamondMax Plus 9 SATA 120GB drive, which is connected  
to a Promise SATA150 TX2 Plus controller. It happened once with an -mm  
kernel, but I figured it was probably down to instability in the -mm  
patchset. However it just happened to me again with a vanilla 2.6.6  
kernel, when untarring a backup. The system froze completely, I couldn't  
even use alt+sysrq+b to reboot. Are there any known issues with the  
Promise driver that can lead to such lockups? I've recently run a disc  
check which found no problems (it wasn't Maxtor's own though, but  
Seagate's as the Maxtor tools won't work with the controller).

Thanks

Arve Knudsen
