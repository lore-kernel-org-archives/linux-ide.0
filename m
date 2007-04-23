From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA timeout value
Date: Mon, 23 Apr 2007 15:59:44 +0900
Message-ID: <462C5960.1030005@gmail.com>
References: <23734110.128641177197843579.JavaMail.servlet@perfora>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:24057 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbXDWHAm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Apr 2007 03:00:42 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1204851nze
        for <linux-ide@vger.kernel.org>; Mon, 23 Apr 2007 00:00:41 -0700 (PDT)
In-Reply-To: <23734110.128641177197843579.JavaMail.servlet@perfora>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell Sloan <russell.sloan@lingua-data.com>
Cc: linux-ide@vger.kernel.org

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
