From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Thu, 08 Nov 2007 22:29:37 -0500
Message-ID: <4733D421.7000505@rtr.ca>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3343 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbXKID3j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 22:29:39 -0500
In-Reply-To: <20071109023129.GA25581@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> On Fri, Nov 09, 2007 at 09:02:35AM +0700, Riki Oktarianto wrote:
>> Some BIOSen map AHCI ABAR but lock the SATA controller to IDE mode.
>> This patch add quirk to set AHCI mode on ICH board with such case.
>>
>> Tested on Macbook2,1 (ICH7M)
> 
> Intel will complain but it's awful tempting...

*Very* tempting.

And I might even privately patch my own kernels to map the ACHI BAR
in the cases where the BIOS didn't...
