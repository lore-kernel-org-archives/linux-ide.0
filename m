From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: SATA RAID5 speed drop of 100 MB/s
Date: Sat, 23 Jun 2007 19:30:57 +0200
Message-ID: <200706231930.57688.bzolnier@gmail.com>
References: <20070620224847.GA5488@alinoe.com> <467CC5C5.6040201@garzik.org> <20070623125316.GB26672@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbXFWRwf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019617ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:34 -0700 (PDT)
In-Reply-To: <20070623125316.GB26672@alinoe.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlo Wood <carlo@alinoe.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Manoj Kasichainula <manoj@io.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>


Hi,

On Saturday 23 June 2007, Carlo Wood wrote:

> PS I'd like to do extensive testing with Bonnie++ to tune everything
> there is to tune. But bonnie likes to write/read files TWICE the amount
> of RAM I have. It therefore takes a LOT of time to run one test. Do you
> happen to know how I can limit the amount of RAM that the linux kernel
> sees to, say 500 MB? That should be enough to run in Single User mode
> but allow me to run the tests MUCH faster. (I have dual channel, four
> DIMM's of 1 GB each -- 2 GB per Core 2 die. Hopefully the fact that
> I have dual channel isn't going to be a problem when limiting the ram
> that the kernel sees.)

"mem=" kernel parameter limits amount of memory seen by kernel
(more info in Documentation/kernel-parameters.txt)

You can also limit amount of RAM detected by bonnie++ by using -r parameter
but please remember that this will make bonnie++ benchmark combined kernel
I/O buffering + filesystem + hard disk performance instead of just filesystem
+ hard disk performance (as it can happen that some / all data won't ever
hit the disk).

Bart
