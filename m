From: Florian Zumbiehl <florz@florz.de>
Subject: DMA timeouts with JM20330 based SATA<->IDE bridge
Date: Thu, 4 Mar 2010 02:45:58 +0100
Message-ID: <20100304014558.GA8837@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rain.florz.de ([62.216.164.86]:37425 "EHLO
	rain.florz.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755708Ab0CDCJe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 21:09:34 -0500
Received: from florz.florz.dyndns.org ([192.168.0.121])
	by rain.florz.dyndns.org with esmtp (Exim 4.69)
	(envelope-from <florz@florz.de>)
	id 1Nn08V-0007WK-53
	for linux-ide@vger.kernel.org; Thu, 04 Mar 2010 02:45:59 +0100
Received: from florz by florz.florz.dyndns.org with local (Exim 4.69)
	(envelope-from <florz@florz.de>)
	id 1Nn08U-0002Xt-V5
	for linux-ide@vger.kernel.org; Thu, 04 Mar 2010 02:45:59 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have here a SATA<->IDE bridge based on a JM20330 connected to
what the old IDE driver reported like this:

| via82cxxx 0000:00:07.1: VIA vt82c686a (rev 22) IDE UDMA66
| via82cxxx 0000:00:07.1: IDE controller (0x1106:0x0571 rev 0x10)

At the other end, it's connected to a Seagate ST31500341AS
SATA harddisk (well, that's kinda redundant ... ;-).

Now, reading from the disk seems to work perfectly, but writing
(dding /dev/zero to the block device) causes DMA timeouts every
few hundred megabytes - in between the timeouts, though,
throughput seems to be ok (~ 20 MB/s).

Once the fallback mechanism has switched back to PIO4, things seem
to work perfectly, albeit slowly :-)

In the kernel log, the errors look something like this, with
small variations (at least to my eyes ;-):

| ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
| ata2.00: failed command: WRITE DMA EXT
| ata2.00: cmd 35/00:00:67:19:4f/00:04:00:00:00/e0 tag 0 dma 524288 out
|          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
| ata2.00: status: { DRDY }
| ata2: link is slow to respond, please be patient (ready=0)
| ata2: device not ready (errno=-16), forcing hardreset
| ata2: soft resetting link
| ata2.00: configured for UDMA/66
| ata2.00: device reported invalid CHS sector 0
| ata2: EH complete

That's all happening with a vanilla 2.6.33 (plus tuxonice, in case that
could have any effect on this). The legacy IDE drivers behave similarly.

So: Is there anything one could do about that, other than forcing
PIO-only operation? If you need any further information, please let
me know.

BTW, the datasheet of the JM20330 can be found at
http://www.mcuol.com/aspx/down.aspx?id=1266, just in case you didn't
know that yet ...

Florian
