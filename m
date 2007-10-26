From: jeffunit <jeff@jeffunit.com>
Subject: Re: marvell 88SX6081 and linux 2.6.23.1
Date: Fri, 26 Oct 2007 05:22:40 -0700
Message-ID: <20071026122415.EWNN29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org>
 <47214B40.5020408@gmail.com>
 <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
 <47215DA9.7070403@gmail.com>
 <20071026044212.ZQST17119.mta11.adelphia.net@dual-xeon.jeffunit.com>
 <47217518.10000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta9.adelphia.net ([68.168.78.199]:60561 "EHLO
	mta9.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXJZMYR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 08:24:17 -0400
In-Reply-To: <47217518.10000@gmail.com>
References: <S1756649AbXJMTC2/20071013190228Z+1695@xvger.kernel.org>
 <47214B40.5020408@gmail.com>
 <20071026030440.PKWW29317.mta9.adelphia.net@dual-xeon.jeffunit.com>
 <47215DA9.7070403@gmail.com>
 <20071026044212.ZQST17119.mta11.adelphia.net@dual-xeon.jeffunit.com>
 <47217518.10000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, jeffunit <jeff@jeffunit.com>
Cc: linux-ide@vger.kernel.org

At 10:03 PM 10/25/2007, Tejun Heo wrote:
>jeffunit wrote:
> > Based on all of the above, I now suspect a hardware problem with
> > /dev/sdb (as you suspected), which was formerly /dev/sda.
> > There were two errors with the drive currently attached to /dev/sda, but
> > if they
> > don't come back, I won't worry.
> >
> > Do you concur?
>
>Yeap.  Uncorrectable media errors during READ do occur from time to time
>and if you just write over those sectors, the harddrive will
>automatically reallocate those tracks to spare area, so just doing "dd
>if=/dev/zero of=/dev/sdb bs=1M" and rebuilding FS is likely to fix the
>problem.  If that doesn't help, you need to RMA the drive.

I will RMA the drives, as they are new, and the errors are enough to keep
linux from booting (the hard drives are mounted during boot). Hopefully this
will fix my sata disk problems.

thanks for all the help debugging the problem,
jeff

