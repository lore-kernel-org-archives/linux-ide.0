From: Borislav Petkov <bp@amd64.org>
Subject: Re: Machine check exception
Date: Wed, 27 Jul 2011 15:03:19 +0200
Message-ID: <20110727130319.GA26923@gere.osrc.amd.com>
References: <4E2FF0EC.2020704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s15228384.onlinehome-server.info ([87.106.30.177]:58215 "EHLO
	mail.x86-64.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1G0NDI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2011 09:03:08 -0400
Content-Disposition: inline
In-Reply-To: <4E2FF0EC.2020704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "F. P. Beekhof" <fpbeekhof@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

On Wed, Jul 27, 2011 at 01:05:16PM +0200, F. P. Beekhof wrote:
> Hello,
> 
> I'm having some trouble with my Promise TX4302: it seems to cause
> kernel panics due to machine check exceptions.
> 
> The MCE reads:
> [Hardware Error]: CPU 0: Machine Check Exception: 4 Bank 4: ...
> [Hardware Error]: TSC 264f8ca046
> and then continues about a NorthBridge Watchdog timeout.
> After that, there is kernel stack dump:
> 
> See http://tech.unige.ch/mce.jpg or http://tech.unige.ch/mce.png for
> a screenshot.
> 
> These always happen when I'm accessing disks attached to the TX4302,
> as far as I can tell. Motherboard is an Asus a8v, cpu is amd
> athlon64, stock ubuntu 11.04 kernel.
> 
> I have no idea where to go from here though. I can provide any
> information required or test patches, please ask.

can you install msr-tools and do

rdmsr 0xc001001f

as root and send me the output please?

Thanks.

-- 
Regards/Gruss,
Boris.

Advanced Micro Devices GmbH
Einsteinring 24, 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Gemeinde Aschheim, Landkreis Muenchen
Registergericht Muenchen, HRB Nr. 43632
