From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Intel 31244
Date: Sat, 05 Feb 2005 21:41:19 -0500
Message-ID: <420583CF.9060409@pobox.com>
References: <41B86DDA.6000204@vanteon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25258 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S270596AbVBFClf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 21:41:35 -0500
In-Reply-To: <41B86DDA.6000204@vanteon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Herbert <herbert@vanteon.com>
Cc: linux-ide@vger.kernel.org, herbert@infosecuresystems.com

Tom Herbert wrote:
> Jeremy,
> 
> Hi.
> 
> I am working on a project to update an embedded RAID controller to use 
> the Intel 31244 chip. I would like to use the sata_vsc driver as an 
> alternative to the Intel sample sources. There are very recent comments 
> in various places in the driver code and at 
> http://www.linuxmafia.com/faq/Hardware/sata.html#via suggesting that the 
> Vitesse VSC7174 chip is compatible. This also appears to be likely  
> after a preliminary comparision of the code with the 31244 Intel docs.
> 
> Before I jump in and commit to using this driver, I would appreciate it 
> if you or Jeff have any information as to whether the sata_vsc chip has 
> been tested yet with the Intel chip.

Someone on the list reported it working.

	Jeff



