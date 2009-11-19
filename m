From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: retry failed FLUSH if device didn't
 fail it
Date: Thu, 19 Nov 2009 18:45:06 -0500
Message-ID: <4B05D882.5010509@garzik.org>
References: <4B04E77D.8070807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53587 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757028AbZKSXpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Nov 2009 18:45:07 -0500
In-Reply-To: <4B04E77D.8070807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrey Vihrov <andrey.vihrov@gmail.com>

On 11/19/2009 01:36 AM, Tejun Heo wrote:
> If ATA device failed FLUSH, it means that the device failed to write
> out some amount of data and the error needs to be reported to upper
> layers. As retries can't recover the lost data, FLUSH failures need to
> be reported immediately in general.
>
> However, if FLUSH fails due to transmission errors, the FLUSH needs to
> be retried; otherwise, filesystems may switch to RO mode and/or raid
> array may drop a drive for a random transmission glitch.
>
> This condition can be rather easily reproduced on certain ahci
> controllers which go through a PHY event after powersave mode switch +
> ext4 combination.  Powersave mode switch is often closely followed by
> flush from the filesystem failing the FLUSH with ATA bus error which
> makes the filesystem code believe that data is lost and drop to RO
> mode.  This was reported in the following bugzilla bug.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=14543
>
> This patch makes libata EH retry FLUSH if it wasn't failed by the
> device.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Andrey Vihrov<andrey.vihrov@gmail.com>
> ---
>   drivers/ata/libata-eh.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/libata.h  |    2 -
>   2 files changed, 95 insertions(+), 1 deletion(-)

applied

