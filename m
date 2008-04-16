From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] scc_pata: add ->{in,out}put_data methods
Date: Wed, 16 Apr 2008 21:35:38 +0400
Message-ID: <480638EA.2000708@ru.mvista.com>
References: <200803302141.06106.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763689AbYDPRg2@vger.kernel.org>
In-Reply-To: <200803302141.06106.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> There should be no functional changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/pci/scc_pata.c
> ===================================================================
> --- a/drivers/ide/pci/scc_pata.c
> +++ b/drivers/ide/pci/scc_pata.c
> @@ -574,6 +574,36 @@ static int __devinit init_setup_scc(stru
>  	return ide_setup_pci_device(dev, d);
>  }

    This patch in the pata-2.6 series doesn't apply anymore after the patch 
getting rid of ide_setup_pci_device() call was merged.

WBR, Sergei
