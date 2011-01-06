From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 2/3] ahci_pltfm: switch to module device table
 matching
Date: Thu, 6 Jan 2011 13:53:22 +0300
Message-ID: <20110106105322.GA10102@oksana.dev.rtsoft.ru>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
 <1294206187-11487-3-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36710 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1AFKx1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 05:53:27 -0500
Received: by ewy5 with SMTP id 5so7275777ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 02:53:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294206187-11487-3-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Jan 05, 2011 at 01:43:06PM +0800, mkl0301@gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> Switch the driver to use module device table matching mechanism to add SoC-specific parts to the generic driver.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>
> ---
>  drivers/ata/ahci_pltfm.c |   14 +++++++++++++-
>  drivers/ata/ahci_pltfm.h |   17 +++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/ahci_pltfm.h
> 
[..]
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _DRIVERS_SATA_AHCI_PLTFM_H
> +#define _DRIVERS_SATA_AHCI_PLTFM_H
> +
> +#endif /* _DRIVERS_SATA_AHCI_PLTFM_H */
> +
> --

No need for this empty line at the end of the file.

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
