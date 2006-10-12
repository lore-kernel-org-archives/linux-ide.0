From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: How to test SATA NCQ feature
Date: Thu, 12 Oct 2006 17:55:59 -0600
Message-ID: <8202f4270610121655x1f88c363j34b20928d34af86f@mail.gmail.com>
References: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
	 <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:20191 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751343AbWJLX4J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 19:56:09 -0400
Received: by py-out-1112.google.com with SMTP id n25so820037pyg
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 16:55:59 -0700 (PDT)
In-Reply-To: <311601c90610121012j165ecbgf1944da30bced51d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hi Eric,

Thanks for your detailed explanation.

In terms of ops/sec, I currently implemented it as the amout of data
transferred per seconds.  Please let me know if I need to implement it
differently.

I also have a question about NCQ error handling. Among all the
outstanding commands, if one command fails,  what will happen to the
rest of the commands? I understand that all the commands in the device
will be aborted by LOG PAGE 10h command, but how about the commands
enqueued but haven't been sent to the device?  In my particular
application, one thread is blocked for every outstanding command. So
depending on how libata handles outstanding commands,  it will have
significant implication to my user space application.

Thanks,
Fajun

On 10/12/06, Eric D. Mudama <edmudama@gmail.com> wrote:
> For small random reads across the full stroke of the disk, you should
> see 50-80% improvement in performance, regardless of the state of read
> cache, at a depth of 32.
>
> For small random writes across the full stroke, performance should be
> unchanged if write cache is enabled in the drive.  If write cache is
> disabled, you should see the same 50-80% performance improvement as
> for random reads.
>
> For sequential operations NCQ won't make much of a difference, and as
> the command block size increases, the performance delta will shrink
> between queued and non-queued.  The exact asymptote is a function of
> many manufacturer and model-specific details.
>
> Remember that these are all ops/sec measurements.  Command latency is
> a different kettle of fish.
>
> --eric
>
>
> On 10/12/06, Fajun Chen <fajunchen@gmail.com> wrote:
> > Hi Folks,
> >
> > I'm writing a program to test SATA Sil3124 NCQ feature.  I assume NCQ
> > is supported by libata by default, correct?  Multi threading approach
> > is used to send AT commands to device asynchronously.  I can verify
> > that data are sent to the device and read back correctly, but I don't
> > know how to verify if NCQ works.  Do I expect to see consistent
> > performance gain in random read/write in NCQ mode?
> >
> > Thanks,
> > Fajun
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
