From: "Nicolas Baradakis" <nbk@sitadelle.com>
Subject: ITE 8212 controller
Date: Sun, 19 Jun 2005 17:53:49 +0200 (CEST)
Message-ID: <58132.163.5.255.62.1119196429.squirrel@monmail.cegetel.net>
Reply-To: linux-ide@vger.kernel.org, nbk@sitadelle.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mf01.sitadelle.com ([212.94.174.80]:38878 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S262257AbVFSPxu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Jun 2005 11:53:50 -0400
Received: from sitadelle.com (217-19-192-105.dti.cegetel.net [217.19.192.105])
	by smtp.cegetel.net (Postfix) with SMTP id 40D3E3181A3
	for <linux-ide@vger.kernel.org>; Sun, 19 Jun 2005 17:53:47 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

For now, there is no support for ITE 8212 RAID controller in official
released 2.6 kernels. I don't know if many people buy the PCI cards,
but currently ASUS makes motherboard series with onboard ITE 8212F
RAID controllers, available for less than 100 euros. I thought I was
buying a very common motherboard, but in the end I couldn't use all
the IDE connectors. After some search, I found a patch inside the
Fedora kernel package.

I'm not using Fedora, therefore I applied only the patch named
linux-2.6.11-ide-acfixes.patch and successfully built a 2.6.11 kernel
image. The patch adds a new it821x module which correctly detects the
ITE 8212 controller model on my motherboard. I didn't test the RAID
mode, but I can at least report it works in normal IDE mode.

I'm posting to provide positive feedback about this driver, and I
hope the patch will be merged in next kernel releases. The file
linux-2.6.11-ide-acfixes.patch can be found here:
https://www.redhat.com/archives/fedora-cvs-commits/2005-May/msg00462.html

-- 
Nicolas Baradakis


