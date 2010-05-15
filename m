From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/23] pata_sch: use ata_pci_sff_init_one()
Date: Fri, 14 May 2010 22:39:14 -0400
Message-ID: <4BEE0952.1010809@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:42319 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab0EOCjR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 22:39:17 -0400
Received: by ywh36 with SMTP id 36so1588682ywh.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 19:39:16 -0700 (PDT)
In-Reply-To: <1273520507-32459-2-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> pata_sch is standard SFF.  No reason to open code init.  Use
> ata_pci_sff_init_one() instead.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/pata_sch.c |   12 +-----------
>   1 files changed, 1 insertions(+), 11 deletions(-)

applied 1-5


