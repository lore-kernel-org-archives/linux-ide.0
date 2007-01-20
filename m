From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH6-M libata disk timeouts in 2.6.19 (except with small queue
 depth)
Date: Sun, 21 Jan 2007 03:21:48 +0900
Message-ID: <45B25DBC.4020102@gmail.com>
References: <798.1169174977@mdt.dhcp.pit.laurelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:48951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965263AbXATSV4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jan 2007 13:21:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so720274uga
        for <linux-ide@vger.kernel.org>; Sat, 20 Jan 2007 10:21:55 -0800 (PST)
In-Reply-To: <798.1169174977@mdt.dhcp.pit.laurelnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Accetta <maccetta@laurelnetworks.com>
Cc: linux-ide@vger.kernel.org

Mike Accetta wrote:
> The distinguishing factor appears to be the queue depth (4 works, 5
> and various values up to and including 31 fail) not the kernel version.
> I am going to try running with the queue depth clamped at 4 to see if
> this consistently masks the problem.  I may also try some more experiments
> if I have the time, like instrumenting what command was issued right
> before the group that all time out or increasing the SCSI timeout,
> in order to get some more insight into what is going on at the time of
> the failure.

Please report the result of 'hdparm -I /dev/sdX' where sdX is the
problematic disk.  Quite a few drives have problem with NCQ and we have
to blacklist them.

Thanks.

-- 
tejun
