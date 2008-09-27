From: "Jeffrey W. Baker" <jwbaker@gmail.com>
Subject: AHCI power down unused ports merge status?
Date: Sat, 27 Sep 2008 12:39:15 -0700
Message-ID: <1222544355.26413.6.camel@stinklet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:55785 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbYI0TjX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 15:39:23 -0400
Received: by wa-out-1112.google.com with SMTP id v27so702333wah.21
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 12:39:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I was just poking around in the ICH8 documentation and /dev/mem and I
notice that all three of the SATA PHYs on my laptop are enabled, when I
have only one SATA target device.  AHCI allows the port to be disabled,
and this saves a lot of power, but this functionality is not exposed in
Linux.

There are patches floating around on this mailing list to disable the
port by echoing "power_off" to ALPM in sysfs, but this patch isn't
merged in libata-dev and I don't see it in 2.6.27-rc7 either.  Is there
any hope of this getting merged?  Is it dangerous or otherwise not
advised?  

I think users would really appreciate having this.  Disabling unused
ports results in +10% extra battery life on my laptop.

cf http://marc.info/?l=linux-ide&m=121504056904748&w=2

I think part 1 is severable from part 2, so perhaps the sysfs bits can
be merged without the default policy part that seems objectionable.

-jwb

