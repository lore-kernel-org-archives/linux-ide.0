From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under kernel 2.6.18
Date: Mon, 23 Oct 2006 14:35:59 +0100
Message-ID: <op.thvmp9mrxci36i@akima>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com> <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima> <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com> <op.thtxiw0axci36i@akima> <453C2748.9030008@gmail.com> <1161598438.19388.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:9552 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964857AbWJWNgD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Oct 2006 09:36:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1244419ugd
        for <linux-ide@vger.kernel.org>; Mon, 23 Oct 2006 06:36:01 -0700 (PDT)
In-Reply-To: <1161598438.19388.7.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, 23 Oct 2006 11:13:57 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>  
wrote:

> Ar Llu, 2006-10-23 am 11:22 +0900, ysgrifennodd Tejun Heo:
>> I guess it could be a PCI bus problem.  Maybe the controller and the PCI
>> bus on the board don't like each other and thing get corrupt when
>> transactions occur at high speed.  I've seen data corruption over PCI
>> bus on some pilot embedded system board.  Not sure whether such things
>> are applicable to consumer products.
>
>> From the IDE driver...
>
>  *      If you have strange problems with nVidia chipset systems please
>  *      see the SI support documentation and update your system BIOS
>  *      if neccessary
>
>
> Alan
>


BIOS for the A7N8X is the latest 1008 version which overcomes a boot  
limitation - the board would not boot with more than 1 SATA controller  
installed.

This RAID corruption bug was supposedly fixed in 1005.

Since contacting Asus technical support is likely to be as productive as  
getting blood from a stone, I'm going to go ahead and scrounge another  
motherboard - since this is socket A stuff it should be dirt cheap by now.

Thanks for all the suggestions,
Jonathan
