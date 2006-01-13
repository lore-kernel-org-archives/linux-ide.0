From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: BUG?: VIA IDE transfer-rate problem
Date: Fri, 13 Jan 2006 19:09:07 +0100
Message-ID: <200601131909.07981.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:31445 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1422779AbWAMSJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2006 13:09:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by toplitzer.net (SX Mail) with ESMTP id 51102BC6C
	for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 19:08:44 +0100 (CET)
Received: from [10.0.0.140] (pc057-adsl.adsl.uni-klu.ac.at [143.205.236.57])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by toplitzer.net (SX Mail) with ESMTP id EEBC1BC44
	for <linux-ide@vger.kernel.org>; Fri, 13 Jan 2006 19:08:43 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi!

I've got a question about a small experiment I made:
I tried to find out the transfer-rate of my hd by useing
hdparm -t /dev/hda
and got changing transferrates starting from

37MB/s with CPU not utilized
55MB/s with CPU 100% utilized
22MB/s with ehci-hcd loaded and a device already initilized
55MB/s with ehci-hcd loaded and CPU 100% utilized
(see log1/log2)

So is this supposed normal operation? Or is there
something wrong with it?
Even tried useing the lirc_dev and lirc_i2c kernel-modules
from the lirc project (Infrared remote over usb) and got
only 12MB/s on hda until using CPU with 100%.

So it looks like CPU/USB/IDE is in some interaction. Any
ideas what to do against this. My current kernel is
2.6.15

TIA
Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
