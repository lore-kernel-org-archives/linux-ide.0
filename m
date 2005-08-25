From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Promise SATAII150 TX4: strange disk ordering
Date: Fri, 26 Aug 2005 08:48:16 +1000
Message-ID: <430E4AB0.2060600@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:41369 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964990AbVHYWsS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 18:48:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I needed a 4-port SATA controller and this was was picked. It seems
to work OK, however I find that Linux (2.6.12.5 and .13-rc7) see
the disks in a different order than the labelled sockets (which do
match what the BIOS detection lists at bootup).

It is not even the reverse order:
	TX4 socket	sata_promise ata*
	1		4
	2		2
	3		1
	4		3
This order looks stable - I connected a different number of disks
on some ports and this ordering was maintained.

This is the 0x3d18 card.

I saw some mention on the list. Was this resolved as "cannot fix
driver" and introducing driver options to manually order the ports?

How can I ensure stable device names (/dev/sd*)?

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
