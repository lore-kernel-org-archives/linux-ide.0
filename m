From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET] block/SCSI: implement in-kernel disk event handling,
  take#2
Date: Thu, 16 Dec 2010 17:36:31 +0100
Message-ID: <4D0A400F.5090608@kernel.dk>
References: <1291838262-21274-1-git-send-email-tj@kernel.org> <4D0A3EE1.4050404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <4D0A3EE1.4050404@kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, kay.sievers@vrfy.org, jack@suse.cz, James.Bottomley@HansenPartnership.com
List-Id: linux-ide@vger.kernel.org

On 2010-12-16 17:31, Tejun Heo wrote:
> On 12/08/2010 08:57 PM, Tejun Heo wrote:
>> This is the second take of in-kernel-disk-event patchset which
>> implements in-kernel disk event handling framework and adds support
>> for it to sr and sd.  This is largely to move media presence polling
>> into kernel as userspace implementation turned out to be quite
>> problematic over the years.
> 
> Kay, Jens, James, how does this look to you guys?

I like the concept, this is probably what we should have done all along.
The user space method has been tried and failed. So I was mostly laying
it low waiting for feedback before integrating this.

Kay?

-- 
Jens Axboe

