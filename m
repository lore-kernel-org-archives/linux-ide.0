From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Date: Mon, 17 Apr 2006 23:21:42 -0400
Message-ID: <44445B46.8040304@rtr.ca>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:46755 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751394AbWDRDVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Apr 2006 23:21:41 -0400
In-Reply-To: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Ausmus <james.ausmus@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

James Ausmus wrote:
>..
> +config IDE_COMPACT_FLASH_NO_UDMA
> +       bool "Disable UDMA for Compact Flash Devices"
> +       help
> +         This turns off the UDMA capability flag bit for any IDE device
> +         that identifies as Compact Flash - This is a workaround for
> +         cheap Compact Flash -> IDE adapters that don't support UDMA
> +         transfer speeds even if the CF card does.

I dunno.  This might be better done as a module/boot option
than as a rebuild-your-kernel configuration choice.

??
