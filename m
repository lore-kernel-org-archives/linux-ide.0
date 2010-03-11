From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ATA 4 KiB sector issues.
Date: Thu, 11 Mar 2010 08:33:35 -0800
Message-ID: <4B991B5F.6050302@zytor.com>
References: <4B947393.2050002@kernel.org> <4B97C6A5.4010209@tvk.rwth-aachen.de> <17BB1CC0-9B13-401D-B6AA-90365208A042@mit.edu> <201003111927.24829.knikanth@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201003111927.24829.knikanth@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: Theodore Tso <tytso@mit.edu>, Damian Lukowski <damian@tvk.rwth-aachen.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Matthew Wilcox <matthew@wil.cx>, "Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Daniel Taylor <Daniel.Taylor@wdc.com>, Mark Lord <kernel@teksavvy.com>, hirofumi@mail.parknet.co.jp, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, irtiger@gmail.com, aschnell@suse.de, jdelvare@suse.de
List-Id: linux-ide@vger.kernel.org

On 03/11/2010 05:57 AM, Nikanth Karthikesan wrote:
>
> I guess, what he meant was, to keep filesystem blocks aligned, even if the
> partition is not. Say if the partition is mis-aligned by 512-bytes, let the
> filesystem waste 4k-512bytes and keep it's blocks aligned. But it might be a
> case of over-engineering, possibly requiring disk format change.
>

That's basically what you end up having to do for FAT filesystems to be 
aligned.

	-hpa
