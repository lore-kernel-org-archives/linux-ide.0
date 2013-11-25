From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add ATA_HORKAGE_BROKEN_FPDMA_AA quirk for Seagate
 Momentus SpinPoint M8
Date: Mon, 25 Nov 2013 21:08:42 +0000
Message-ID: <20131125210842.0c68ee92@alan.etchedpixels.co.uk>
References: <1385406014-4877-1-git-send-email-michele@acksyn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43217 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3KYVLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Nov 2013 16:11:16 -0500
In-Reply-To: <1385406014-4877-1-git-send-email-michele@acksyn.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michele Baldessari <michele@acksyn.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org

> Reported-by: Nicholas <arealityfarbetween@googlemail.com>
> Signed-off-by: Michele Baldessari <michele@acksyn.org>
> Tested-by: Nicholas <arealityfarbetween@googlemail.com>

Acked-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>

Going for a dig in google turns this up against multiple controllers,
multiple kernels, multiple distros..


> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 81a94a3..f6b0892 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4156,6 +4156,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "ST3320[68]13AS",	"SD1[5-9]",	ATA_HORKAGE_NONCQ |
>  						ATA_HORKAGE_FIRMWARE_WARN },
>  
> +	/* Seagate Momentus SpinPoint M8 seem to have FPMDA_AA issues */
> +	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
> +
>  	/* Blacklist entries taken from Silicon Image 3124/3132
>  	   Windows driver .inf file - also several Linux problem reports */
>  	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
