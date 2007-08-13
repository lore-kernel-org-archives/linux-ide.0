From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [428/2many] MAINTAINERS - SERIAL ATA (SATA) SUBSYSTEM:
Date: Mon, 13 Aug 2007 12:02:21 +0100
Message-ID: <20070813120221.2e70e32f@the-village.bc.nu>
References: <46bffbb6.4FinvGMu+SlIxG24%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47643 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S938682AbXHMKzh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 06:55:37 -0400
In-Reply-To: <46bffbb6.4FinvGMu+SlIxG24%joe@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, akpm@linux-foundation.org

> @@ -4077,6 +4077,7 @@ M:	jgarzik@pobox.com
>  L:	linux-ide@vger.kernel.org
>  T:	git kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>  S:	Supported
> +F:	drivers/ata/sata_*

NAK
	sata_inic is Tejun

and various others are also different
