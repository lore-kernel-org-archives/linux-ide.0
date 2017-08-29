From: Tejun Heo <tj@kernel.org>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Tue, 29 Aug 2017 08:30:37 -0700
Message-ID: <20170829153037.GN491396@devbig577.frc2.facebook.com>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
 <20170828212225.GB491396@devbig577.frc2.facebook.com>
 <20170829124206.GA26738@lst.de>
 <a5caf398-3ae3-4585-23d2-b2afbbc28d7d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a5caf398-3ae3-4585-23d2-b2afbbc28d7d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 29, 2017 at 09:08:05AM -0600, David Ahern wrote:
> On 8/29/17 6:42 AM, Christoph Hellwig wrote:
> > ---
> > From e661047ec3a25587648b07c02a687a7dac778f3b Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Tue, 29 Aug 2017 14:35:50 +0200
> > Subject: libata: check for trusted computing in IDENTIFY DEVICE data
> > 
> > ATA-8 and later mirrors the TRUSTED COMPUTING SUPPORTED bit in word 48 of
> > the IDENTIFY DEVICE data.  Check this before issuing a READ LOG PAGE
> > command to avoid issues with buggy devices.  The only downside is that
> > we can't support Security Send / Receive for a device with an older
> > revision due to the conflicting use of this field in earlier
> > specifications.

Christoph, I'm gonna revert the horkage patch and apply this one.  If
you can think of a better way to do this, please let me know.

Thanks.

-- 
tejun
