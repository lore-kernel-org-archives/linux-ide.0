From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/11] ahci: Move generic code into libahci
Date: Wed, 03 Mar 2010 13:43:49 -0500
Message-ID: <4B8EADE5.5010109@pobox.com>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru> <20100303171747.GI12362@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60687 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0CCStv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Mar 2010 13:49:51 -0500
In-Reply-To: <20100303171747.GI12362@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/03/2010 12:17 PM, Anton Vorontsov wrote:
> This patch should contain no functional changes, just moves code
> around.

Excellent!  I like how this patch series is split up.  You've precisely 
what you needed to do here -- major code movement should avoid any 
changes outside the minimum required to build this patch.

Others should follow your example :)


> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> new file mode 100644
> index 0000000..3ec32ee
> --- /dev/null
> +++ b/drivers/ata/libahci.c
> @@ -0,0 +1,2059 @@
> +/*
> + *  ahci.c - AHCI SATA low-level routines

this should reflect new filename



> diff --git a/drivers/ata/libahci.h b/drivers/ata/libahci.h
> new file mode 100644
> index 0000000..60bce4e
> --- /dev/null
> +++ b/drivers/ata/libahci.h
> @@ -0,0 +1,330 @@
> +/*
> + *  ahci.c - AHCI SATA low-level routines

Ditto.

Note that my preference for header file name would be ahci.h rather than 
libahci.h, to reflect that it includes generic AHCI hardware definitions 
as well as libahci structures and function prototypes.

