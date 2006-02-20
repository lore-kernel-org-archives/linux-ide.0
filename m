From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: `Max Request Size' -- A Query
Date: Mon, 20 Feb 2006 15:01:51 +0100
Message-ID: <58cb370e0602200601w3b53a468h49e158af78d6913f@mail.gmail.com>
References: <6dd519ae0602200509s45b8fc0awe4fce40c973ddaa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.205]:21195 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030232AbWBTOBw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Feb 2006 09:01:52 -0500
Received: by nproxy.gmail.com with SMTP id c29so633826nfb
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 06:01:51 -0800 (PST)
In-Reply-To: <6dd519ae0602200509s45b8fc0awe4fce40c973ddaa5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Marete <bgmarete@gmail.com>
Cc: linux-ide@vger.kernel.org

http://thread.gmane.org/gmane.linux.ide/7365

Which reminds me that reporting needs fixing for 2.6.16-final. :)

On 2/20/06, Brian Marete <bgmarete@gmail.com> wrote:
> Hello all,
>
> This is more of a query than a bug report. After upgrading my kernel from
> 2.6.15.1 to 2.6.16-rc4, I noticed, by having a look at dmesg(1), that the
> `max request size' for my hard disk had changed from 1024KiB to 512KiB, as
> evidenced by the following short diff.
>
> --------------------------------------------------------
>  Probing IDE interface ide1...
>  hdc: LITE-ON CD-RW SOHR-5238S, ATAPI CD/DVD-ROM drive
>  ide1 at 0x170-0x177,0x376 on irq 15
> -hda: max request size: 1024KiB
> +hda: max request size: 512KiB
>  hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(133)
>  hda: cache flushes supported
>   hda: hda1 hda2 hda3 hda4
> --------------------------------------------------------
>
> My question is whether I should worry at all about this. Should I expect a
> performance drop? In short, is it a good thing, a bad thing or entirely
> indifferent for my purposes as a user?
>
> Perhaps I should add that I have `CONFIG_BLK_DEV_VIA82CXXX' compiled into the
> kernel.
>
> Thanks,
