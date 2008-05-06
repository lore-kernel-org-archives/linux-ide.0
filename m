From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: improve post-reset device ready
 test
Date: Tue, 06 May 2008 10:17:32 -0400
Message-ID: <4820687C.4080803@garzik.org>
References: <4819D6A5.2030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39339 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYEFORe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:17:34 -0400
In-Reply-To: <4819D6A5.2030309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Some controllers (jmb and inic162x) use 0x77 and 0x7f to indicate that
> the device isn't ready yet.  It looks like they use 0xff if device
> presence is detected but connection isn't established.  0x77 or 0x7f
> after connection is established and use the value from signature FIS
> after receiving it.
> 
> This patch implements ata_check_ready(), which takes TF status value
> and determines whether the port is ready or not considering the above
> and other conditions, and use it in @check_ready() functions.  This is
> safe as both 0x77 and 0x7f aren't valid ready status value even though
> they have BSY bit cleared.
> 
> This fixes hot plug detection failures which can be triggered with
> certain drives if they aren't already spun up when the data connector
> is hot plugged.
> 
> Tested on sil, sil24, ahci (jmb/ich), piix and inic162x combined with
> eight drives from all major vendors.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> drivers/ata/ahci.c       |    4 +---
> drivers/ata/libata-sff.c |    6 +-----
> include/linux/libata.h   |   15 +++++++++++++++
> 3 files changed, 17 insertions(+), 8 deletions(-)

applied


