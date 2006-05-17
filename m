From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 14:14:20 +0900
Message-ID: <446AB12C.10001@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:4266 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932120AbWEQFO1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 01:14:27 -0400
Received: by wr-out-0506.google.com with SMTP id i5so138792wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 22:14:27 -0700 (PDT)
In-Reply-To: <20060516215610.2b822c00.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

Andrew Morton wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> Hello, Andrew.
>>
>> Andrew Morton wrote:
>> [--snip--]
>>> [   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
>>> [   44.719425] ata2.00: ATAPI, max UDMA/66
>>> [   44.765263] ata2.00: applying bridge limits
>>> [   74.928836] ata2.01: qc timeout (cmd 0xa1)
>>> [   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
>>> [   75.468856] ata2.00: ATAPI, max UDMA/66
>>> [   75.514678] ata2.00: applying bridge limits
>>> [  105.674130] ata2.01: qc timeout (cmd 0xa1)
>> Did this device work with previous versions of kernel?
> 
> No.  In fact, it doesn't even work with the 2.6.17-rc4-mm1 lineup plus the
> latest git-libata-all.  It needs this tweak:
> 
> --- devel/drivers/scsi/ata_piix.c~2.6.17-rc4-mm1-ich8-fix	2006-05-16 18:36:12.000000000 -0700
> +++ devel-akpm/drivers/scsi/ata_piix.c	2006-05-16 18:36:12.000000000 -0700
> @@ -542,6 +542,14 @@ static unsigned int piix_sata_probe (str
>  		port = map[base + i];
>  		if (port < 0)
>  			continue;
> +		if (ap->flags & PIIX_FLAG_AHCI) {
> +			/* FIXME: Port status of AHCI controllers
> +			 * should be accessed in AHCI memory space.  */
> +			if (pcs & 1 << port)
> +				present_mask |= 1 << i;
> +			else
> +				pcs &= ~(1 << port);
> +		}
>  		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
>  			present_mask |= 1 << i;
>  		else
> _

Ah.. I see.  This is the ata_piix ghosting problem where signature of 
the first device is duplicated in the second device causing libata to 
probe the second non-existent device.

>> libata used to give up on the first failure during probe, so the boot 
>> time would have been shorter in failure cases.
> 
> I don't recall anyone complaining?

One of sata_via + ATAPI probing problem might have been fixed by this. 
It still needs to be investigated further though.

>>  I think controlled 
>> retries during boot probe is a good thing, but the timeout of 30s for 
>> IDENTIFY commands can be shortened, I guess.
> 
> We should do something, please.  It'll hurt kernel developers the most.

I think the correct solution would be fixing the ghosting problem of the 
controller.  I'll look into it.

-- 
tejun
