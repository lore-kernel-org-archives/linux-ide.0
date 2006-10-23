From: Tejun Heo <htejun@gmail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under
 kernel 2.6.18
Date: Mon, 23 Oct 2006 11:22:00 +0900
Message-ID: <453C2748.9030008@gmail.com>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com> <452A0BA6.8030401@gmail.com> <op.tg5ssogyxci36i@akima> <op.tg93opjoxci36i@akima> <4530D474.6000609@gmail.com> <op.thtxiw0axci36i@akima>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:45198 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751094AbWJWCWI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 22:22:08 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1144272ugd
        for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 19:22:06 -0700 (PDT)
In-Reply-To: <op.thtxiw0axci36i@akima>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: linux-ide@vger.kernel.org

Jonathan Bell wrote:
> This is where it gets wierd... I may have uncovered a BIOS bug.
> 
> I changed the mainboard out as a last-ditch attempt to get this working 
> and BEHOLD! The drives work perfectly. I swapped the A7N8X-D out for an 
> Abit NF7-M (same nForce2 chipset, with the exception of onboard 
> graphics) and used the same hardware as before.
> 
> This NF7-M is on loan to me so I cannot use it indefinitely. Any ideas, 
> Tejun?
> 
> Worst comes to worst I can buy an old nForce2 board for a minor sum off 
> eBay.

I guess it could be a PCI bus problem.  Maybe the controller and the PCI 
bus on the board don't like each other and thing get corrupt when 
transactions occur at high speed.  I've seen data corruption over PCI 
bus on some pilot embedded system board.  Not sure whether such things 
are applicable to consumer products.

I dunno.  Simply changing the motherboard or the controller might be the 
best solution for you.  Considering the large deployment of 
3112/3152/3114 controllers, it's hard to believe your problem is 
software bug.

Thanks.

-- 
tejun
