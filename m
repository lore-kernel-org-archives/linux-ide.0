From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: implement and use HORKAGE_NOSETXFER,
 take#2
Date: Wed, 08 Jul 2009 20:29:27 -0400
Message-ID: <4A5539E7.8080204@garzik.org>
References: <4A553986.7010206@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58879 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795AbZGIAaL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jul 2009 20:30:11 -0400
In-Reply-To: <4A553986.7010206@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ide <linux-ide@vger.kernel.org>, lars21ce@gmx.de, linux-ide@momail.e4ward.com, Robert Hancock <hancockr@shaw.ca>, peter.klotz@aon.at, m.nov4k@gmail.com

Tejun Heo wrote:
> PIONEER DVD-RW DVRTD08 times out SETXFER if no media is present.  The
> device is SATA and simply skipping SETXFER works around the problem.
> Implement ATA_HORKAGE_NOSETXFER and apply it to the device.
> 
> Reported by Moritz Rigler in the following thread.
> 
>   http://thread.gmane.org/gmane.linux.ide/36790
> 
> and by Lars in bko#9540.
> 
> Updated to whine and ignore NOSETXFER if PATA component is detected as
> suggested by Alan Cox.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Moritz Rigler <linux-ide@momail.e4ward.com>
> Reported-by: Lars <lars21ce@gmx.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> Comment also added.  Thanks.
> 
>  drivers/ata/libata-core.c |   20 ++++++++++++++++++--
>  include/linux/libata.h    |    1 +
>  2 files changed, 19 insertions(+), 2 deletions(-)

Man, what a crappy device... :)

Will queue immediately...


