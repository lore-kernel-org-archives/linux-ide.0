From: Valentijn Sessink <v.sessink@openoffice.nl>
Subject: IRQ anomaly
Date: Thu, 04 Jan 2007 11:18:49 +0100
Message-ID: <459CD489.7090607@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from openoffice.demon.nl ([212.238.150.237]:37926 "EHLO
	sahara.openoffice.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbXADKhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jan 2007 05:37:54 -0500
Received: from [192.168.112.20] (cadmium.kantoor.openoffice.nl [192.168.112.20])
	by sahara.openoffice.nl (Postfix) with ESMTP id E82203C589
	for <linux-ide@vger.kernel.org>; Thu,  4 Jan 2007 11:18:48 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

We had a problem with a server running Ubuntu Dapper kernel 2.6.15
(Ubuntu version 2.6.15-27-686) and Intel 82801GB/GR/GH with sw-raid on
two Seagate disks. Suddenly, the IRQ servicing the disks got disabled.
The sequence of events seemed just too typical to not mention them here.
What happened (summary):

00:53:46 a SCSI (libata) command timeout, "Scsi parity error"
01:01:00 raid disk failure ("continuing on 1 devices")
01:01:00++ continueing "Aborted Command" messages
[...]
01:30:32 APIC error on CPU0: 00(60)
[...]
01:32:59 the last of a sequence of sda "Aborted Command" messages

Until now, no serious problem; a working (yet degraded) array and a
functional server. Then a few days later we find out, and I issue a
"fdisk -l /dev/sda" just to see what will happen.

This shows another two "aborted command" messages and then, suddenly:
irq 185: nobody cared (try booting with the "irqpoll" option)
[...]
Disabling IRQ #185

... which had the additional result of disabling sdb (the second disk),
hence no further logs and an emergency visit to the machine itself :-(

This is probably just noisy busses or other HW related stuff, but the
fact that (not being able to) reading one SATA disk disables the IRQ
that is (also) used by another SATA disk seemed just too specific too
not mention it on this list. Let's say that I did care about irq 185 :)

The full kernel logs (including the messages after the restart) and an
lspci -v can be found at
http://valentijn.sessink.nl/temp/shja.tgz (20Kb)

If this is just HW related or too obscure, please feel free to ignore
this message; we've only seen this once (and I hope to not see it again).

Best regards,

Valentijn
- --
http://www.openoffice.nl/   Open Office - Linux Office Solutions
Valentijn Sessink  v.sessink@openoffice.nl  +31(0)20-4214059
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFnNSITRf3oaxjt6kRAq1xAJ4tiZ0izxgB6zL7w2RDZmEmA8pcGwCghCM/
fX7j5viCHAZ8LgMxzZ62CLI=
=JMu7
-----END PGP SIGNATURE-----
