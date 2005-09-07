From: Jeremy Smith <alceste@xmission.com>
Subject: Re: RE :sata_sil + UDMA CRC errors
Date: Wed, 7 Sep 2005 07:52:33 -0600 (MDT)
Message-ID: <Pine.LNX.4.63.0509070737330.1470@xmission.xmission.com>
References: <200509070730.j877UxgA022401@ns.isp.nsc.ru> <431EB95C.3070801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mgr2.xmission.com ([198.60.22.202]:55755 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S1750962AbVIGNwm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Sep 2005 09:52:42 -0400
In-Reply-To: <431EB95C.3070801@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alexander Shaposhnikov <shaposh@isp.nsc.ru>, 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com, Paul.Taylor@siliconimage.com, lbattraw@insightbb.com, 'Yuri Kirsanov' <flash@rccb.ru>



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

> I fear that there's nothing much else I can do about this K8N-DL sil CRC 
> error.  I've read the hw doc but couldn't find anything which seems helpful. 
> Let's hope something (BIOS update?) comes up soon.

Well, myself I think I'm going to be getting a known-good hardware RAID 
controller (probably the 3ware) for this board.  I'm getting the lockups 
after 1-3 hours, and that's not enough uptime for me.  Kinda sucks to have 
two SATA chips onboard and problems with both of them.  If there are any 
thoughts or patches you folks have, I'm happy to try them out.

Jer
