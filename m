From: Russell Sloan <russell.sloan@lingua-data.com>
Subject: Re: SATA timeout value
Date: Mon, 23 Apr 2007 11:11:54 -0400
Message-ID: <14380803.14661177341114878.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:49536 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbXDWPL4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 11:11:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

I'm using SG_IO and I'm curently passing in:
  sg_io_hdr_t.timeout = 5;

This should be a 5 ms timeout, correct?  I've tried a few different values, from 5 to 1000 and it still takes 90+ seconds for it to timeout and return to my program.

I will try HDIO and see if that behaves any differently.



Russell Sloan wrote:
> Hi everyone,
> 
> Can someone point me to the area in the SATA code that is responsible
> for timing out while checking on a drive connection?
> 
> I have a drive that shuts its SATA interface down while it is doing a
> Security Erase, and then powers back up when it's done.  When I poll
> the drive asking for its status during the Erase, it is "not there"
> but the driver takes quite a while to report back.  I'd like to
> reduce the time that the driver spends checking for the drive.

What tool do you use to issue the query?  If the program uses SG_IO, the
timeout is specified by the program.  If it uses something else (one of
HDIO ioctls), timeouts are hardcoded in the ioctl functions in
libata-scsi.c - currently 10secs.

-- 
tejun
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
