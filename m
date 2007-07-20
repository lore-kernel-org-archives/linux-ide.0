From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Recommendations on user-space soft/hardreset
Date: Fri, 20 Jul 2007 09:14:01 -0600
Message-ID: <8202f4270707200814ja0ba571oa38e25fc2f731a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:49764 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934142AbXGTPOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 11:14:03 -0400
Received: by an-out-0708.google.com with SMTP id d31so188362and
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 08:14:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Yasha Okshtein wrote:
> I need to send soft and/or hard resets from userspace.

>>Actually, you can do it by requesting manual rescan of the SCSI host.
>>"echo - - - > /sys/class/scsi_host/hostX/scan"

I've been using this approach to spin up a PATA drive. However,  I
have not figured out a way to return user scan result from kernel.
For instance, how can I tell if the scan failed at reset or Identify
Device from user space?

Thanks,
Fajun
