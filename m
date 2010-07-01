From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci_platform: Remove unneeded ahci_driver.probe assignment
Date: Thu, 01 Jul 2010 15:30:12 -0400
Message-ID: <4C2CECC4.5030400@pobox.com>
References: <20100625122053.GA14391@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55684 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab0GATaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 15:30:17 -0400
Received: by gwb15 with SMTP id 15so1249656gwb.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Jul 2010 12:30:16 -0700 (PDT)
In-Reply-To: <20100625122053.GA14391@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>, linux-ide@vger.kernel.org

On 06/25/2010 08:20 AM, Anton Vorontsov wrote:
> The driver is using platform_driver_probe() during initialization,
> so ahci_driver.probe hook is never used.
>
> But it causes the following (harmless, luckily) section mismatch:
>
>    WARNING: vmlinux.o(.data+0x2fb20): Section mismatch in reference
>    from the variable ahci_driver to the function .init.text:ahci_probe()
>
> This patch removes the ahci_driver.probe assignment, thus fixes
> the warning.
>
> p.s. Note that there's another patch[1] from Rene Bolldorf that
> tried to solve the same issue by __refdata annotation. __refdata
> says that this reference is actually OK, but in fact it is not OK,
> because dereferencing .probe() will cause problems. So the proper
> fix is to remove the assignment.
>
> [1] http://kerneltrap.org/mailarchive/linux-kernel/2010/3/18/4549547
>
> Signed-off-by: Anton Vorontsov<avorontsov@mvista.com>
> ---
>   drivers/ata/ahci_platform.c |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)

applied


