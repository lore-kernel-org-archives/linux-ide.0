From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 14:33:10 +0200
Message-ID: <4C6D2486.4020702@kernel.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain> <4C6AB68D.8000102@kernel.org> <20100817174257.3691ed68@lxorguk.ukuu.org.uk> <4C6AB919.7060203@kernel.org> <20100817180158.179e7780@lxorguk.ukuu.org.uk> <4C6ABFFA.2000502@kernel.org> <20100817192353.3529733c@lxorguk.ukuu.org.uk> <4C6B7B72.4090405@kernel.org> <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk> <4C6BE9C8.4030803@kernel.org> <20100818161521.430ba361@lxorguk.ukuu.org.uk> <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com> <4C6D13E2.1010703@kernel.org> <1282217732.1236.19.camel@yio.site> <4C6D189A.2080706@kernel.org> <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54215 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab0HSMhW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2010 08:37:22 -0400
In-Reply-To: <AANLkTi=oTW6Qko_ZpUL-S3e_mMqKYXSyEkxUXjhsps_u@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

On 08/19/2010 02:24 PM, Kay Sievers wrote:
> The compiled-in drivers have matched and bound and blocked-out any
> other driver of the device long before udev is even started load the
> other drivers. The matching compiled-in drivers will always win over
> the modules, regardless of their priority.
> 
> Is that what you mean? :)

It's still a bit fuzzy to me.  So, the exact scenario I'm thinking
about is something like the following.

1. System discovers an unsupported IDE class controller.

2. udev kicks in and loads pata_acpi for it which can serve as a
   fallback driver for all IDE class controllers.

3. System discovers a controller which is supported by ata_piix.
   ata_piix is the correct driver for it w/ higher priority than
   pata_acpi.

I'm curious about the followings,

a. udev invokes modprobe on device added events, no?  Does it matter
   whether there's a matching driver in the kernel (built-in or an
   already loaded module) to udev behavior?  You seem to be implying
   that if there's a matching driver, udev wouldn't invoke modprobe at
   all.

b. modprobe, when invoked, will load all the matching drivers in link
   order.  If udev invokes modprobe regardless of existing drivers, is
   there a mechanism to hold off device - driver matching before
   modprobe is finished?  Probably not, right?

The whole priority thing seems kind of broken.  It's good enough for
simple cases but just breaks down as soon as things get closer to
corner cases.  Maybe it's best to leave it alone as mostly working
workaround for simple problems.  :-(

Thanks.

-- 
tejun
