From: Tejun Heo <htejun@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Fri, 25 Aug 2006 02:02:09 +0900
Message-ID: <44EDDB91.1050102@gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>	 <44EC8128.2040204@gmail.com>	 <8202f4270608231212g29e945adg23c32ad1ae132885@mail.gmail.com>	 <44ECAB62.8030804@gmail.com>	 <8202f4270608231255k116918dfk58e4c14cd859c175@mail.gmail.com>	 <8202f4270608231349v5aabace2xaff8fe93c133a7ca@mail.gmail.com>	 <20060824070257.GD21866@htj.dyndns.org> <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:21340 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751650AbWHXRDK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Aug 2006 13:03:10 -0400
Received: by wr-out-0506.google.com with SMTP id i28so195690wra
        for <linux-ide@vger.kernel.org>; Thu, 24 Aug 2006 10:03:10 -0700 (PDT)
In-Reply-To: <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide again]

Fajun Chen wrote:
> Hi Tejun,
> 
> Your patch is successful at fixing the kernel error when adding pata
> drive on 2.6.18-rc2 but there's some sg availability issue.  I did the
> same sequence of test: power off drive -> remove drive -> power on
> drive -> add drive. From dmesg log, pata drive was added back
> successfully as sg0 but somehow it is unavailable for upper level. For
> instance, sg_scan didn't detect it. It is not shown in
> /sys/class/scsi_generic/.  Sg utilities sg_inq and sg_dd complained
> about no such device for sg0.  Is there any magic command I need to
> issue to populate sg information up to the user space? If not, then
> there is still bug somewhere.  Complete log of the test sequence is
> attached.
> 
> I'll hold off the testing on 2.6.18-rc4 for now. Please let me know if
> you think it still makes sense to test your patch in the new release.
> Thanks for your help!

The thing is that the patch shouldn't really change behavior.  With the 
patch, libata might be more forgiving about SCSI refcnt bugs but the 
code before and after are identical correctness-wise.  ISTR there has 
been SCSI ref bug fixed sometime inbetween.  I can't pinpoint it though. 
  So, please try 2.5.18-rc4 w/ or w/o the patch.  Pull 
libata-dev#pata-drivers, that's basically current linus #master + 
libata-dev#upstream updates + Alan's pata-drivers.

Of course, I might be wrong, but I kind of have too little lead to 
follow on at the moment, especially because I can't reproduce it here. 
If testing new kernel on your target platform takes a lot of effort, 
just perform preliminary tests on x86.  As far as SCSI and libata are 
concerned, there's little difference.

-- 
tejun
