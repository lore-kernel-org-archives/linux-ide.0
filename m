From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
Subject: Promise PDC20269 - PIO Only?
Date: Sat, 18 Oct 2003 18:19:07 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200310181819.08930.jeremyhu@uclink4.berkeley.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 12-233-44-179.client.attbi.com ([12.233.44.179]:63914 "EHLO
	terminator.outersquare.org") by vger.kernel.org with ESMTP
	id S261950AbTJSBPC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Oct 2003 21:15:02 -0400
Received: from terminator.outersquare.org (localhost.localdomain [127.0.0.1])
	by terminator.outersquare.org (8.12.10/8.12.4) with ESMTP id h9J1JAmJ028166
	for <linux-ide@vger.kernel.org>; Sat, 18 Oct 2003 18:19:10 -0700
Received: from localhost (localhost [[UNIX: localhost]])
	by terminator.outersquare.org (8.12.10/8.12.10/Submit) id h9J1JAC2028165
	for linux-ide@vger.kernel.org; Sat, 18 Oct 2003 18:19:10 -0700
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've been using two Promise PDC20269 cards for almost a year now in my system.
The cards are U133, but when the kernel boots up, I see the message that all
the drives are operating in pio mode.  All the drives are U133 drives, and
they are shown as operating in DMA mode when I put them on another
controller.

I've noticed this deficiency with vanilla linux-2.4.19 through linux-2.4.21,
linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...

Is there a patch to the 2.4 kernels availible to enable this support?  Is this
problem being addressed?  Is there any way I can help out?

Thanks,
Jeremy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/keaMgKpk8srJOlIRAhKDAKCNZt1RWrGP7eTzjwD4XLAs9djT8wCdEzpd
GV8DEdYda15TmJxcZ/RJgU4=
=R+w4
-----END PGP SIGNATURE-----
