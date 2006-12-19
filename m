From: Matthew Stapleton <matthew4196@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Tue, 19 Dec 2006 10:40:15 +1000
Message-ID: <200612191040.16608.matthew4196@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:41785 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932506AbWLSAk1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Dec 2006 19:40:27 -0500
Received: by an-out-0708.google.com with SMTP id b33so486492ana
        for <linux-ide@vger.kernel.org>; Mon, 18 Dec 2006 16:40:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jan Gutter wrote:
> and the hard drive just uses PIO. With libata, it hangs up randomly,
> causing the driver to eventually clock down to PIO mode too.

I have a new Acer 5614WSMi with similar timeouts, and although it has a 
different model PATA hard drive, the PATA cdrom is the same model and 
firmware version, and it seems to be the cdrom that is timing out.

When I migrated my gentoo install over, the first kernel I tried was 2.6.18 
with both the IDE PIIX driver (manually added the ICH7M pci id to get DMA) 
and libata and I got timeouts on both drivers.  I'm now using libata on 
kernel: 2.6.19-gentoo-r2 which is based on mainline 2.6.19.1 and am still 
getting timeouts.

At first I noticed that the timeouts stop if I don't have any programs running 
(like hald) that regularly query the cdrom.  Then I had a look at the hald 
source code to find out which commands might be causing the timeouts.  I 
wrote a simple test program that just opens the cdrom with "O_RDONLY | 
O_NONBLOCK" then immediately closes it and loops every second and it 
triggered a timeout after a few hours.  Then I changed the delay to 4 seconds 
and still got a timeout after a while.  If I change the test program to only 
open the cdrom once then continously execute a status command such as the 
CDROM_DRIVE_STATUS ioctl every second, the timeouts don't seem to occur.

Hopefully this should help with finding the source of the problem.

-- 
Matthew Stapleton
