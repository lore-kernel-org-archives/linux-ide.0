From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata pm
Date: Mon, 28 Jan 2008 10:17:48 +0900
Message-ID: <479D2D3C.4050102@gmail.com>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>       <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>       <479BC34D.2000007@gmail.com>    <49407.82.140.63.93.1201397926.squirrel@ssl.cavemail.org> <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:39358 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYA1BRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 20:17:55 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1520787rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 17:17:54 -0800 (PST)
In-Reply-To: <49713.82.140.63.93.1201462475.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: linux-ide@vger.kernel.org

Hello,

dusty@gmx.li wrote:
> With one, two and three drives on the pm I got no errors, so I tried to
> change the power supply. I got two power supplies for the 16 harddrives
> and the second one (with all Maxtor drives and the first pm) was failing.
> After changing the power supply all problems where gone. Sorry for the
> confusion.

It's amazing that, in SATA, PSU-problem-verified / PSU-problem-suggested
ratio is significant.  I don't think this ever was the case with PATA.
SATA link seems much more susceptible to power quality and allows
hooking up whole lot of drives.

> The only remaining issue is that some sata links are only working with 1.5
> gbps and I can't figure out why. (ata3,4,5,6.x are the Maxtor drives and
> ata7,8,9,10.x are the Samsung ones)
> 
> jasmin ~ # dmesg | grep Gbps
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata10.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata10.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata10.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata10.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata10.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata10.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Hmm... That's how the hardware negotiated transfer rate w/ each other.
SControl is telling the hardware that there's no speed limit and to go
as high as it can but somehow 3.0Gbps negotiation failed and the link
speed is limited to 1.5Gbps for some of the ports.  Is the result always
the same?  What happens if you swap drives between ports?  Also, if you
have an extra PSU lying around, can you hook it up with some of the
drives such that the load is more distributed.

Oh.. Another note on PSU.  I don't know whether this still holds for
more recent ones but mid-to-high range multi-lane PSUs sometimes have
lesser juice on 12v rail available for disks than low cost single lane
PSUs.  This is because high power 12v lanes are allocated to power video
cards and disks can only pull power from (usually) single weak 12v lane.

Thanks.

-- 
tejun
