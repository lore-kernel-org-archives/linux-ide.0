From: Phillip Susi <psusi@ubuntu.com>
Subject: Tracking down a workqueue io source
Date: Wed, 25 Sep 2013 14:53:07 -0400
Message-ID: <52433113.1000806@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:37472 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3IYSxM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2013 14:53:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I worked up some patches to use the ata SLEEP command instead of
STANDBY to save more power, but I have found that something in the
kernel keeps issuing a request to the disk ( no mounted filesystems on
it ) every 10 minutes.  This request resets the link bringing the disk
back up to STANDBY mode.  blktrace shows the process name is "pool" so
I guess it is a work queue item?  Inserting a dump_stack() was not
helpful.  How can I track down the source of this request?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSQzETAAoJEJrBOlT6nu75Pu0IAMOSNFLbklwCjmVMFZjuQk2x
zrc6xOfPPmPsFqHUPG1TaoSUgzGJXsbZLUeaVFV2ZEIOFJPVl8Vn4Izkzyemk9dp
xtgbtECLMCMZujpqGpL6UwBwBepUfDvoRSpdpcjZ28XByrXS1V8SrQtBw/4HtnDm
Pkmf2MXxlqGDhAxCCuKHfnvjlP2pjfEt8teFH9Vsj4znMJw4BUC8IOepDATwbGd3
WEEv5kqmN27K7ZiEE3zo3jaQMlUtWrJwdyU+1zwvvdTpos/USdem9P4n80s5+CYm
S7e0awRKOjleEZnozyNU9VO5tLViuKyp2096/6+gvna7MIE/Mgj7aWI/S4+A28c=
=f2IA
-----END PGP SIGNATURE-----
