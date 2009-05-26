From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Tue, 26 May 2009 14:23:39 +0200
Message-ID: <200905261423.40117.bzolnier@gmail.com>
References: <200905252344.11826.bzolnier@gmail.com> <20090525233643.0a47e950@lxorguk.ukuu.org.uk> <200905260106.13705.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:26522 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbZEZMTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 May 2009 08:19:11 -0400
In-Reply-To: <200905260106.13705.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 May 2009 01:06:12 Frans Pop wrote:
> On Tuesday 26 May 2009, Alan Cox wrote:
> > > It's also not obvious (at least not to a dumb user like me) that
> > > "ignore HPA limit" is equivalent to "preserving the Host Protected
> > > Area" as the commit commit says.
> >
> > It isn't - its the exact reverse.
> 
> Right.
> 
> > Ignoring the HPA limit tells the kernel to ignore the system BIOS and
> > firmware set defaults and to stomp the whole disk regardless. On a
> > modern system thats almost always a really bad idea. Unfortunately on
> > ancient boxes with disk jumpers set to lie about the disk size (32GB
> > clipping etc) its the right thing.
> >
> > Having the same parameter in both stacks seems a good idea but really
> > we need Tejun's patch exposing the values and then to propogate the hpa
> > ignore into sysfs and trigger a revalidate of the disk if you change
> > it. Libata has all the framework for that ready just needing the final
> > bits. I don't see anything problematic in old IDE also having that
> > interface.
> 
> That also sounds as if it would better protect (or at least inform) 
> existing users who have file systems on disks where the HPA is currently 
> being ignored.
> 
> Seems to me this whole issue would also be worth an LWN (BCCed) article to 
> raise awareness, explain the issue, maybe give practical info how to test 
> whether you're affected, and maybe add some advice to distributions how 
> to handle it. Seems to me like it's something that should be mentioned in 
> distribution release notes.

Ironically, some distributions were a well aware of the problem, yet they
chose to ignore it *twice* over the last few years.

First time with the introduction of the default IDE HPA behavior of always
giving the access to the full capacity of a disk and leaving decisions about
HPA preservation/removal up to the installer & user.

Second time when said distributions switched from IDE to libata (which uses
the different default behavior as it limits the capacity to non-HPA part).

Please note that no fancy sysfs support was needed to prevent the problem:
both stacks (ide & libata) support HDIO_DRIVE_TASK ioctl which can be used
to execute commands needed to retrieve/change HPA setting.

Moreover the (much needed) work from Tejun doesn't help a tiny bit in case
of people migrating their *working* setups from IDE to libata (at least
in distro upgrade case this could have been handled by distro installer but
see above) and hitting the compatibility issue mentioned in bug #13365.

Anyway I'm putting all HPA fixes on hold as I have enough (thanks for your
feedback on patches - all points are valid and I will address them if I ever
take patches out of freezer).

Thanks.
Bart
