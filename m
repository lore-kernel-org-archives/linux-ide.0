From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH V2] ata: pata: Convert pr_*(DRV_NAME ...) to pr_fmt/pr_<level>
Date: Mon, 14 Mar 2011 02:56:53 -0400
Message-ID: <4D7DBC35.90509@pobox.com>
References: <201101310359.p0V3x41L010660@hera.kernel.org> <1296448498.4131.22.camel@Joe-Laptop>  <4D46DD95.3000006@ru.mvista.com> <1296491964.4131.86.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46127 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1CNG4z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 02:56:55 -0400
In-Reply-To: <1296491964.4131.86.camel@Joe-Laptop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/31/2011 11:39 AM, Joe Perches wrote:
> Commit 40d69ba029c8d5de51aaeb5358999266c482d00a
> ("pata_hpt{37x|3x2n}: use pr_*(DRV_NAME ...) instead of printk(KERN_* ...)")
> used pr_<level>.
>
> Add #define pr_fmt and remove DRV_NAME.
> Increment driver version numbers.
>
> Signed-off-by: Joe Perches<joe@perches.com>
> ---
> On Mon, 2011-01-31 at 19:04 +0300, Sergei Shtylyov wrote:
>>      Could you also increment the driver versions?
>
> At some point, the driver version is not very useful.
> You might consider removing them altogether.
>
> cheers, Joe
>
>   drivers/ata/pata_hpt366.c  |    7 ++++---
>   drivers/ata/pata_hpt37x.c  |   23 ++++++++++++-----------
>   drivers/ata/pata_hpt3x2n.c |   13 +++++++------
>   3 files changed, 23 insertions(+), 20 deletions(-)

applied


