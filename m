From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 09:48:05 -0500
Message-ID: <170fa0d21003110648y5c9738fcmeaee149ca3a831d3@mail.gmail.com>
References: <4B947393.2050002@kernel.org> <4B97C6A5.4010209@tvk.rwth-aachen.de>
	 <17BB1CC0-9B13-401D-B6AA-90365208A042@mit.edu>
	 <201003111927.24829.knikanth@suse.de>
	 <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63190 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516Ab0CKOsO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 09:48:14 -0500
In-Reply-To: <472A4C80-30CE-4875-8073-F7E61659B6F0@mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: Nikanth Karthikesan <knikanth@suse.de>, Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de

On Thu, Mar 11, 2010 at 9:28 AM, Theodore Tso <tytso@mit.edu> wrote:
>
> On Mar 11, 2010, at 8:57 AM, Nikanth Karthikesan wrote:
>>
>> I guess, what he meant was, to keep filesystem blocks aligned, even if the
>> partition is not. Say if the partition is mis-aligned by 512-bytes, let the
>> filesystem waste 4k-512bytes and keep it's blocks aligned. But it might be a
>> case of over-engineering, possibly requiring disk format change.
>
> Ah, yes, I agree with you; that's probably what he meant.
>
> Sure, that's theoretically possible, but it would mean changing every single filesystem, and it would require a file system format change --- or at least a file system format extension.
>
> It would seem to be way easier to simply fix the partitioning tools to do the right thing, though.

Yes, the current supported approach is to rely on partitions (parted,
fdisk) or LVM to account for 'alignment_offset'.

This avoids having a filesystem add its own padding (format change).
But e2fsprogs at least warns if a device, that it is to format, has an
alignment_offset != 0.

Mike
