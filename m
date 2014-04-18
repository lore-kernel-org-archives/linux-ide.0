From: Phillip Susi <psusi@ubuntu.com>
Subject: How to cleanly detach port multiplier ( pmp )
Date: Thu, 17 Apr 2014 21:19:15 -0400
Message-ID: <53507D93.8020901@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:40346 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbaDRBTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 21:19:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I can write to the delete file in the sysfs node for the scsi disk to
cleanly stop the disk and detach the scsi disk driver, but I can find
no similar way to delete the ata link, the pmp, the master link to the
pmp, and disable the ata port.  How are you supposed to disconnect a
port multiplier without causing the kernel to go into error recovery
because the link went dead and the device vanished?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTUH2TAAoJEI5FoCIzSKrwhksH/0whe5rWffNrj+aZY+u+o4tQ
tvNhCNStgxAK6hKi2higHSVHQbO12Vk1JgfNkp0IRDineMkBdGnb3gGFGxgP00V2
onKcPjIgmTL/0zlMx+MJHZRR3nh+6SkbJhdB2dqCDN1l5i4G9Je2lK2hIxs6DYZN
zy7vFL2ftvSPIWC8Z/zVZIYhfiGHp7LoVxVAKSFJaPuU7MhHqdHihlUbaCBPMRJs
YquXAg5euJ98WXSDfqG21hWJgT7L6UnQwV21MnsCuI3euAk83MKQFYClNhewu5kp
C02WdWLrxNjc32bink/kPCHRgjgCC58YHG4zKxRNlOUFCYERVJk4IR9FeCTt3tw=
=qvds
-----END PGP SIGNATURE-----
