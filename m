From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
Date: Thu, 13 Oct 2005 10:41:59 -0400
Message-ID: <434E7237.1070508@rtr.ca>
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org>	 <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>	 <434D3266.9000203@gentoo.org>	 <1129139563.7966.4.camel@localhost.localdomain> <1129203917.18635.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751526AbVJMOl5@vger.kernel.org>
In-Reply-To: <1129203917.18635.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Drake <dsd@gentoo.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net, vsu@altlinux.ru
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>
> If the bus speed of your 486 is 25Mhz the chipset is at 25MHz as is your
> IDE (ie 486/25, DX2/50, 3/75 - not sure about 4/100 etc). Now does
> anyone know how you find out if the CPU is 25MHz bus clocked on a 486 8)

Same method as /proc/cpuinfo, for an approximation?  :)
