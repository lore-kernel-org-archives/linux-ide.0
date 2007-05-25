From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] NCQ blacklist Maxtor 6B200M0/BANC1B10
Date: Thu, 24 May 2007 23:16:35 -0400
Message-ID: <46565513.1090705@garzik.org>
References: <ecd3e9720704291931m742accd1h7d9f2c5d4362b7dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50782 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXEYDQh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:16:37 -0400
In-Reply-To: <ecd3e9720704291931m742accd1h7d9f2c5d4362b7dc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Griph <wslnptc@gmail.com>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Simon Griph wrote:
> With NCQ enabled, this drive always hangs when under load and remains
> hung until the next cold boot.
> 
> Very similar to: http://thread.gmane.org/gmane.linux.ide/17640
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0abd72d..17e27e9 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3373,6 +3373,7 @@ static const struct ata_blacklist_entry
> ata_device_blacklist [] = {
>        /* NCQ is broken */
>        { "Maxtor 6L250S0",     "BANC1G10",     ATA_HORKAGE_NONCQ },
>        /* NCQ hard hangs device under heavier load, needs hard power 
> cycle */
> +       { "Maxtor 6B200M0",     "BANC1B10",     ATA_HORKAGE_NONCQ },

Has this been verified under multiple controllers?


