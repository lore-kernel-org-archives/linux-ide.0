From: Vinayak Kale <vinayak.kale@seagate.com>
Subject: Re: [PATCH] libata: add support for NCQ commands for SG interface
Date: Sat, 24 Oct 2015 01:38:47 +0530
Message-ID: <CAAtun4incLV=jMbVnkdtbSxXW-7XFYnWb=6PxLnJvwHi5HSLsQ@mail.gmail.com>
References: <1445082519-8160-1-git-send-email-vinayak.kale@seagate.com>
	<CACLWs=VWXTd6ZcDQCGXHkngf72RpiqDVkZKXrWJC7Rmx_giWsA@mail.gmail.com>
	<20151022085717.GB24379@mtj.duckdns.org>
	<CAAtun4jvUaVsGSofq5n-sJzmSf4qBsPvQ7WU6dOik4JYSMnZNw@mail.gmail.com>
	<20151023053945.GA24618@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151023053945.GA24618@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Vinayak Kale <vinayak.kale@gmail.com>, Sumit Gupta <sumit.g.gupta@seagate.com>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Fri, Oct 23, 2015 at 11:09 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Fri, Oct 23, 2015 at 10:01:35AM +0530, Vinayak Kale wrote:
>> > It looks like it'd work given that it's forcing qc->tag into
>> > tf->nsect.  What's the use case tho?
>>
>> We need to issue NCQ commands with priority bit from user space application.
>>
>> BTW, Sergei Shtylyov raised concern regarding usefulness of adding
>> ATA_TFLAG_LBA to tf->flags. Can you please comment on that as well?
>> Accordingly I will either keep it or discard it in V2. Thanks.
>
> I like the change but can you please put that in a separate patch?

Ok. I'll put this in a separate patch.

> Also, can you please verify that this works fine with multiple regular
> NCQ commands in flight?

I verified that multiple FPDMA Read/Write commands issued
simultaneously by different processes, work fine.
I hooked up our application's queued Read/Write APIs to fio, ran fio
for 'random rw' over multiple processes. It worked fine.

>
> Thanks.
>
> --
> tejun
