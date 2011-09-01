From: Tim Nufire <linux_ide_tim@ibink.com>
Subject: Power-Up In Standby & Hitachi Deskstar 5K3000 drives
Date: Thu, 1 Sep 2011 14:34:55 -0700
Message-ID: <D0EDEE65-2C64-415C-9659-74F91CB0CCF1@ibink.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yak.ibink.com ([173.255.217.96]:55313 "EHLO yak.ibink.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039Ab1IAVe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Sep 2011 17:34:56 -0400
Received: from c-67-188-108-139.hsd1.ca.comcast.net ([67.188.108.139] helo=[10.100.0.192])
	by yak.ibink.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <linux_ide_tim@ibink.com>)
	id 1QzEuW-00021r-GK
	for linux-ide@vger.kernel.org; Thu, 01 Sep 2011 14:34:56 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm using 3TB Hitachi Deskstar 5K3000 drives in a custom 45 drive high density enclosure (http://blog.backblaze.com/2011/07/20/petabytes-on-a-budget-v2-0revealing-more-secrets) and need to limit the inrush current at startup by stagger the drive spin-up. Since I can't control drive power through by backplanes, the best way to do this appears to be by enabling the Power-Up In Standby feature on the drives via 'hdparm -s1'. Unfortunately this is not working for me....

I believe the problem I'm having is that the Hitachi Deskstar 5K3000 drives require a SET FEATURES subcommand to spin-up to active state when the device has powered-up into Standby. I'm getting this from section 9.1 in the following spec:

http://www.hitachigst.com/tech/techlib.nsf/techdocs/FFDF1FA949853DBD8825785A005CBC55/$file/DS5K3000_US5K3000_OEMSpecRev1.1.pdf

Section 4.17 in the ATA spec that I found at http://t13.org/Documents/UploadedDocuments/docs2006/D1699r3f-ATA8-ACS.pdf says the following:

   A device may implement a SET FEATURES subcommand that notifies the device to spin-up to the Active state when the 
   device has powered-up into Standby. If the device implements this SET FEATURES subcommand and power-up into Standby 
   is enabled, the device shall remain in Standby until the SET FEATURES subcommand is received. If the device implements 
   this SET FEATURES subcommand, the fact that the feature is implemented is reported in the IDENTIFY DEVICE or IDENTIFY 
   PACKET DEVICE data.
   .
   .
   .
   If the device does not implement the SET FEATURES subcommand to spin-up the device after power-up and power-up into 
   Standby is enabled, the device shall spin-up upon receipt of the first command that requires the device to access the 
   media.

Section 7.47.8 then says:

   Subcommand code 07h shall cause a device that has powered-up into Standby to go to the Active state (see 4.17 and figure 7).

>From this I'm concluding the following:

1) Not all drives require the spin up subcommand which explains why this works for some drives

2) Our Hitachi drives require this command and the libATA drivers don't appear to support it

Is this right? If so, is there a reason why the libATA does not support this feature? I'm running Debian 5 with a 2.6.32 kernel... Has this been implemented upstream? Would this be a feature hard to add/backport? 

Thanks,
Tim