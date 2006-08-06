From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI PATCH
Date: Sun, 06 Aug 2006 21:34:22 +0900
Message-ID: <44D5E1CE.6040208@gmail.com>
References: <44D5C878.5070800@ite.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:1801 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWHFMee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Aug 2006 08:34:34 -0400
Received: by py-out-1112.google.com with SMTP id z74so798985pyg
        for <linux-ide@vger.kernel.org>; Sun, 06 Aug 2006 05:34:33 -0700 (PDT)
In-Reply-To: <44D5C878.5070800@ite.inf.tu-dresden.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steffen Koehler <stk@mail.inf.tu-dresden.de>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, stk@ite.inf.tu-dresden.de

Steffen Koehler wrote:
> static int ahci_hardreset(struct ata_port *ap, int verbose,
>                           unsigned int *class)
> {
>         int rc;
> 
>         DPRINTK("ENTER\n");
> 
>         ahci_stop_engine(ap);
>         rc = sata_std_hardreset(ap, verbose, class);
>         ahci_start_engine(ap);
> 
> -       if (rc == 0)
> +       if ((rc == 0) && sata_dev_present(ap))

Acked-by: Tejun Heo <htejun@gmail.com>

The corresponding fix is already in libata-dev#upstream and Linus's 
tree, so this fix is just for -stable.

Thanks.

-- 
tejun
