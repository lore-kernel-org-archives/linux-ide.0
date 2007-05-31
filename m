From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: Compact Flash performance...
Date: Thu, 31 May 2007 10:22:09 +0100
Message-ID: <6278d2220705310222rde9ad28ndfd8feced84a3c6f@mail.gmail.com>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>
	 <465E3FF0.9010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:21957 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbXEaJWL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 May 2007 05:22:11 -0400
Received: by wr-out-0506.google.com with SMTP id 76so96295wra
        for <linux-ide@vger.kernel.org>; Thu, 31 May 2007 02:22:10 -0700 (PDT)
In-Reply-To: <465E3FF0.9010709@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Hi Mark,

Thanks for the reply; here is the raw identification data:

# hdparm --Istdout /dev/sdb

/dev/sdb:
045a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 5644 5334 3142
5434 4456 3038 474a 0003 3bf5 0034 5634
344f 4139 3641 4844 5437 3232 3532 3544
4c41 3338 3020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0110 ffff 0fff 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 001f 0306 0000 005e 0040
00fc 001a 346b 7fe9 4773 3469 3e01 4763
407f 0038 0000 00fe fffe 0000 80fe 0008
00ca 00f9 2710 0000 5970 1d1c 0000 0000
00ca 0000 0000 5a87 5000 cca2 0bd9 ea2d
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0009 000b 0000 0000 3982 0db1 fe20 0001
4000 0004 0000 0000 0000 1df7 28db 131a
0300 0280 3f7f 00c0 0040 2b00 8000 0000
344f 4339 0000 4004 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 7da5

Daniel

On 31/05/07, Mark Lord <lkml@rtr.ca> wrote:
> Daniel J Blueman wrote:
> > I have a SanDisk Extreme IV 4GB CF card, capable of 40MB/s read, but
> > am seeing 30MB/s read [1], connected directly to the IDE bus on my
> > ICH8 controller.
> >
> > How can I find out if this would be a timing or configuration issue?
> > On 2.6.20.5 [2], the 120nS timing looks to be right [3], but perhaps
> > no multi-word transfer is hurting here...alas, it can't be enabled
> > with the libata subsystem and 'hdparm -m', so what else?
>
> Please post the output from "hdparm --Istdout /dev/sdb" for this card.
>
> Thanks
-- 
Daniel J Blueman
