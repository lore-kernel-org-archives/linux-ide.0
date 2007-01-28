From: Adrian Bunk <bunk@stusta.de>
Subject: Re: Boot problems with pata_via driver
Date: Mon, 29 Jan 2007 00:11:47 +0100
Message-ID: <20070128231147.GA6017@stusta.de>
References: <8d158e1f0701280347l1d778528la0d69647726485d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42668 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932970AbXA1XLj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 18:11:39 -0500
Content-Disposition: inline
In-Reply-To: <8d158e1f0701280347l1d778528la0d69647726485d6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Jan 28, 2007 at 12:47:18PM +0100, Patrick Ale wrote:

> Hi,

Hi Patrick,

> With kernel 2.6.19 I was able to boot using the pata_via driver
> I tried to compile 2.6.20-rc6 and now I get a "unknown device: sda3"
> error when I try to boot.
> 
> I compiled 2.6.20-rc6 by copying over the .config from the 2.6.19 tree
> and running a make oldconfig && make
> 
> Am I doing something wrong?

Both kernels are self-compiled or is 2.6.19 a distribution kernel?

It could be that 2.6.20-rc6 has a bug and therefore no longer is able to 
use your controller.
It's also possible that the enumeration changed (e.g. sda is now an 
external hard disk).

During boot, there should be some messages prefixed with ata: and sda: 
describing what your kernel found and how it enumerated them.
What do they print with 2.6.20-rc6?

> Patrick

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

