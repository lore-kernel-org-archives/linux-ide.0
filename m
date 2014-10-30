From: Jens Axboe <axboe@fb.com>
Subject: Re: [RFC PATCH 0/5] Enable use of Solid State Hybrid Drives
Date: Thu, 30 Oct 2014 08:15:16 -0600
Message-ID: <545247F4.9010000@fb.com>
References: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox> <20141029201417.GK16186@dastard> <545157DB.70304@fb.com> <20141029220905.GL16186@dastard> <CAPcyv4iiqfeWQyZpzYwASFV+7Ztjcjrp0DEq3ThOmdwgWGGJUw@mail.gmail.com> <20141030072111.GJ13323@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141030072111.GJ13323@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Dan Williams <dan.j.williams@intel.com>
Cc: "Jason B. Akers" <jason.b.akers@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Karkra, Kapil" <kapil.karkra@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 2014-10-30 01:21, Dave Chinner wrote:
> On Wed, Oct 29, 2014 at 03:24:11PM -0700, Dan Williams wrote:
>> On Wed, Oct 29, 2014 at 3:09 PM, Dave Chinner <david@fromorbit.com> wrote:
>>> On Wed, Oct 29, 2014 at 03:10:51PM -0600, Jens Axboe wrote:
>>>> As for the fs accessing this, the io nice fields are readily exposed
>>>> through the ->bi_rw setting. So while the above example uses ionice to
>>>> set a task io priority (that a bio will then inherit), nothing prevents
>>>> you from passing it in directly from the kernel.
>>>
>>> Right, but now the filesystem needs to provide that on a per-inode
>>> basis, not from the task structure as the task that is submitting
>>> the bio is not necesarily the task doing the read/write syscall.
>>>
>>> e.g. the write case above doesn't actually inherit the task priority
>>> at the bio level at all because the IO is being dispatched by a
>>> background flusher thread, not the ioniced task calling write(2).
>>
>> When the ioniced task calling write(2) inserts the page into the page
>> cache then the current priority is recorded in the struct page.  The
>
> It does? Can you point me to where the page cache code does this,
> because I've clearly missed something important go by in the past
> few months...

I was puzzled too, but then I realized that Dan is referring to patch 
4/5 in the series...


-- 
Jens Axboe
