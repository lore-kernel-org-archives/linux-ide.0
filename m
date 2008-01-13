From: Marc Howard Zuckman <marc@fallon.classyad.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12
 and gentoo-sources 2.6.23-r3
Date: Sun, 13 Jan 2008 00:39:03 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801130031370.6579@classyad.com>
References: <200801051734.18088.marc@fallon.classyad.com>
 <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
 <200801121542.34435.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c-71-205-247-245.hsd1.mi.comcast.net ([71.205.247.245]:60286
	"EHLO fallon.classyad.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYAMFh7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 00:37:59 -0500
In-Reply-To: <200801121542.34435.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sat, 12 Jan 2008, Bartlomiej Zolnierkiewicz wrote:

>
> In "smart mode" controller takes care of mode programming.
>
>> Cc'ing Alan and Bartlomiej.  Guys, is this the smart mode problem?  Do
>> ide and libata have this fixed in 2.6.24-rc?
>
> [ added Alan and myself ;) to cc: ]
>
> Marc, please also send output of 'hdparm --Istdout /dev/hde' command.
>
This is the output from hdparm with my non-working vanilla 2.6.23.12.


/dev/hde:
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 2008 1301 0501 ****4721**** 0101 0005
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 496e 7465 6772 6174 6564
2054 6563 686e 6f6c 6f67 7920 4578 7072
6573 7320 496e 6320 2020 2020 2020 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 ffff 0fff 0000 0007
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003f 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 9eae 12a1 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0001 0003 3133 2121 9111 0091 3266
0021 0021 0001 0505 0005 0500 0000 0005
0005 0005 0040 0000 0000 0000 0000 0000
0000 0000 0001 0000 0000 0000 0000 0000
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
0000 0000 0000 0000 0000 0000 0000 0000


The output from this command with the it821x supported raid array in my 2.6.20 kernel version is identical EXCEPT for the hex codes delimited by the *****.
With 2.6.20, those hex codes are 0925.

Marc H. Zuckman
