From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Marvell 88SX[56]0[48]1 libata progress?
Date: Fri, 28 Jan 2005 13:20:04 -0500
Message-ID: <41FA8254.1040505@pobox.com>
References: <Pine.LNX.4.61.0501281829260.22522-100000@dingo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48816 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261524AbVA1SUW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Jan 2005 13:20:22 -0500
In-Reply-To: <Pine.LNX.4.61.0501281829260.22522-100000@dingo.iwr.uni-heidelberg.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bogdan Costescu <bogdan@dingo.iwr.uni-heidelberg.de>
Cc: linux@horizon.com, linux-ide@vger.kernel.org, andyw@pobox.com

Bogdan Costescu wrote:
> On Thu, 27 Jan 2005, Jeff Garzik wrote:
> 
> 
>>After that, I'll do a round of driver writing for Marvell and several other 
>>boards.
> 
> 
> Any tentative time-frame ? I'm also interested due to the presence of 
> this controller disguised as Adaptec AIC-8110 on my Asus mainboard.
> 
> Unfortunately Asus only provides binary drivers for RH 8 & 9 and 
> equally ancient SuSE kernels on the CD that accompanied the board, so 
> no hope form there.
> 
> I have however found a driver with complete source (no .o files or I
> have missed them) at:
> 
> http://file.abit.com.tw/pub/download/drivers/linux/marvell/mvsata340.zip
> 
> It compiled without any problem for the 2.4 kernel of TaoLinux, but
> the performance is very low: hdparm shows only about 9Mb/s for a WD
> Raptor disk. I refuse to believe that this is a normal level of
> performance from this controller, the driver must be at fault...

That driver has also been rejected...  it's vastly overengineered for 
what it needs to do, and should not be directly using the SCSI 
infrastructure (which makes it divergent from other SATA drives, which 
only indirectly use it) -- which causes incompatibilities down the line.

	Jeff



