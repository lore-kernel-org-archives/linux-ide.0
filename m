From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 v3] Introduce ata_id_has_unload()
Date: Mon, 29 Sep 2008 00:34:04 -0400
Message-ID: <48E05ABC.4020802@garzik.org>
References: <87tzcb7r0r.fsf@denkblock.local> <20080919214359.7183.81870.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40935 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbYI2EeM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:12 -0400
In-Reply-To: <20080919214359.7183.81870.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> Add a function to check an ATA device's id for head unload support as
> specified in ATA-7.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> ---
> 
>  include/linux/ata.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index cea079c..c66a7d6 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -707,6 +707,15 @@ static inline int ata_id_has_dword_io(const u16 *id)
>  	return 0;
>  }
>  
> +static inline int ata_id_has_unload(const u16 *id)
> +{
> +	if (ata_id_major_version(id) >= 7 &&
> +	    (id[ATA_ID_CFSSE] & 0xC000) == 0x4000 &&
> +	    id[ATA_ID_CFSSE] & (1 << 13))
> +		return 1;
> +	return 0;
> +}
> +
>  static inline int ata_id_current_chs_valid(const u16 *id)
>  {
>  	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command

applied 1-2


