From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Opteron SATA machine check exception (32bit)
Date: Wed, 10 Mar 2004 02:37:39 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <404EC5C3.2060603@pobox.com>
References: <200403100006.36405.andres.meyer@computer.org> <404EC21E.4030809@pobox.com> <200403100831.34416.andres.meyer@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7830 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262396AbUCJHhw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Mar 2004 02:37:52 -0500
In-Reply-To: <200403100831.34416.andres.meyer@computer.org>
List-Id: linux-ide@vger.kernel.org
To: Andres Meyer <andres.meyer@computer.org>
Cc: linux-ide@vger.kernel.org

Andres Meyer wrote:
> On Wednesday 10 March 2004 08.22, Jeff Garzik wrote:
> 
>>The sata_sil driver is known to have problems at the moment.  Are you
>>having problems with drives connected to the Promise controller as well?
>>  That seems to be working fine on x86, but I wonder if there are
>>problems on x86-64.
>>
>>Can you try booting a 32-bit kernel to see if that changes your results?
>>
>>	Jeff
> 
> 
> As stated previously, It's a 32bit kernel, I did not event try 64bit SATA yet.

Whoops, I missed that.  Thanks, I'll look into it.  If you are willing, 
defining ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h, and 
emailing dmesg output, would provide helpful details to me.

	Jeff




