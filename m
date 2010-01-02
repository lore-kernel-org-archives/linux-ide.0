From: "David A Sinck" <bugs+linux-ide@grueslayer.com>
Subject: pata_pdc202xx_old regression?
Date: Sat, 2 Jan 2010 13:21:53 -0700
Message-ID: <19263.43745.540746.751448@jabber.grueslayer.com>
Reply-To: bugs+linux-ide@grueslayer.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtai111.cox.net ([68.230.241.49]:62098 "EHLO
	fed1rmmtai111.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0ABUij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jan 2010 15:38:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
          id <20100102202140.YMIQ8308.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <linux-ide@vger.kernel.org>; Sat, 2 Jan 2010 15:21:40 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Greetings & Happy New Year!

I believe I've come across one of two things:

a) a regression in pata_pdc202xx_old
b) a clueless end user wrt the list :-)

The short version: running Ubuntu's Jaunty release (2.6.28-17-generic
#58-Ubuntu i686) I can cleanly access the disks hanging off of an
onboard Promise 20265; attempting to upgrade to Ubuntu Karmic
(presumptively 2.6.31.16.29) has numerious problems reading these same
drives, including:

  e2label: No such file or directory while trying to open /dev/sda1
  Couldn't find a valid filesystem superblock.

I've documented as much as I can think of that's relevant here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/489685

I'm willing to run tests + update the bug with further information
... if I knew what would be useful.

It might even be solved upstream from the release Karmic's using?

Thanks in advance,

David
