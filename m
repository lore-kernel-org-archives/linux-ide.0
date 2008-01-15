From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch for 2.6.24? 1/1] libata: correct handling of TSS DVD
Date: Tue, 15 Jan 2008 15:52:09 -0500
Message-ID: <478D1CF9.1040707@garzik.org>
References: <200801140906.m0E96Ks2020536@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50537 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728AbYAOUwl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jan 2008 15:52:41 -0500
In-Reply-To: <200801140906.m0E96Ks2020536@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com
Cc: jeff@garzik.org, htejun@gmail.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Devices that misreport the validity bit for word 93 look like SATA.  If
> they are on the blacklist then we must not test for SATA but assume 40 wire
> in the 40 wire case (The TSSCorp reports 80 wire on SATA it seems!)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/ata.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff -puN include/linux/ata.h~libata-correct-handling-of-tss-dvd include/linux/ata.h
> --- a/include/linux/ata.h~libata-correct-handling-of-tss-dvd
> +++ a/include/linux/ata.h
> @@ -554,8 +554,6 @@ static inline int ata_drive_40wire(const
>  
>  static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
>  {
> -	if (ata_id_is_sata(dev_id))
> -		return 0;	/* SATA */
>  	if ((dev_id[93] & 0x2000) == 0x2000)
>  		return 0;	/* 80 wire */
>  	return 1;


Alan, is this .24 material?

There were a lot of different threads and BZs about this one device, and 
I want to triple-check that multiple fixes are not being applied 
independently for the same problem.

	Jeff



