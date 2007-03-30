From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Libata disk corruptor paths ?
Date: Fri, 30 Mar 2007 15:15:25 +0100
Message-ID: <20070330151525.63a5931e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49788 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbXC3NMQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Mar 2007 09:12:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Found these by inspection:

Command issuing goes via ata_qc_reinit() which sets up the device bits
for the command to include the device select bit.

If we are using NCQ then the code in ata_build_rw_tf sets bit 6 directly
without using |= which clears the device select bit and means any NCQ
command will go to the first device regardless.

The non NCQ path thankfully doesn't blat the other bits and right now we
have no slave devices on NCQ supporting hardware I believe.

The same bug is present in the libata patches for HPA, and it pulls the
primary HPA blindly in each case. I've not found any others but they may
be there and the code is a bit fragile around here. I suspect this is the
Macintosh problem.

Is there a reason we can't make exec_internel and/or qc_issue BUG() if
the passed device and tf device bit disagree ?

There is another ugly here too ata_tf_init sets the device bits but
doesn't set TFLAG_DEVICE. Scarily in fact the qc_reinit path that
produces new qc structures doesn't touch tf->flags at all but leaves them
as they were previously (with or without device). Any command issued with
a device set but the flag forgotten is going to work *until* we issue a
command to one device and forget the flag, after a command to another
device, in which case the wrong device will get the command. There are
other flags that will cause lunacy to occur as well - LBA48 being an
obvious one that will blow up in our faces.

Follow the path of a start_stop command - we set the device flag but we
assume the newly allocated command flags started clear, not random. We
don't clear the LBA48 flag either....

Alan



	
