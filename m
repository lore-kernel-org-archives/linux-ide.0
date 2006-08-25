From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: PATA Sil680 Warm Plug Caused 2.6.18-rc2 Kernel Internel Error
Date: Fri, 25 Aug 2006 11:27:04 -0600
Message-ID: <8202f4270608251027j4ae31243laab8a6bd3e433697@mail.gmail.com>
References: <8202f4270608230906r73b1d91bj279bfc0ef4b7a39d@mail.gmail.com>
	 <44ECAB62.8030804@gmail.com>
	 <8202f4270608231255k116918dfk58e4c14cd859c175@mail.gmail.com>
	 <8202f4270608231349v5aabace2xaff8fe93c133a7ca@mail.gmail.com>
	 <20060824070257.GD21866@htj.dyndns.org>
	 <8202f4270608240942i6b620961t1a03d4148dd4a32d@mail.gmail.com>
	 <44EDDB91.1050102@gmail.com>
	 <8202f4270608241701g494bfadaw74dd3d059182e4cc@mail.gmail.com>
	 <8202f4270608250826h67edf5d7n8436961374896348@mail.gmail.com>
	 <44EF18BC.8040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:34618 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750724AbWHYR1F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 13:27:05 -0400
Received: by nz-out-0102.google.com with SMTP id n1so653782nzf
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 10:27:04 -0700 (PDT)
In-Reply-To: <44EF18BC.8040505@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun,

Below are the tests I performed:
Test1:
a) Power off the drive
b) echo "scsi remove-single-device h b t l" > /proc/scsi/scsi
or delete using sysfs
c) Power on the drive
d) echo "scsi add-single-device h b t l" > /proc/scsi/scsi
or scan using sysfs
The kernel error in my first email is induced in this test but not
consistently reproducible. In most of the case, no kernel error but sg
was not reattached when adding device.

Test2:
Ignore step c) in test1. Basically, try to add device while the device
is still powered off.

Hope this helps.

Thanks,
Fajun

On 8/25/06, Tejun Heo <htejun@gmail.com> wrote:
> Fajun Chen wrote:
> > Hi Tejun,
> >
> > JFYI. I found a workaround which seems to be working in 2.6.18-rc2.
> > During warm plug/unplug, if I don't delete the device through sysfs or
> > proc and just rescan the host, it recovered just fine.
>
> Hello,
>
> I'm trying to reproduce it here but haven't succeeded yet.  Can you
> describe what you did in more detail?  I'm trying various things -
> issuing delete / scan, combination of them after unplugging my drive,
> etc..., but haven't succeeded in reproducing your error condition.  It
> seems to be a sdev refcnting problem in libata but I need more clue...
>
> Thanks.
>
> --
> tejun
>
