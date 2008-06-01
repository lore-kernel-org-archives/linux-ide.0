From: "Peter Teoh" <htmldeveloper@gmail.com>
Subject: Why my USB disk drive is mounted "WriteProtect is on"?
Date: Mon, 2 Jun 2008 05:34:30 +0800
Message-ID: <804dabb00806011434n47101206t40f50e2398e7a0c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:34635 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYFAVee (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jun 2008 17:34:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so227197and.103
        for <linux-ide@vger.kernel.org>; Sun, 01 Jun 2008 14:34:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, Linux Driver Developers <devel@linuxdriverproject.org>, linux-ide@vger.kernel.org

Got no reply from linux-usb.   So trying here.   In the past I was
able to mount it as "WriteProtect is off"....but one day....suddenly
it became "on" on two of my machine, but the others like 3 still
"off".   So right now the status is as follows:

usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
scsi 6:0:0:0: Direct-Access     WD       1600BEAExternal  1.02 PQ: 0 ANSI: 0
sd 6:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 6:0:0:0: [sdc] Write Protect is on
sd 6:0:0:0: [sdc] Mode Sense: 12 a1 9e af
sd 6:0:0:0: [sdc] Assuming drive cache: write through
sd 6:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 6:0:0:0: [sdc] Write Protect is on
sd 6:0:0:0: [sdc] Mode Sense: 12 a1 9e af
sd 6:0:0:0: [sdc] Assuming drive cache: write through
 sdc: sdc1 sdc2 sdc3 < sdc5 > sdc4
sd 6:0:0:0: [sdc] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg2 type 0
usb-storage: device scan complete

But when u plug out and insert into another machine, it may be
detected as "off", why?

With this writeprotect on, there is no way i can mount it for writing.
  Appreciate your answer very much.

THanks.

-- 
Regards,
Peter Teoh
