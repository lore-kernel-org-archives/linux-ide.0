From: Jeremy Smith <alceste@xmission.com>
Subject: Re: RE :sata_sil + UDMA CRC errors
Date: Fri, 9 Sep 2005 14:10:15 -0600 (MDT)
Message-ID: <Pine.LNX.4.63.0509091405460.7778@xmission.xmission.com>
References: <200509070730.j877UxgA022401@ns.isp.nsc.ru> <431EB95C.3070801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mgr2.xmission.com ([198.60.22.202]:15815 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S1030442AbVIIUKS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 16:10:18 -0400
In-Reply-To: <431EB95C.3070801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alexander Shaposhnikov <shaposh@isp.nsc.ru>, 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com, Paul.Taylor@siliconimage.com, lbattraw@insightbb.com, 'Yuri Kirsanov' <flash@rccb.ru>


One other bit of information on this problem: When I first set up this 
machine, I had two drives hooked up to the controller, but was only using 
one for the install for the first couple of days.

As far as I could tell, as long as I was only ever touching the first 
channel/first disk, I wasn't experiencing this problem.  I set up a 
logical volume manager volume across both disks--and then the problem 
started to happen in earnest.  Is it possible that this problem only 
surfaces with two disks hooked up to the controller on this particular 
board--and that with only one it isn't an issue?  I intend to remove one 
of the disks and hit the other one hard and see if it's a problem.

Alexander, were you ever working with the linux driver where you only ever 
hit one disk?

Thanks,
Jer


On Wed, 7 Sep 2005, Tejun Heo wrote:

>
> Hello, Alexander & Jeremy.
>
> Alexander Shaposhnikov wrote:
>> Hellow Tejun
>> 
>> I tried your patch (by the way, it cannot be applied by patch utility -it
>> complains about malformed expression on line 19 and so on)
>> Default reads in 500mv. With 600mv, I am starting to get CRC errors for
>> Seagate drive (no errors with 2.6.13-git4). Samsung drive produces so many
>> errors, that it is unusable both with and without patch.
>
> Ugh... that's ugly. :-/
>
> Jeremy, apparantly my little patch doesn't do any good.  Please ignore it.
>
>> Concerning K8N-DL motherboard -current BIOS 1004 is very buggy. It has
>> screwed up ACPI APIC table. To use onboard lan and usb, I have to boot with 
>> pci=noacpi boot option. And I cannot use 1003, as I have DualCore Opterons, 
>> and 1004 the only one which supports them!
>> 
>> There is long problem with Nvidia CK804 southbridge sata under Linux.
>> Despite that the board was released some 8 month ago, it still cannot be
>> used! And nobody seems to care about this. ASUS in the least. I was able to 
>> boot from NVidia SATA with latest kernel and irqpoll option.
>> At first I thought that all my problems are gone at last, but the god
>> decided differently. It works at light disk load, but havy load lead to
>> system freeze. No errors, just dead freeze. I returned to silicon3114 sata.
>> At least, I have one working drive now:)
>> 
>
> I fear that there's nothing much else I can do about this K8N-DL sil CRC 
> error.  I've read the hw doc but couldn't find anything which seems helpful. 
> Let's hope something (BIOS update?) comes up soon.
>
> Sorry.
>
> -- 
> tejun
>
