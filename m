From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: Boot failure due to some interaction between per-port MSI-X and
 Intel RST
Date: Tue, 5 Sep 2017 08:46:15 -0700
Message-ID: <CAPcyv4jwna0-6MncAtoqCJuhwdJLyOrvJf4z-bqELJPonUjOGQ@mail.gmail.com>
References: <fc6edbd0-d720-4112-550c-fbed78ee8b32@gmail.com> <20170904061634.GA16590@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32973 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIEPqQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2017 11:46:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id x184so27111148oia.0
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2017 08:46:16 -0700 (PDT)
In-Reply-To: <20170904061634.GA16590@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: John Loy <john.robert.loy@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, Sep 3, 2017 at 11:16 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sun, Sep 03, 2017 at 06:42:35PM -0700, John Loy wrote:
>> I have a system that stopped booting Linux between kernel versions 4.4.9 and
>> 4.5.3.  It has a SATA + NVMe accelerated volume that I use with Windows and
>> a separate SATA drive with my Linux installation.  I'm not expecting the
>> remapped NVMe thing to be accessible, just the Linux disk, but none of the
>> drives are accessible.
>>
>> Bisecting the changes turned up d684a90 as the first failing change. Passing
>> pci=nomsi also allows the system to boot newer kernels.  Just to be sure, I
>> built a recent kernel (4.12.9) with the PCI_IRQ_MSIX flag removed from the
>> per-port call to pci_alloc_irq_vectors in ahci_init_msi.  This also allowed
>> the system to boot normally.
>>
>> I'm totally out of my depth though so I'd really appreciate it if anyone has
>> some ideas on how to proceed with a proper fix.
>
> Something like the patch below should work.  Maybe Intel can provide
> an explanation on why their chipset is so fucked up that we can add
> as a comment.
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5a5fd0b404eb..b8c8ecc854c4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1470,6 +1470,7 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
>
>         dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
>         dev_warn(&pdev->dev, "Switch your BIOS from RAID to AHCI mode to use them.\n");
> +       hpriv->flags |= AHCI_HFLAG_NO_MSI;
>  }
>
>  static int ahci_get_irq_vector(struct ata_host *host, int port)

Yes, this patch looks good to me.  As I said here [1]:

+               /*
+                * Don't rely on the msi-x capability in the remap case,
+                * share the legacy interrupt across ahci and remapped
+                * devices.
+                */

...we need to use pci-intx interrupts for both devices.

[1]: http://lists.infradead.org/pipermail/linux-nvme/2016-October/006801.html
