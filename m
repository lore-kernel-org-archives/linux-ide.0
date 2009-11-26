From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's EP93xx
 CPUs
Date: Fri, 27 Nov 2009 08:46:01 +1300
Message-ID: <4B0EDAF9.7080902@bluewatersys.com>
References: <200911261651.40928.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752486AbZKZTpl@vger.kernel.org>
In-Reply-To: <200911261651.40928.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Joao Ramos <joao.ramos@inov.pt>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Based on the older IDE host driver by Joao Ramos and review comments
> for it from Sergei Shtylyov.  Not yet tested with the real hardware.

> 
> Sidenote:
> 
> I have neither the hardware nor much personal interest in adding support
> for it so I did it mainly cause:
> 
> - IDE host driver wasn't merged due to policy change and I hate seeing fair
>   amount of review work from me & Sergei going into waste. :)
> 
> - I was curious about some claims I've been hearing recently so I decided to
>   verify them in practice (porting the driver to libata was relatively easy
>   but unfortunately in the process it gained almost 50% in the LOC count..).
> 
> so if somebody would like to take over this patch feel free to do it.

Thanks for doing this. I'll see if I can dig out a hard-drive and give
this a test. I had some comments, but I will fix them up myself if I get
round to testing this.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
