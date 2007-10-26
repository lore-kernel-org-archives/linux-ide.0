From: Tejun Heo <htejun@gmail.com>
Subject: Re: marvell 88SX6081 and linux 2.6.23.1
Date: Fri, 26 Oct 2007 14:03:20 +0900
Message-ID: <47217518.10000@gmail.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org> <47214B40.5020408@gmail.com> <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com> <47215DA9.7070403@gmail.com> <20071026044212.ZQST17119.mta11.adelphia.net@dual-xeon.jeffunit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:10833 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbXJZFD2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 01:03:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so683244rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 22:03:28 -0700 (PDT)
In-Reply-To: <20071026044212.ZQST17119.mta11.adelphia.net@dual-xeon.jeffunit.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeffunit <jeff@jeffunit.com>
Cc: linux-ide@vger.kernel.org

jeffunit wrote:
> Based on all of the above, I now suspect a hardware problem with
> /dev/sdb (as you suspected), which was formerly /dev/sda.
> There were two errors with the drive currently attached to /dev/sda, but
> if they
> don't come back, I won't worry.
> 
> Do you concur?

Yeap.  Uncorrectable media errors during READ do occur from time to time
and if you just write over those sectors, the harddrive will
automatically reallocate those tracks to spare area, so just doing "dd
if=/dev/zero of=/dev/sdb bs=1M" and rebuilding FS is likely to fix the
problem.  If that doesn't help, you need to RMA the drive.

-- 
tejun
