From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil Mod15Write quirk workaround patch for vanilla kernel
 avaialble.
Date: Mon, 04 Apr 2005 16:57:25 +0900
Message-ID: <4250F365.9020701@gmail.com>
References: <424C10C3.9080102@gmail.com> <20050331111044.4a3672cd@homer.sarvega.com> <424C7EF0.5000206@gmail.com> <20050404071002.GI4383@blackhole.adamant.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:22887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVDDH5b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Apr 2005 03:57:31 -0400
Received: by rproxy.gmail.com with SMTP id a41so1110687rng
        for <linux-ide@vger.kernel.org>; Mon, 04 Apr 2005 00:57:31 -0700 (PDT)
In-Reply-To: <20050404071002.GI4383@blackhole.adamant.ua>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Trotsai <mage@adamant.ua>
Cc: John Lash <jkl@sarvega.com>, lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alexander Trotsai wrote:
> On Fri, Apr 01, 2005 at 07:51:28AM +0900, Tejun Heo wrote:
> TH>  Hello, John.
> TH> 
> TH> John Lash wrote:
> TH> >On Fri, 01 Apr 2005 00:01:23 +0900
> TH> >Tejun Heo <htejun@gmail.com> wrote:
> TH> >
> TH> >
> TH> >>Hello, guys.
> TH> >>
> TH> >>I  generated m16w workaround patch for 2.6.11.6 (by just removing two
> TH> >>lines :-) and set up a page regarding m15w quirk and the workaournd.
> TH> >>I'm planning on updating m15w patch against the vanilla tree until it
> TH> >>gets into the mainline so that impatient users can try out and it gets
> TH> >>more testing.
> TH> >>
> TH> >>http://home-tj.org/m15w
> TH> >>
> TH> >>Thanks.
> TH> >>
> TH> >>-- 
> TH> >>tejun
> TH> >>
> TH> >
> TH> >
> TH> >Tejun,
> TH> >
> TH> >I applied the patch to a clean 2.6.11.6 kernel and got an unresolved
> TH> >symbol error for "ATA_TFLAG_LBA". I tried changing that to 
> TH> >"ATA_TFLAG_LBA48" and
> TH> >it compiles and runs.
> TH> >
> TH> >So far, no problems. Thanks a lot for the patch.
> TH> 
> TH>  I'm sorry.  I uploaded the original patch against libata-dev-2.6 tree. 
> TH>  The two BUG_ON() lines should just be removed.  I've uploaded fixed 
> TH> patch.  Thanks for pointing out.
> 
> Thanks
> Seems to be worked (I'm install with ide-ata-2.6 patch)
> But with heavy read load write performance is very very bad
> (near 50-100 KBps)
> But I think that is not problem of Silicon card (I have also
> to SATA hard drives on Intel onboard SATA controller with
> same performance troubles)

  It has been quite a while since I looked at the elevator code but, 
IIRC, anticipatory elevator (rightfully) favors read requests over 
writes and doesn't care much about fairness between processes (IOW, 
request streams).  It depends on your workload but try using cfq.  For 
many puposes including common desktop usage, I find cfq to be better suited.

  Thanks.

-- 
tejun

