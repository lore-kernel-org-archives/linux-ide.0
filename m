From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_via broken in 2.6.19rc4
Date: Wed, 08 Nov 2006 08:32:35 -0500
Message-ID: <4551DC73.9070506@pobox.com>
References: <45510A58.1040300@cdi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37509 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965740AbWKHNch (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:32:37 -0500
In-Reply-To: <45510A58.1040300@cdi.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Devera <devik@cdi.cz>
Cc: linux-ide@vger.kernel.org

Martin Devera wrote:
> Hi,
> 
> it seems there is typo in sata_via.c (see ATA_PFLAG_LOADING constant 
> usage):
> 
> static int vt6420_prereset(struct ata_port *ap)
> {
>         struct ata_eh_context *ehc = &ap->eh_context;
>         unsigned long timeout = jiffies + (HZ * 5);
>         u32 sstatus, scontrol;
>         int online;
> 
>         /* don't do any SCR stuff if we're not loading */
>         if (!ATA_PFLAG_LOADING)
>                 goto skip_scr;

thanks for spotting this, fix pushed


