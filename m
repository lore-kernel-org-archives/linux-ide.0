From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: use ata_pci_sff_activate_host()
 instead of ata_host_activate()
Date: Fri, 14 May 2010 22:07:42 -0400
Message-ID: <4BEE01EE.8040808@garzik.org>
References: <4BED1C82.10102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:36679 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0EOCHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 22:07:44 -0400
Received: by ywh36 with SMTP id 36so1581636ywh.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 19:07:43 -0700 (PDT)
In-Reply-To: <4BED1C82.10102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Robert Hancock <hancockrwd@gmail.com>

On 05/14/2010 05:48 AM, Tejun Heo wrote:
> sata_nv was incorrectly using ata_host_activate() instead of
> ata_pci_sff_activate_host() leading to IRQ assignment failure in
> legacy mode.  Fix it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Robert Hancock<hancockr@shaw.ca>
> Cc: stable@kernel.org
> ---
>   drivers/ata/sata_nv.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

applied #upstream


