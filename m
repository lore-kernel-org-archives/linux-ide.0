From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: to /sys from /proc/ide/hd$v/identify
Date: Mon, 07 Jun 2004 09:54:36 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40C4739C.6070508@pobox.com>
References: <1086616121.3649.0.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264452AbUFGNys
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 09:54:48 -0400
In-Reply-To: <1086616121.3649.0.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>List:       linux-kernel
>>Subject:    [RFC][DOC] writing IDE driver guidelines
>>From:       Bartlomiej Zolnierkiewicz <B.Z...()elk...>
>>Date:       2004-05-15 17:23:50
>>
>>Feedback is welcomed.
>>...
>>general rules:
>>...
>>- use linux-ide@vger.kernel.org mailing list
>>...
>>PCI drivers:
>>...
>>- /proc/ide/ interfaces are obsolete
> 
> 
> Where do I now find the ATA op xEC/A1 "IDENTIFY" data that was
> /proc/ide/hd$v/identify ?
> 
> $ uname -r
> 2.6.7-rc2
> $
> $ sudo cat /proc/ide/hda/identify | wc -w
>     256
> $ sudo cat /proc/ide/hdc/identify | wc -w
>     256
> $
> $ sudo mount -t sysfs sysfs /sys
> $ sudo find /sys -name '*id*' | less
> $ find /sys/bus/ide | less


Since IDE supports taskfile ioctl, you shouldn't need this in sysfs...

	Jeff


