From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH 2.6.32 v3] Conditional MSI support for sata_nv
Date: Wed, 12 Aug 2009 19:03:05 +0200
Message-ID: <c384c5ea0908121003x2f3eef3ejd8bc4a5aaa120793@mail.gmail.com>
References: <20090805235009.88C091007F@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f228.google.com ([209.85.220.228]:36329 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZHLRJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Aug 2009 13:09:40 -0400
In-Reply-To: <20090805235009.88C091007F@gold.linx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>, Robert Hancock <hancockrwd@gmail.com>

Hello,

On Thu, Aug 6, 2009 at 1:50 AM, Tony Vroon<tony@linx.net> wrote:
> At least the nVidia MCP55 controller quite happily supports MSI.
> +static int msi_enabled;
> + =A0 =A0 =A0 if (msi_enabled) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_NOTICE, &pdev->dev, "Us=
ing MSI\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_enable_msi(pdev);
> + =A0 =A0 =A0 }
> +

I just saw this patch, didn't check the full sources.

Shouldn't there be a matching "if (msi_enabled)
pci_disabling_msi(pdev);" somewhere else?

Regards,

Leon.
