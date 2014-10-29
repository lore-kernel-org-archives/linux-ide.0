From: Jens Axboe <axboe@fb.com>
Subject: Re: [RFC PATCH 0/5] Enable use of Solid State Hybrid Drives
Date: Wed, 29 Oct 2014 15:10:51 -0600
Message-ID: <545157DB.70304@fb.com>
References: <20141029180454.4879.75088.stgit@stg-AndroidDev-VirtualBox> <20141029201417.GK16186@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141029201417.GK16186@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, "Jason B. Akers" <jason.b.akers@intel.com>
Cc: linux-ide@vger.kernel.org, dan.j.williams@intel.com, kapil.karkra@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 10/29/2014 02:14 PM, Dave Chinner wrote:
> On Wed, Oct 29, 2014 at 11:23:38AM -0700, Jason B. Akers wrote:
>> The following series enables the use of Solid State hybrid drives
>> ATA standard 3.2 defines the hybrid information feature, which provides a means for the host driver to provide hints to the SSHDs to guide what to place on the SSD/NAND portion and what to place on the magnetic media.
>>
>> This implementation allows user space applications to provide the cache hints to the kernel using the existing ionice syscall. 
>>
>> An application can pass a priority number coding up bits 11, 12, and 15 of the ionice command to form a 3 bit field that encodes the following priorities:
>> 	OPRIO_ADV_NONE,
>> 	IOPRIO_ADV_EVICT, /* actively discard cached data */
>> 	IOPRIO_ADV_DONTNEED, /* caching this data has little value */
>> 	IOPRIO_ADV_NORMAL, /* best-effort cache priority (default) */
>> 	IOPRIO_ADV_RESERVED1, /* reserved for future use */
>> 	IOPRIO_ADV_RESERVED2,
>> 	IOPRIO_ADV_RESERVED3,
>> 	IOPRIO_ADV_WILLNEED, /* high temporal locality */
>>
>> For example the following commands from the user space will make dd IOs to be generated with a hint of IOPRIO_ADV_DONTNEED assuming the SSHD is /dev/sdc.
>>
>> ionice -c2 -n4096 dd if=/dev/zero of=/dev/sdc bs=1M count=1024
>> ionice -c2 -n4096 dd if=/dev/sdc of=/dev/null bs=1M count=1024
> 
> This looks to be the wrong way to implement per-IO priority
> information.
> 
> How does a filesystem make use of this to make sure it's
> metadata ends up with IOPRIO_ADV_WILLNEED to store frequently
> accessed metadata in flash. Conversely, journal writes need to
> be issued with IOPRIO_ADV_DONTNEED so they don't unneceessarily
> consume flash space as they are never-read IOs...

Not disagreeing that loading more into the io priority fields is a
bit... icky. I see why it's done, though, it requires the least amount
of plumbing.

As for the fs accessing this, the io nice fields are readily exposed
through the ->bi_rw setting. So while the above example uses ionice to
set a task io priority (that a bio will then inherit), nothing prevents
you from passing it in directly from the kernel.

-- 
Jens Axboe
