From: mmadore <mmadore@blarg.net>
Subject: Multiple drives with IDNF errors
Date: Thu, 24 Feb 2005 15:37:26 -0800
Message-ID: <7fa3e0801fecb7273ceb02f789c954b2@www.blargmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="b1_7fa3e0801fecb7273ceb02f789c954b2"
Received: from electric.blarg.net ([206.124.128.61]:33473 "EHLO mail.blarg.net")
	by vger.kernel.org with ESMTP id S262571AbVBXXh1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2005 18:37:27 -0500
Received: from mail.blarg.net (localhost.pepe.p.blarg.net [127.0.0.1])
	by mail.blarg.net (Postfix) with ESMTP id 05E5628AD13
	for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2005 15:37:27 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--b1_7fa3e0801fecb7273ceb02f789c954b2
Content-Type: text/plain; charset = "iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

We have an array of 15 Seagate Barracuda 7200.7 (ST3200822AS)
200GB SATA drives, connected to 2 Marvell 88SX6081 8-port SATA
Controllers (Supermicro DAC-SATA-MV8).  The system (X5DPL-TGM &
SC933T-760B) is running RH9 with kernel 2.4.26. The drives are
configured as software RAID 5

The problem we are having is that recently, 6 of the drives have been
ejected from the array (Not all at once).  Using smartctl to look at the
SMART data, every drive that has been ejected has an IDNF error as the
most recent ATA error.  None of the remaining drives have any IDNF
errors.

Running the long selftest after the drive is ejected passes with no
errors.  We have also run the Seatools diagnostics on the drives and it
does not report any errors.  The problem appears to be transient, but is
making the array extremely unstable.

Here is a typical SMART entry from one of the ejected drives:

Error 1 occurred at disk power-on lifetime: 4702 hours (195 days + 22 hours)
   When the command that caused the error occurred, the device was active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   10 51 00 37 4b 2f 45  Error: IDNF at LBA = 0x052f4b37 = 86985527

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   c8 03 08 37 4b 2f 45 00      10:52:36.522  READ DMA
   ca 03 08 2f 4b 2f 45 00      10:52:03.354  WRITE DMA
   ca 03 08 2f 4b 2f 45 00      10:51:35.472  WRITE DMA
   ca 03 08 2f 4b 2f 45 00      10:50:59.478  WRITE DMA
   ca 03 08 2f 4b 2f 45 00      10:50:29.357  WRITE DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)
LBA_of_first_error
# 1  Extended offline    Completed without error       00%      4760         -

What causes a drive to experience an IDNF error?  Does it imply that the drive is defective?  I am including the SMART data from all six drives in case it is useful.

Thanks for any help

Mike

--b1_7fa3e0801fecb7273ceb02f789c954b2
Content-Type: application/x-gzip; name="smart.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smart.txt.gz"

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
aKd52IFxIwv81oHxQw+M/81x8f8BbI+XoXyjAAA=


--b1_7fa3e0801fecb7273ceb02f789c954b2--
