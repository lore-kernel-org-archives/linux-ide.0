From: Russ Weeks <rweeks@razorwire.ca>
Subject: sata-nv hotplug feature
Date: Wed, 7 Mar 2007 20:39:18 -0800
Message-ID: <200703072039.18588.rweeks@razorwire.ca>
Reply-To: rweeks@razorwire.ca
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from defout.telus.net ([199.185.220.240]:47232 "EHLO
	defout.telus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbXCHEjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 23:39:22 -0500
Received: from priv-edtnaa05.telusplanet.net ([205.250.220.187])
          by priv-edtnes90.telusplanet.net
          (InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
          id <20070308043921.GZKL28795.priv-edtnes90.telusplanet.net@priv-edtnaa05.telusplanet.net>
          for <linux-ide@vger.kernel.org>; Wed, 7 Mar 2007 21:39:21 -0700
Received: from [192.168.0.102] (d205-250-220-187.bchsia.telus.net [205.250.220.187])
	by priv-edtnaa05.telusplanet.net (BorderWare MXtreme Infinity Mail Firewall) with ESMTP id 0CSNEXKERX
	for <linux-ide@vger.kernel.org>; Wed,  7 Mar 2007 21:39:20 -0700 (MST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

First off, please let me know if I should repost this to a support mailing 
list.  Or, if the answer is 'rtfm', please just point me to the manual.  I 
checked the libata FAQ but can't find what I need.

I'd like some more information regarding the device hotplug feature for the 
sata-nv driver.  The FAQ indicates that 'device hotplug' == 'yank the drive': 
this seems more like 'hot-unplug' to me.  Can I then plug the drive back in 
after I've unplugged it?

This thread:
http://www.mail-archive.com/ubuntu-server@lists.ubuntu.com/msg00182.html

Seems to indicate that I can do it, but I may need to refresh the SCSI device 
system somehow.  This suits my needs just fine, as long as a plug doesn't 
necessitate a reboot.  But running rescan-scsi-bus.sh doesn't seem to work.

uname -a:
Linux backfire 2.6.19.2-smp #2 SMP Sat Mar 3 13:06:28 PST 2007 x86_64 x86_64 
x86_64 GNU/Linux

lspci shows this:
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)

lsmod shows that libata and sata-nv are present.

rescan-scsi-bus.sh shows this (after I boot with 1 drive plugged in and then 
try to plug in the other 2):
OLD: Host: scsi2 Channel: 00 Id: 00 Lun: 00
      Vendor: ATA      Model: ST3250824AS      Rev: 3.AA
      Type:   Direct-Access                    ANSI SCSI revision: 05

(this seems correct, just that 2 other drives are missing)

The hardware is a Tyan Thunder K8W 2895 motherboard with an onboard 
controller.  3 250Gb Seagate Barracudas are attached, 2 are in removable 
drive trays made by some company called 'ByteCC'.

_Any_ advice is appreciated.  I'm really in the dark here.

Thanks,

Russ
