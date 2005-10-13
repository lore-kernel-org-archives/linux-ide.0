From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Thu, 13 Oct 2005 16:29:04 +0100
Message-ID: <1129217344.18635.35.camel@localhost.localdomain>
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
	 <434D3266.9000203@gentoo.org>
	 <1129139563.7966.4.camel@localhost.localdomain>
	 <1129203917.18635.1.camel@localhost.localdomain>  <434E7237.1070508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:51652 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750823AbVJMPBG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Oct 2005 11:01:06 -0400
In-Reply-To: <434E7237.1070508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Daniel Drake <dsd@gentoo.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru

On Iau, 2005-10-13 at 10:41 -0400, Mark Lord wrote:
> Alan Cox wrote:
> >
> > If the bus speed of your 486 is 25Mhz the chipset is at 25MHz as is your
> > IDE (ie 486/25, DX2/50, 3/75 - not sure about 4/100 etc). Now does
> > anyone know how you find out if the CPU is 25MHz bus clocked on a 486 8)
> 
> Same method as /proc/cpuinfo, for an approximation?  :)

Unfortunately cpuinfo doesn't know the difference between a 100Mhz
(4x25) and 100Mhz (3x33). Late 486s have cpuid which helps a bit but
many do not have that (it comes in with writeback cache) and they don't
have rdmsr to access the processor boot bus speed bits as the preventium
and later do.

Alan

