From: Bogdan Costescu <bogdan@dingo.iwr.uni-heidelberg.de>
Subject: Re: Marvell 88SX[56]0[48]1 libata progress?
Date: Fri, 28 Jan 2005 19:10:43 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0501281829260.22522-100000@dingo.iwr.uni-heidelberg.de>
References: <41F96FBB.7000704@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:63406 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261503AbVA1SKy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:10:54 -0500
In-Reply-To: <41F96FBB.7000704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux@horizon.com, linux-ide@vger.kernel.org, andyw@pobox.com

On Thu, 27 Jan 2005, Jeff Garzik wrote:

> After that, I'll do a round of driver writing for Marvell and several other 
> boards.

Any tentative time-frame ? I'm also interested due to the presence of 
this controller disguised as Adaptec AIC-8110 on my Asus mainboard.

Unfortunately Asus only provides binary drivers for RH 8 & 9 and 
equally ancient SuSE kernels on the CD that accompanied the board, so 
no hope form there.

I have however found a driver with complete source (no .o files or I
have missed them) at:

http://file.abit.com.tw/pub/download/drivers/linux/marvell/mvsata340.zip

It compiled without any problem for the 2.4 kernel of TaoLinux, but
the performance is very low: hdparm shows only about 9Mb/s for a WD
Raptor disk. I refuse to believe that this is a normal level of
performance from this controller, the driver must be at fault...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

