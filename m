From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: initialize link speed from sstatus if online.
Date: Sat, 21 Oct 2017 09:48:43 -0700
Message-ID: <20171021164843.GW1302522@devbig577.frc2.facebook.com>
References: <1508437836-31649-1-git-send-email-dmilburn@redhat.com>
 <1508437836-31649-2-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:51508 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdJUQsr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 21 Oct 2017 12:48:47 -0400
Received: by mail-qt0-f180.google.com with SMTP id h4so21817318qtk.8
        for <linux-ide@vger.kernel.org>; Sat, 21 Oct 2017 09:48:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1508437836-31649-2-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

Hello, David.

On Thu, Oct 19, 2017 at 01:30:35PM -0500, David Milburn wrote:
> @@ -3002,16 +3002,16 @@ int ata_bus_probe(struct ata_port *ap)
>   */
>  static void sata_print_link_status(struct ata_link *link)
>  {
> -	u32 sstatus, scontrol, tmp;
> +	u32 sstatus, scontrol;
>  
>  	if (sata_scr_read(link, SCR_STATUS, &sstatus))
>  		return;
>  	sata_scr_read(link, SCR_CONTROL, &scontrol);
>  
>  	if (ata_phys_link_online(link)) {
> -		tmp = (sstatus >> 4) & 0xf;
> +		link->sata_spd = (sstatus >> 4) & 0xf;
>  		ata_link_info(link, "SATA link up %s (SStatus %X SControl %X)\n",
> -			      sata_spd_string(tmp), sstatus, scontrol);
> +			      sata_spd_string(link->sata_spd), sstatus, scontrol);
>  	} else {
>  		ata_link_info(link, "SATA link down (SStatus %X SControl %X)\n",
>  			      sstatus, scontrol);

I don't think it makes sense to update a link field from a
print_status function.

Thanks.

-- 
tejun
