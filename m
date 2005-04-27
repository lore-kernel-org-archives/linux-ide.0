From: "Brian Rademacher" <rad@radfiles.net>
Subject: Marvell 88SX6081 driver...
Date: Wed, 27 Apr 2005 00:35:30 -0600
Message-ID: <005801c54af3$4fc24fd0$0301a8c0@Rad>
Reply-To: "Brian Rademacher" <rad@radfiles.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:20990 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261695AbVD0Gfd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Apr 2005 02:35:33 -0400
Received: from Rad (Radlocal [192.168.1.3])
	by radfiles.net (8.12.11/8.12.11) with SMTP id j3R6Ze4K004295
	for <linux-ide@vger.kernel.org>; Wed, 27 Apr 2005 00:35:40 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is anyone working on a driver for this?  I know that Jeff Garzik was working 
on a libata one at one point, but that it was stalled as of February...The 
only driver I can find is the 3.40 release from Marvell, and it rather 
reliably crashes under heavy disk loads (drives go offline)...Marvell has a 
3.41 release on their extranet, but they won't let me have it...

I can't help with the programming end, but I'd be more than happy to beta 
test anything that anyone has...

