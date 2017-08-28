From: Tejun Heo <tj@kernel.org>
Subject: Re: boot failure with 4.13.0-rc6 due to ATA errors
Date: Mon, 28 Aug 2017 14:22:25 -0700
Message-ID: <20170828212225.GB491396@devbig577.frc2.facebook.com>
References: <3117ae58-d432-101e-3f0b-68d72fdee28b@gmail.com>
 <20170828195916.GA491396@devbig577.frc2.facebook.com>
 <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37033f6d-2ad0-7817-10b5-cbd7ff565624@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Ahern <dsahern@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: linux-ide@vger.kernel.org

Hello,

On Mon, Aug 28, 2017 at 02:26:52PM -0600, David Ahern wrote:
> On 8/28/17 1:59 PM, Tejun Heo wrote:
> > Can you please verify whether 818831c8b22f ("libata: implement
> > SECURITY PROTOCOL IN/OUT") is the culprit?  ie. try to boot the commit
> > to verify that the problem is there, and try the one prior?
> 
> That commit is the problem. a0fd2454a36ffab2ce39b3a91c1385a5f98e63f0
> works fine.

Christoph, is there anything we can do to further gate issuing of the
offending command?  Otherwise, we might have to go for whitelist
instead.

Thanks.

-- 
tejun
