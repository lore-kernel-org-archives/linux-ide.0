From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise 579 with current(?) libata in libata-dev-2.6 queue
Date: Sat, 05 Feb 2005 21:54:48 -0500
Message-ID: <420586F8.1010207@pobox.com>
References: <m3sm8ljkco.fsf@kalahari.s2.org> <417023B6.9070900@pobox.com> <m36557k0a4.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6059 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S263471AbVBFCzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 21:55:04 -0500
In-Reply-To: <m36557k0a4.fsf@kalahari.s2.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jarno Paananen <jpaana@s2.org>
Cc: linux-ide@vger.kernel.org

Jarno Paananen wrote:
> --- sata_promise.c.old	2004-10-19 03:38:55.000000000 +0300
> +++ sata_promise.c	2004-10-19 03:32:33.000000000 +0300
> @@ -158,6 +158,8 @@
>  	  board_2037x },
>  	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_2037x },
> +	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_2037x },


applied

