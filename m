From: Juergen Beisert <jbe@pengutronix.de>
Subject: How does libata handles an 'ATA_ABORTED' error?
Date: Wed, 14 Dec 2011 09:48:03 +0100
Message-ID: <201112140948.03859.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab1LNItF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Dec 2011 03:49:05 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=localhost)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <jbe@pengutronix.de>)
	id 1RakWO-0003Gk-1H
	for linux-ide@vger.kernel.org; Wed, 14 Dec 2011 09:49:04 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi list,

I have a CF card running in true-ide mode connected to regular PC. This CF 
card does wear leveling of its flash memory internally like every other CF 
card. With one exception: When the CF's firmware detects a broken NAND page 
while writing a sector, it moves around the remaining (good) data to other 
pages. To do this job it must discard the already transmitted sector data in 
its SRAM, because it needs this SRAM to move around the other flash memory 
data.

After the movement the firmware signals an 'ATA_ERR' in the status register 
and an 'ATA_ABORTED' in the error register to force the host to repeat to 
write the same data again (next time it will be successfull due to internal 
wear leveling is already done).

As we see data lost when the systems are running in production, I'm now trying 
to find out if the libata/SCSI layer really repeats the sector write for this 
case and does the expected (or required) things. But I'm lost in these 
software layers and their error path.

I found (in Documentation/DocBook/libata.tmpl):

"This is indicated by UNC bit in the ERROR register.  ATA
devices reports UNC error only after certain number of
retries cannot recover the data, so there's nothing much
else to do other than notifying upper layer."

which sounds to me as no repeat will happen for write errors, but 
the 'ATA_UNC' bit is not used to signal the "wear leveling case" shown above.

As far as I understand the ATA errors are transformed to SCSI errors and then 
handled in the SCSI layer. But the documentation tells me it is not easy to 
always find an adequate SCSI error for an ATA error. So, I'm not sure if for 
the "wear leveling case" the SCSI layer receives a "valuable" error message.

Does anybody can give me a hint, what really happens when the attached drive 
signals an 'ATA_ABORTED'? Does the libata/SCSI give up in this case, or will 
it repeat the command?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
