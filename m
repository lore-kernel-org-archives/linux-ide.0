From: Alex Buell <alex.buell@munted.org.uk>
Subject: Re: support for drives larger than 2TiB
Date: Sat, 24 Jul 2010 13:36:06 +0100
Message-ID: <1279974966.11927.26.camel@lithium.local.net>
References: <4C4AB952.9030705@kernel.org>
Reply-To: alex.buell@munted.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C4AB952.9030705@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, ben.collins@ubuntu.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, hmh@debian.org
List-Id: linux-ide@vger.kernel.org

On Sat, 2010-07-24 at 11:58 +0200, Tejun Heo wrote:
> The only problem is that everything which is necessary for booting
> needs to be located below 2TiB limit.  Please note that this is much
> stricter restriction than the 128GiB limit we had due to LBA28.  That
> limit was caused by BIOSes using LBA28 and vendors could and did
> update and be done with it in many cases.  However, 2TiB limit is
> inherent in the BIOS programming interface and currently the only way
> to overcome it is using a completely different BIOS interface (EFI,
> that is).  Vendors are not likely to introduce EFI for already
> released products although they're much more likely to release updates
> so that BIOSes can access upto 2TiB if they don't work already.  We'll
> be stuck with 2TiB limit on much more configurations for longer period
> of time. 

The only thing that would please me no end with newer replacements for
BIOS is the ability to have 4k boot sectors. Imagine what we can do with
4k what we can't do with 512 bytes. 
-- 
http://www.munted.org.uk

One very high maintenance cat living here.
