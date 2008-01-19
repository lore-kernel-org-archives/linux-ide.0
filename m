From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pdc2026x: remove surplus initialiser
Date: Sat, 19 Jan 2008 19:54:03 +0300
Message-ID: <47922B2B.5010807@ru.mvista.com>
References: <20080119155525.0d361552@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24770 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754370AbYASQxM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jan 2008 11:53:12 -0500
In-Reply-To: <20080119155525.0d361552@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> Signed-off-by: Alan Cox <alan@redhat.com>

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c
> --- linux.vanilla-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 14:47:56.000000000 +0000
> +++ linux-2.6.24-rc8-mm1/drivers/ide/pci/pdc202xx_old.c	2008-01-19 15:00:08.000000000 +0000
> @@ -138,7 +138,7 @@
>  static u8 __devinit pdc2026x_old_cable_detect(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev = to_pci_dev(hwif->dev);
> -	u16 CIS = 0, mask = (hwif->channel) ? (1<<11) : (1<<10);
> +	u16 CIS, mask = (hwif->channel) ? (1<<11) : (1<<10);
>  
>  	pci_read_config_word(dev, 0x50, &CIS);

    Since we ignore the result of this function, if it fails CIS may be left 
uninitialized if the function fails. So, the initializer is not as useless as 
it seems (and there's a lot more of such cases in drivers/ide/pci/ :-)...

MBR, Sergei
