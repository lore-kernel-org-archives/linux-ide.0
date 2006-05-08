From: Tejun Heo <htejun@gmail.com>
Subject: Re: Infinite loop on MODE-SENSE with a removable ATAPI sata device
 on VIA chipset
Date: Tue, 09 May 2006 08:12:30 +0900
Message-ID: <445FD05E.7050104@gmail.com>
References: <E656D53DA4B96C409683999F573A360723E4B4@sbs.ARCO.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:37949 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWEHXMh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 May 2006 19:12:37 -0400
Received: by nz-out-0102.google.com with SMTP id 13so1322107nzn
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2006 16:12:36 -0700 (PDT)
In-Reply-To: <E656D53DA4B96C409683999F573A360723E4B4@sbs.ARCO.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dario Oliva <DOliva@ARCOIDE.COM>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Dario Oliva wrote:
> Hello Mr. Garzik:
> 
> We have a removable, ATAPI, SATA device and we are having the following
> problem with Linux (kernel version 2.6.15.6). The device recieves a MODE
> SENSE command. After receiving this command, it is supposed to receive a
> 12-byte packet command, which it recieves. Afterwards there is supposed
> to be an IRQ, and then the data is read from the device. However, in one
> computer we have with a VIA chipset, the device keeps getting zeroes
> without stopping. In other words, it gets the 12-bytes and the continues
> to recive bytes all of which are zero. The device never gets the IRQ,
> therefore it does not respond.
> 
> Any ideas on this?
> 
> Thanks in advance for any help.

Please post what kind of ATAPI device you are using and the kernel log. 
  If possible, please change #undef ATA_DEBUG in include/linux/libata.h 
to #define ATA_DEBUG prior to generate the kernel log.

-- 
tejun
