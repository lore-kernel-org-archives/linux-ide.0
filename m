From: Tejun Heo <htejun@gmail.com>
Subject: Re: Unable to access drives via PortMultiplier and SATA/IDE bridge
Date: Sun, 18 May 2008 16:21:22 +0900
Message-ID: <482FD8F2.6050706@gmail.com>
References: <31125479.1210696397791.JavaMail.root@elwamui-norfolk.atl.sa.earthlink.net> <482A5F48.1060901@gmail.com> <003601c8b850$60e14690$6917a8c0@parents>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:57500 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYERHVa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 03:21:30 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1189904waf.23
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 00:21:29 -0700 (PDT)
In-Reply-To: <003601c8b850$60e14690$6917a8c0@parents>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian & Chamaigne Scamman <scammanbc@earthlink.net>
Cc: linux-ide@vger.kernel.org

Brian & Chamaigne Scamman wrote:
> Tejun-
> 
> Sorry for the delay in getting back with you - I wanted to build a clean
> machine and do some more testing before I replied.
> 
> I've installed Fedora Core 9 (2.6.25-14.fc9.i686) along with a single SiI
> 3124-based 4 port controller.
> 
> As I mentioned in an earlier email, I'm using a JM20330 based SATA to IDE
> bridge to connect an IDE solid state drive. The SSD and bridge work fine
> when attached directly to a SATA port, but don't work when attached to a
> port multipler (SiI 3726-based). (For reference, no problems when using
> Windows XP)
> 
> After some experimentation, I found out that if I connected the port
> multipler first (with no drive attached or a standard SATA drive) and then
> attached the SSD/bridge drive, the drive was immediately recognized by the
> kernel.
> 
> I've attached two dmesg log files:
> - dmesg_one_drive_at_a_time.txt is when the PMP was attached with a standard
> SATA drive on port 0 and the SSD/bridge were attached to port 1 later.
> - dmesg_ssd_drive_only_after_pmp.txt is when the PMP was attached with the
> SSD/bridge attached to port 0; after EH timeout, the sata cable was detached
> from port 0 and then re-inserted.
> 
> I've also run cases where the PMP was attached to the computer empty (no
> drives on any ports) and then attached the SSD/bridge with success (port
> independent).
> 
> Let me know if you need more dmesg logs.

sata_sil24 and libata in general have some corner cases where device 
detection fails and I'm cooking up some patches.  Please standby a bit.

Thanks.

-- 
tejun
