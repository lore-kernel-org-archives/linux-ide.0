From: Craig Block <chblock3@yahoo.com>
Subject: Re: 40-wire/80-wire detection
Date: Sat, 14 Jul 2007 01:37:41 -0700 (PDT)
Message-ID: <305029.41682.qm@web58107.mail.re3.yahoo.com>
References: <200707132339.42299.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web58107.mail.re3.yahoo.com ([68.142.236.130]:31989 "HELO
	web58107.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751928AbXGNIhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 04:37:42 -0400
In-Reply-To: <200707132339.42299.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stephen.Clark@seclark.us, Jeff Garzik <jeff@garzik.org>, Matt Sealey <matt@genesi-usa.com>, linux-ide@vger.kernel.org


--- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> 
> Please send the output of hdparm --Istdout for this drive.
> 
> "idex=ata66" or CONFIG_IDEDMA_IVB=y should also help but we really would
> like to detect and workaround such issues automatically, without the need
> for user headaches. ;)
> 
> Thanks,
> Bart
> 
Here ya go, hope that helps :)

/dev/hda:
045a 2959 0000 000f 7e00 5332 003f 0000
0000 5154 3837 3130 3038 3434 3731 3535
2020 2020 2020 2020 0003 0344 0004 4130
332e 3039 3030 5155 414e 5455 4d20 4649
5245 4241 4c4c 6c63 7431 3020 3035 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0f00 4000 0200 0200 0007 2959 000f
003f a189 0098 0100 a189 0098 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
001e 0011 346b 4001 4000 3469 0001 4000
101f 0003 0000 0000 fffe 2040 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
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
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000



       
____________________________________________________________________________________
Sick sense of humor? Visit Yahoo! TV's 
Comedy with an Edge to see what's on, when. 
http://tv.yahoo.com/collections/222
