From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_hpt3x2n: calculate average f_CNT
Date: Fri, 07 Jan 2011 22:34:30 -0500
Message-ID: <4D27DB46.4020200@pobox.com>
References: <201012282254.54161.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab1AHDef (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 22:34:35 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so7391603vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 19:34:35 -0800 (PST)
In-Reply-To: <201012282254.54161.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 12/28/2010 02:54 PM, Sergei Shtylyov wrote:
> Allow hpt3x2n_pci_clock() to calculate the average f_CNT register value iff
> HighPoint BIOS hasn't saved one, just like the 'pata_hpt37x' driver (reading
> the full 16-bit register, unlike what that driver does), so that this driver
> would work correctly on e.g. non-x86 machine with 66 MHz PCI.
>
> I'm not sure why Alan has only done this in one driver and not the other...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree plus the two patches I posted
> before:
>
> http://marc.info/?l=linux-ide&m=129356208121192
> http://marc.info/?l=linux-ide&m=129330632207779
>
>   drivers/ata/pata_hpt3x2n.c |   17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

applied


