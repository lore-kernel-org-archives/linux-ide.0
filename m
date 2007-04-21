From: Russell Sloan <russell.sloan@lingua-data.com>
Subject: SATA timeout value
Date: Sat, 21 Apr 2007 19:24:03 -0400
Message-ID: <23734110.128641177197843579.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:57578 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbXDUXYH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 21 Apr 2007 19:24:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi everyone,

Can someone point me to the area in the SATA code that is responsible for timing out while checking on a drive connection?

I have a drive that shuts its SATA interface down while it is doing a Security Erase, and then powers back up when it's done.  When I poll the drive asking for its status during the Erase, it is "not there" but the driver takes quite a while to report back.  I'd like to reduce the time that the driver spends checking for the drive.

Thanks!
-Russell
