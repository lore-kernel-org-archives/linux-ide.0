From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Sat, 20 Mar 2004 06:34:48 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405C2C58.5090901@pobox.com>
References: <200403100006.36405.andres.meyer@computer.org> <200403100831.34416.andres.meyer@computer.org> <404EC5C3.2060603@pobox.com> <200403112258.33170.andres.meyer@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51352 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263369AbUCTLfB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Mar 2004 06:35:01 -0500
In-Reply-To: <200403112258.33170.andres.meyer@computer.org>
List-Id: linux-ide@vger.kernel.org
To: Andres Meyer <andres.meyer@computer.org>
Cc: linux-ide@vger.kernel.org

Andres Meyer wrote:
>>>As stated previously, It's a 32bit kernel, I did not event try 64bit SATA
>>>yet.
>>
>>Whoops, I missed that.  Thanks, I'll look into it.  If you are willing,
>>defining ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h, and
>>emailing dmesg output, would provide helpful details to me.
>>
>>	Jeff
> 
> 
> I did enable that, but there was not more output in case of crashes. I did try 
> to connect the 250GB SATA disks to the Promise, which seems to work ok.
> The 160GB IDE Maxtor & Marvel IDE2SATA on the promise seem to trigger the mce.
> 
> I still do not have a clue why...

Does "nomce" fix the mce?  :)  Some mce-related fixes are headed to 
Linus, I hear...

	Jeff




