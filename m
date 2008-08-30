From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/4] Introduce ata_id_has_unload()
Date: Sat, 30 Aug 2008 15:56:42 +0400
Message-ID: <48B9357A.3040508@ru.mvista.com>
References: <87wshzplvk.fsf@denkblock.local> <20080829211345.4355.63012.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:31131 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751364AbYH3L4v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 07:56:51 -0400
In-Reply-To: <20080829211345.4355.63012.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Elias Oltmanns wrote:

> Add a function to check an ATA device's id for head unload support as
> specified in ATA-7.
>
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
>   
[...]
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 80364b6..d9a94bd 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -707,6 +707,23 @@ static inline int ata_id_has_dword_io(const u16 *id)
>  	return 0;
>  }
>  
> +static inline int ata_id_has_unload(const u16 *id)
> +{
> +	/*
> +	 * ATA-7 specifies two places to indicate unload feature
> +	 * support. Since I don't really understand the difference,
> +	 * I'll just check both and only return zero if none of them
> +	 * indicates otherwise.
>   

   If you read the comments to the words 82:84 and 85:87, they say that 
the former indicate the supported features, and the latter indicate the 
enabed features AND in case a feature can't be disabled, the latter 
words will have the corresponding bit set. So it should be sufficient to 
check only one word.

> +	 */
> +	if (ata_id_major_version(id) >= 7
> +	    && (((id[ATA_ID_CFSSE] & 0xC000) == 0x4000
> +		 && id[ATA_ID_CFSSE] & (1 << 13))
> +		|| ((id[ATA_ID_CSF_DEFAULT] & 0xC000) == 0x4000
> +		    && (id[ATA_ID_CSF_DEFAULT] & (1 << 13)))))
>   


   I think that it's preferrable to leave the operator on the same line 
with the first operand...

WBR, Sergei


