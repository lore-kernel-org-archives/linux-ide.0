From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: set queue SSD flag for SSD devices
Date: Fri, 10 Oct 2008 20:25:15 +0100
Message-ID: <20081010202515.446857cc@lxorguk.ukuu.org.uk>
References: <200810101904.m9AJ42Gq018897@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761906AbYJJT0k@vger.kernel.org>
In-Reply-To: <200810101904.m9AJ42Gq018897@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, jens.axboe@oracle.com
List-Id: linux-ide@vger.kernel.org

> +	ATA_ID_ROT_SPEED	= 217,
>  	ATA_ID_PIO4		= (1 << 1),
>  
>  	ATA_ID_SERNO_LEN	= 20,
> @@ -691,6 +692,11 @@ static inline int ata_id_is_cfa(const u16 *id)
>  	return 0;
>  }
>  
> +static inline int ata_id_is_ssd(const u16 *id)
> +{
> +	return id[ATA_ID_ROT_SPEED] == 0x01;
> +}

This patch is buggy.

Word 217 only has a defined meaning in late revision ATA standards so a
version check is needed. Please copy ATA patch copies to linux-ide.

Alan
