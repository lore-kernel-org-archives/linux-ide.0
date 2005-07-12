From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Host protected area on suspend/resume
Date: Tue, 12 Jul 2005 11:23:39 -0400
Message-ID: <87f94c3705071208235342d318@mail.gmail.com>
References: <20050712113044.GA8744@srcf.ucam.org> <42D3D87F.5040901@gmail.com>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:31703 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261394AbVGLPYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Jul 2005 11:24:52 -0400
Received: by wproxy.gmail.com with SMTP id i16so1124144wra
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2005 08:24:50 -0700 (PDT)
In-Reply-To: <42D3D87F.5040901@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

On 7/12/05, Tejun Heo wrote:
> Matthew Garrett wrote:
> > On boot, Linux will attempt to disable the host protected area on a
> > disk. After a suspend/resume cycle, the BIOS may reenable it (seen on a
> > Thinkpad T40 and R40). As a result, the kernel is now unable to access
> > the HPA.
> >
> > Is there any issue with just adding a call to idedisk_check_hpa() in the
> > IDE resume code?
> 
>   This has come up several times now.  One thing I'm curious about is
> why we are disabling HPA on boot without consent from the user.  AFAIK,
> HPA is mostly used to implement hidden recovery/suspend storage areas
> and disabling automatically on boot increases the likeliness of
> destroying them.  What do we gain by disabling HPA on boot?  Are there
> some dumb machines which unnecessarily sets HPA and reduces the capacity
> of drives excessively?  Even in such cases, wouldn't it be better to do
> idedisk_check_hpa() only when kernel parameter explicitly says so?
> 
> --
> tejun

Crawling out from under my rock, I agree with Tejun.

Always enabling access to HPA seems very strange.

It also eliminates the ability to use the IDE Offset feature.  IIUC,
the offset feature is a boolean flag that, when true, basically tells
the drive that all LBA references are into the HPA area.

By using the HPA in conjunction with the Offset flag, one has the
ability to have two complete disk layouts.  Each could have its own
boot sector, partition table, and partitions.  I have never used this
feature, but I do have DOS based tools that supposidely control the
HPA config. and the state of the offset boolean.

I routinely perform "forensic image aquires".  Normally that is a
simple "dd if=/dev/hdx.....".

For me the untlimate would be to have Linux support for something like:
disable offset
dd normal sectors
enable offset
dd hpa sectors

That way I capture the areas as seperate images and if 2 boot sectors,
partition tables, partitions etc. exist I can analyse them seperately.

Conclusion, automatically overriding HPA seems to be outside of the
normal Linux way of doing things.  At a minimum, there should be a
flag to prevent it from happening.  If it is needed there are existing
userspace linux tools that can modify the HPA config.


FYI: In addition to HPA potentially reducing usable disk size, the
size can also be artificially reduced via DCO.  I am not aware of any
Linux tools for addressing/eliminating artificial DCO restrictions.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
