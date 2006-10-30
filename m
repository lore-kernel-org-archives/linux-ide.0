From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under kernel 2.6.18
Date: Mon, 30 Oct 2006 20:53:06 -0000
Message-ID: <op.th85mswaxci36i@akima>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com> <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima> <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com> <op.thtxiw0axci36i@akima> <453C2748.9030008@gmail.com> <1161598438.19388.7.camel@localhost.localdomain> <op.thvmp9mrxci36i@akima> <1161612595.19388.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:38007 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422646AbWJ3UxJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 15:53:09 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1257704ugm
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2006 12:53:07 -0800 (PST)
In-Reply-To: <1161612595.19388.33.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, 23 Oct 2006 15:09:55 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote:

> Ar Llu, 2006-10-23 am 14:35 +0100, ysgrifennodd Jonathan Bell:
>> BIOS for the A7N8X is the latest 1008 version which overcomes a boot
>> limitation - the board would not boot with more than 1 SATA controller
>> installed.
>>
>> This RAID corruption bug was supposedly fixed in 1005.
>
> But this is a BIOS so was it unfixed again in 1006 ?
>
> Also for that matter, does anyone in Nvidia know and want to explain
> what was wrong in those BIOSes and what we can do in Linux to
> handle/correct the situation ?
>


OK.... the problem has "fixed itself".

In contacting Asus technical support the nice guy at the other end told me
to increase the latency timer of the cards. In order to test the mainboard
I put it back in instead of the temporary NF7-M. Suspiciously the tests
that failed before are now flawless and the only thing different was 2 PCI
cards were not installed, the tv tuner card and a wireless lan card.
Installing these to try to exactly duplicate the previous setup again
didn't cause the error to appear.

Even so the board seems flaky so I'm hesitant to put it into full swing
just yet - I'll do a few stress test runs.
