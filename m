From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH]add the IDE device ID for ATI SB700
Date: Wed, 16 May 2007 00:37:03 +0200
Message-ID: <200705160037.03542.bzolnier@gmail.com>
References: <00c901c79638$bad8e4e0$6400a8c0@henry>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:35755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760639AbXEPAqd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2836uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:32 -0700 (PDT)
In-Reply-To: <00c901c79638$bad8e4e0$6400a8c0@henry>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gmail_ati <henry.su.ati@gmail.com>
Cc: henry su <henry.su@amd.com>, linux-ide@vger.kernel.org


Hi,

On Monday 14 May 2007, gmail_ati wrote:
> From: henry.su.ati@gmail.com
> add the IDE device ids to atiixp_pci_tbl struct in atiixp.c for ATI SB700.
> Signed-off-by: Luugi Marsan <luugi.marsan@amd.com>

This patch is somehow missing the chunk adding PCI_DEVICE_ID_ATI_IXP700_IDE
define to <linux/pci_ids.h> and thus makes atiixp.c fail to compile.

Please resend the complete patch.

PS your mailer seems to encode patches in some strange way (whitespaces are
mangled and saved email contained MIME encoded text instead of plain-text) so
I had to apply this change by hand.  Not really a problem for this particular
patch ;) but definitively something needing fixing.

Thanks,
Bart

> -----------------------------------------------------
> diff -Nur linux-2.6.21.1.org/drivers/ide/pci/atiixp.c linux-2.6.21.1/drivers/ide/pci/atiixp.c
> --- linux-2.6.21.1.org/drivers/ide/pci/atiixp.c 2007-05-13 04:47:25.000000000 +0800
> +++ linux-2.6.21.1/drivers/ide/pci/atiixp.c 2007-05-13 05:14:08.000000000 +0800
> @@ -353,6 +353,7 @@
>   { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>   { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>   { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
> + { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
>   { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
