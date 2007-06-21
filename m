From: Cal Peake <cp@absolutedigital.net>
Subject: 126X DVD drive? (odd ide-cd output)
Date: Wed, 20 Jun 2007 22:07:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706202155440.1605@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from livid.absolutedigital.net ([66.92.46.173]:3112 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbXFUCOj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jun 2007 22:14:39 -0400
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
	by luxor.inet.absolutedigital.net (8.13.8/8.13.8) with ESMTP id l5L27mAC006121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 22:07:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by lancer.cnet.absolutedigital.net (8.13.8/8.13.5) with ESMTP id l5L27u9R001685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 22:07:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kernel IDE Mailing List <linux-ide@vger.kernel.org>

Hello,

It seems if I boot with a disc in the drive (in this case a dual fs 
ISO-9660/UDF DVD-R) the drive speed gets reported incorrectly:

hdc: DVDRW DRW-6S160P, ATAPI CD/DVD-ROM drive
hdc: ATAPI 126X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)

normal output (w/ no disc) is:

hdc: DVDRW DRW-6S160P, ATAPI CD/DVD-ROM drive
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)

Kernel is 2.6.22-rc5-gf1518a08.

Harmless, but odd...

cheers,
-- 
Cal Peake

