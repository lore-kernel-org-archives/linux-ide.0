From: Marc MERLIN <marc@merlins.org>
Subject: Load cycle and spin down software fixup for WD20EADS and other drives
Date: Mon, 20 Jun 2011 08:35:29 -0700
Message-ID: <20110620153529.GG21438@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:43572 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1FTPfc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 11:35:32 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.72 #1)
	id 1QYgVd-0007Zc-Db
	for <linux-ide@vger.kernel.org>; Mon, 20 Jun 2011 08:35:29 -0700
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

For the list archives (or the wiki if someone can update it), I should post
a fix I wrote years ago for two problems with those WD green drives (a few
others are affected too).

wdidle3 is required to tweak some firmware bits that stop the heads from
parking every 8 seconds on linux.

And then the drives will not properly spin down on a timeout like most
drives will hdparm -S 12

As sad as it is, I wrote a small daemon that checks disk access with iostat
and manually spins the drives down if needed:
http://marc.merlins.org/perso/linux/post_2010-08-03_Spinning-Down-WD20EADS-Drives-and-Fixing-Load-Cycle.html
http://marc.merlins.org/linux/scripts/swdisksusp

Hope this helps someone
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
