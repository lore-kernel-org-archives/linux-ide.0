From: Phillip Susi <psusi@ubuntu.com>
Subject: Understanding staggered spinup
Date: Tue, 24 Sep 2013 10:56:48 -0400
Message-ID: <5241A830.7030903@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:52929 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3IXRCN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Sep 2013 13:02:13 -0400
Received: from cdptpa-omtalb.mail.rr.com ([10.127.143.52])
          by cdptpa-qmta02.mail.rr.com with ESMTP
          id <20130924145758514.QRAO28522@cdptpa-qmta02.mail.rr.com>
          for <linux-ide@vger.kernel.org>; Tue, 24 Sep 2013 14:57:58 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was looking at the libata code that handles the ahci staggered
spinup feature ( SSS ) and am confused as to how this feature can
possibly work.  Cross referencing the AHCI spec with the code, it
seems that the feature simply delays sending COMRESET and initializing
the sata link until we set the SUD bit rather than at power on.
According to the ATA specs though, a drive that powers up in standby
will remain there until given an explicit command ( either SET
FEATURES or a command that requires media access ).  In other words,
COMRESET will not cause the drive to spin up.

Does this feature not really work or am I missing something?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSQagwAAoJEJrBOlT6nu75M+wH/2s8N7HxNcnjNSmIAdotpVdS
qeKzK2nVu6sTtizcBTcnfYx9FXDDx3E0rNeU3Tgyk+DI0qDSs/faDAHBzly/hs0x
f88Nsr4c6DJkPqj+omDQ7dHLt0vAkLn9sfdCCUjm0WqINgklxcOZdmA1PKntPdNT
DSpMAo0QoT4PZDxOA6D866JjoQUi/OgKeMwTGrrnptzUoQVpXkWDXK5aFUkO3HmM
6LAoSmXipy7Jwaln2KYmQdhMyd4Zh+8BSB5SzVjCxYoNf33cVqA4lQ2H7bRQZJll
DEkEeSuexyJHce0TLiFDryG6aWenlqp5SnP/w0n95HQh5aD0cEZv3E6CAngBde8=
=hjty
-----END PGP SIGNATURE-----
