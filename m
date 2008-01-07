From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/7] sg_ring: a ring of scatterlist arrays
Date: Mon, 07 Jan 2008 14:01:40 +0900
Message-ID: <4781B234.7070805@gmail.com>
References: <200712191731.26512.rusty@rustcorp.com.au> <1199547072.3399.15.camel@localhost.localdomain> <200801071538.58875.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <200801071538.58875.rusty@rustcorp.com.au>
Sender: linux-scsi-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

Rusty Russell wrote:
>> The other thing I note is that the problem you're claiming to solve with
>> sg_ring (the ability to add extra scatterlists to the front or the back
>> of an existing one) is already solved with sg_chain, so the only real
>> advantage of sg_ring was that it contains explicit counts, which
>> sg_table (in -mm) also introduces.
> 
> I just converted virtio using latest Linus for fair comparison, and it's still 
> pretty ugly.  sg_ring needs more work to de-scsi it.  sg_table is almost 
> sg_ring except it retains all the chaining warts.

I agree it's ugly.

> But we hit the same problems:
> 
> 1) sg_chain loses information.  The clever chain packaging makes reading easy, 
> but manipulation is severely limited.  You can append to your own chains by 
> padding, but not someone elses.  This works for SCSI, but what about the rest 
> of us?  And don't even think of joining mapped chains: it will almost work.

You can append by allocating one more element on the chain to be
appended and moving the last element of the first chain to it while
using the last element for chaining.  Join can be done by similar
technique using three element extra chain in the middle.  But, yeah,
it's ugly as hell.

-- 
tejun
