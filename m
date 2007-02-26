From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Mon, 26 Feb 2007 09:18:16 +0100
Message-ID: <8d158e1f0702260018y53f8dc18veacadbfdead22ce9@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <200702241911.21030.bzolnier@gmail.com>
	 <8d158e1f0702250546lddf9748r3c210504f3e94304@mail.gmail.com>
	 <200702251822.47387.bzolnier@gmail.com>
	 <8d158e1f0702251302yc22ef88pca50e171a4d89fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:57194 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbXBZIST (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 03:18:19 -0500
Received: by an-out-0708.google.com with SMTP id b33so740652ana
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 00:18:17 -0800 (PST)
In-Reply-To: <8d158e1f0702251302yc22ef88pca50e171a4d89fb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On 2/25/07, Patrick Ale <patrick.ale@gmail.com> wrote:
> On 2/25/07, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

Dobri dan (I think, I am learning croatian and got told by a friend
this is the polish way of saying it).

Anyway,

I guess it will take a bit before I can do this test for you,
regarding the loading pata_pdc207x and all.

md3 : active raid1 sdc1[2] sdb1[0]
      117218176 blocks [2/1] [U_]
      [======>..............]  recovery = 31.8% (37313792/117218176)
finish=2503.2min speed=531K/sec


A while a go I had a southbridge that wasnt too happy about the fact
that the fan wasnt running for some weeks allready, I guess I am
feeling the pain for it now. Lot's of "Port is slow, please be
patient" warnings.

Good thing is: the disk stays in UDMA100 now, instead of dropping to
PIO mode 1. As soon as i can replace the disk, I will do the tests for
you.

So as the dmesg says: be patient :P


Thanks again for all your help,

Patrick
