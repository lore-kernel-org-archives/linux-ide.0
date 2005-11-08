From: Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Subject: Re: Highpoint IDE types
Date: Tue, 08 Nov 2005 22:40:06 +0300
Message-ID: <4370FF16.5000205@dev.rtsoft.ru>
References: <1131471483.25192.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:24246 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965211AbVKHTiX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Nov 2005 14:38:23 -0500
In-Reply-To: <1131471483.25192.76.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> Ok thanks to Sergei I can now post what I think is the complete table of
> HPT chip versions:

    Sent 371N ID to you more than a month ago already. :-)

> The base clocks for the devices are as follows (note this means most of
> the drivers/ide/pci detection code for frequency is wrong). Also for PLL
> mode the 3x2N PLL stabilization code is subtly different.

    Can somebody please tell me what this "base clock" thing is? Where it is
derived from? I see those different figures in Highpoint's driver PLL setup
code but failed to understand how that clock detection thing works...
   And that's after I even saw a couple of their datasheets. :-/

> 371N/372N/302N		77
> 302/371/372A		66
> 372			55
> 370/374			48
> 
> The DPLLs are
> 	48, 50, 66, 75Mhz
> 
> 75 is only available on the later chips and used with PATA/SATA bridge
> chips for UDMA7.

WBR, Sergei

