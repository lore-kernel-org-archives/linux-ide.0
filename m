From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BUG null dereference in drivers/ata/sata_mv.c
Date: Thu, 17 Dec 2009 01:25:10 -0500
Message-ID: <4B29CEC6.5010705@pobox.com>
References: <200912142051.34029.strakh@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:33983 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761806AbZLQGZO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 01:25:14 -0500
In-Reply-To: <200912142051.34029.strakh@ispras.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Strakh <strakh@ispras.ru>
Cc: Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On 12/14/2009 03:51 PM, Alexander Strakh wrote:
> 	KERNEL_VERSION: 2.6.32
> 	SUBJECT: null dereference in function mv_unexpected_intr
> 	DESCRIBE:
> 	In ./drivers/ata/sata_mv.c in function mv_port_intr
>
> 1. If ap == NULL in line 2778, then we goto line 2779.
> 2. In line 2779 function mv_unexpected_intr(ap, 0) is called.
> 3. In line 2538 null dereference: "ap->link.eh_info"
>
> 2773 static void mv_port_intr(struct ata_port *ap, u32 port_cause)
> 2774 {
> ...
> 2778         if (!ap || (ap->flags&  ATA_FLAG_DISABLED)) {
> 2779                 mv_unexpected_intr(ap, 0);
> 2780                 return;

pointless null test removed...


