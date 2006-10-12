From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: How to test SATA NCQ feature
Date: Thu, 12 Oct 2006 11:12:38 -0600
Message-ID: <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com>
References: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:61328 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750931AbWJLRMk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 13:12:40 -0400
Received: by nf-out-0910.google.com with SMTP id x30so626607nfb
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 10:12:39 -0700 (PDT)
In-Reply-To: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

For small random reads across the full stroke of the disk, you should
see 50-80% improvement in performance, regardless of the state of read
cache, at a depth of 32.

For small random writes across the full stroke, performance should be
unchanged if write cache is enabled in the drive.  If write cache is
disabled, you should see the same 50-80% performance improvement as
for random reads.

For sequential operations NCQ won't make much of a difference, and as
the command block size increases, the performance delta will shrink
between queued and non-queued.  The exact asymptote is a function of
many manufacturer and model-specific details.

Remember that these are all ops/sec measurements.  Command latency is
a different kettle of fish.

--eric


On 10/12/06, Fajun Chen <fajunchen@gmail.com> wrote:
> Hi Folks,
>
> I'm writing a program to test SATA Sil3124 NCQ feature.  I assume NCQ
> is supported by libata by default, correct?  Multi threading approach
> is used to send AT commands to device asynchronously.  I can verify
> that data are sent to the device and read back correctly, but I don't
> know how to verify if NCQ works.  Do I expect to see consistent
> performance gain in random read/write in NCQ mode?
>
> Thanks,
> Fajun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
