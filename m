From: Jens Axboe <axboe@fb.com>
Subject: Re: [RFC PATCH 0/5] Enable use of Solid State Hybrid Drives
Date: Thu, 30 Oct 2014 08:17:56 -0600
Message-ID: <54524894.8040604@fb.com>
References: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox>	<yq1k33il3b3.fsf@sermon.lab.mkp.net>	<5451A3F5.9020903@fb.com>	<yq1bnoukzhe.fsf@sermon.lab.mkp.net> <CAPcyv4ggAXzWows0PayvspOX4aP9G0PmLDes+0Q+m6VXQcF9Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4ggAXzWows0PayvspOX4aP9G0PmLDes+0Q+m6VXQcF9Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "Jason B. Akers" <jason.b.akers@intel.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, "Karkra, Kapil" <kapil.karkra@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On 2014-10-29 22:19, Dan Williams wrote:
> I understand the desire to have per-io / per-inode xadvise()-style
> hints, but I don't see why not also include a per-pid capability?
>
> Per-pid was not "icky" for flashcache [1].  It let's you flag
> processes that should not pollute the cache, as well "cache warming"
> processes pre-loading sub-ranges of files that is awkward to do with a
> per-inode hint.  Per-pid also allows hinting on behalf of other
> otherwise cache-unaware processes.

per-pid is imho fine as well, as long as it's not the primary interface. 
I quite like how the io priority works in this regard. If the task has a 
priority set, we use that. If you pass in something else, that overrides 
the task set one.

per-pid allows you to modify how we treat applications without modifying 
the application itself. This is handy for eg streamed backup and 
similar, which is most likely why flashcache has it.

-- 
Jens Axboe
