From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_via VT6421 vendor update
Date: Sun, 11 Dec 2005 23:34:18 -0500
Message-ID: <439CFDCA.2020902@rtr.ca>
References: <439CF781.3080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:58545 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751092AbVLLEeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Dec 2005 23:34:19 -0500
In-Reply-To: <439CF781.3080400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> 
> +	switch (adev->dma_mode & 0x07) {
> +		case 0:
> +			cfg_byte = 0xee;
> +			break;	
> +		case 1:
> +			cfg_byte = 0xe8;
> +			break;	
> +		case 2:
> +			cfg_byte = 0xe6;
> +			break;	
> +		case 3:
> +			cfg_byte = 0xe4;
> +			break;	
> +		case 4:
> +			cfg_byte = 0xe2;
> +			break;	
> +		case 5:
> +			cfg_byte = 0xe1;
> +			break;	
> +		case 6:
> +			cfg_byte = 0xe0;
> +			break;	
> +		default:
> +			cfg_byte = 0xe0;
> +	}

Mmm.. replace all that with this (?):

	u8 cfg_bytes[8] = {0xee, 0xe8, 0xe6, 0xe4, 0xe2, 0xe1, 0xe0, 0xe0};
	cfg_byte = cfg_bytes[adev->dma_mode & 7];

-ml
