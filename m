From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.21-rc7-mm2 2/2] sata_promise: move port reset from
 error intr to EH prereset
Date: Mon, 30 Apr 2007 11:27:46 +0200
Message-ID: <4635B692.5040507@gmail.com>
References: <200704290203.l3T23UeQ009873@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:6541 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030827AbXD3TuT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 15:50:19 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2031854nzf
        for <linux-ide@vger.kernel.org>; Mon, 30 Apr 2007 12:50:19 -0700 (PDT)
In-Reply-To: <200704290203.l3T23UeQ009873@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

Mikael Pettersson wrote:
> @@ -647,12 +650,10 @@ static void pdc_error_intr(struct ata_po
>  			   | PDC_PCI_SYS_ERR | PDC1_PCI_PARITY_ERR))
>  		ac_err_mask |= AC_ERR_HOST_BUS;
>  
> -	if (sata_scr_valid(ap))
> -		ehi->serror |= pdc_sata_scr_read(ap, SCR_ERROR);
> -
> +	ehi->action |= ATA_EH_SOFTRESET;
>  	qc->err_mask |= ac_err_mask;
>  
> -	pdc_reset_port(ap);
> +	ata_port_freeze(ap);
>  }

You really don't wanna schedule ATA_EH_SOFTRESET and freeze the port on
every error.  If you do that, ATAPI devices will be reset after each
CHECK CONDITION and it probably won't work properly.  FWIW, libata EH
automatically issues softreset if the port is frozen (as that's the only
way to thaw the port), so setting EH_SOFTRESET is optional if you freeze
the port.

Another problem is that EH may issue other commands to while trying to
recover - e.g. PACKET - REQUEST SENSE or READ LOG PAGE.  This only
happens if the port is ready for commands, IOW, !frozen.  Before, the
pdc_reset_port() used to be called on entry to EH if it's not frozen but
it's not after this patch.  Is this safe?

I think adding a call to pdc_reset_port() to prereset() and freezing the
port if the port is in weird state should do it but I dunno much about
the controller.

Thanks.

-- 
tejun

