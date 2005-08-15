From: James Andrewartha <jamesa@daa.com.au>
Subject: High iowait and poor performance - ata_piix
Date: Mon, 15 Aug 2005 17:34:25 +0800
Message-ID: <430061A1.2040806@daa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quoll.daa.com.au ([203.17.251.1]:31402 "EHLO quoll.daa.com.au")
	by vger.kernel.org with ESMTP id S932377AbVHOJen (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Aug 2005 05:34:43 -0400
Received: from [203.17.251.34] (narbalek.daa.com.au [203.17.251.34])
	by quoll.daa.com.au (Postfix) with ESMTP id 5AA9D3F8028
	for <linux-ide@vger.kernel.org>; Mon, 15 Aug 2005 17:34:27 +0800 (WST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got a Proliant DL360 G4 (dual 3.4GHz Xeon, 1GB ram), which has the 
Intel E7520 chipset and uses ata_piix. I'm getting some very high iowait - 
6-10% while idle, and 40-70% while processing mail (which is 
postfix+dpsam/postgresql). I've tried the ubuntu packages for 2.6.{10,11,12} 
with no change.

I also noticed some odd results with bonnie++ - it's slower writing per 
block than per character (although block writing uses a lot less cpu):

2.6.11 on a Seagate ST3160827AS (160GB 7200.7):

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
quoll            4G 22016  42 20982   7 15462   3 32869  56 39013   4 155.9   0

2.6.12 on a Maxtor 6Y080M0 (80GB DiamondPlus 9):

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
quoll-maxtor     4G 30381  53 28041   5 16912   3 35664  61 57015   7 108.3   0

The Seagate results were done on a lvm on raid 1, while the Maxtor was just 
on an lvm, and neither disk was under any significant load while testing 
(mail was turned off). For reference, a 200GB Seagate 7200.7 on a dual 
opteron 242 with 2GB ram and the promise SX8 controller (using the driver 
from the promise website):

Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
martello-seagate 4G 40457  96 58846  28 18211   6 29935  64 62569   8 199.3   0

Unfortunately there's no option in the BIOS to use AHCI mode (if it's even 
possible on this chipset), and it's 1RU system so I can't use another 
controller. Any suggestions on working out what's wrong?

-- 
James Andrewartha
Systems Administrator
Data Analysis Australia Pty Ltd
