From: Mark Lord <mlord@pobox.com>
Subject: Re: hdparm-8.2 now available
Date: Wed, 20 Feb 2008 10:44:19 -0500
Message-ID: <47BC4AD3.6020802@pobox.com>
References: <47BA21F0.90405@pobox.com>
 <87f94c370802200732g594a4f01jeba7d05579625ee2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-fallback-fastnet.pobox.com ([209.2.32.35]:59054 "EHLO
	a-fallback-fastnet.pobox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933006AbYBTQRF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 11:17:05 -0500
In-Reply-To: <87f94c370802200732g594a4f01jeba7d05579625ee2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, ballen@gravity.phys.uwm.edu, Ric Wheeler <ric@emc.com>

Greg Freemyer wrote:
> Mark,
> 
> What kernel level is needed to support the new -N arg?
..

I believe it should work with 2.4.0 or newer.
But some kernels have a buggy implementation of it.
 
> Tried it on a Suse 2.6.22 kernel (possibly not patched with all the
> current security updates).
> 
> Failed with:
> 
> The Running Kernel Lack CONFIG_IDE_TASK_IOCTL Support.
..

That failure indicates that your drive is not using libata drivers.
USB/SD drives/drivers do not support this flag at all,
but drives using the ancient IDE drivers should work.

For drives using the ancient IDE drivers, you will need
to use a kernel configured with the CONFIG_IDE_TASK_IOCTL flag.
If you see the message above, then that means your kernel
was probably built without that configuration option selected.

Look in /proc/config.gz and see if the option shows up there,
or in "cat /boot/config-`uname -r`".  If you don't see it
in there, then the kernel would have to get rebuilt with
that config option to enable the feature.

Or just switch to the modern libata drivers for IDE/SATA drives.

Note also that hdparm has now been updated to version 8.4,
with some unrelated bug fixes.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
