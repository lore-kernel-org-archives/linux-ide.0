From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH] libata and bogus LBA48 drives
Date: Mon, 29 Oct 2007 16:28:42 -0400
Message-ID: <4726427A.3070106@garzik.org>
References: <Pine.LNX.4.62.0710292103500.9180@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55901 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604AbXJ2U2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Oct 2007 16:28:48 -0400
In-Reply-To: <Pine.LNX.4.62.0710292103500.9180@pademelon.sonytel.be>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, Olivier Demarto <olivierd@sonycom.com>, linux-ide@vger.kernel.org

Geert Uytterhoeven wrote:
> 	Hi Jeff,
> 
> A colleague noticed recent versions of Ubuntu no longer detect his 80 GB
> ST380020ACE drive. This drive is special in that it advertises LBA48 support,
> but has the lba_capacity_2 field set to zero (cfr.
> http://lkml.org/lkml/2004/3/30/163).
> 
> Upon closer look, libata indeed doesn't seem to handle this case yet.
> Below is an (untested) fix.
> 
> ---
> Subject: libata: Ignore bogus lba48 drives
> 
> Some drives (e.g. the 80 GB ST380020ACE) advertise they support LBA48, but have
> lba_capacity_2 field set to zero. This causes the drive not being detected by
> the libata driver.
> 
> Add a check for this to ata_id_has_lba48(), cfr. what is done in
> idedisk_supports_lba48().
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> NOTE: Untested due to the lack of hardware
> 
>  include/linux/ata.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -402,6 +402,8 @@ static inline int ata_id_has_lba48(const
>  {
>  	if ((id[83] & 0xC000) != 0x4000)
>  		return 0;
> +	if (!ata_id_u64(id, 100))
> +		return 0;
>  	return id[83] & (1 << 10);
>  }

Is there any hope of getting a dump of the IDENTIFY DEVICE page?

'hdparm --Istdout /dev/DEVICE' should do the trick, for either IDE 
driver or libata.

	Jeff



