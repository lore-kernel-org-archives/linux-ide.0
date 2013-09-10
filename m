From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 5/9] PCI/MSI/s390: Make return values only 0/-errno when
 MSIs allocated
Date: Tue, 10 Sep 2013 16:42:17 +0400
Message-ID: <522F13A9.9020704@cogentembedded.com>
References: <20130905150259.GA30984@dhcp-26-207.brq.redhat.com> <20130905150442.GA24148@htj.dyndns.org> <20130905154041.GD30984@dhcp-26-207.brq.redhat.com> <20130905154436.GC24148@htj.dyndns.org> <20130905185440.GA13175@dhcp-26-207.brq.redhat.com> <20130905200608.GA3846@htj.dyndns.org> <CAErSpo4TU2geqzY3AYsL08KimBqtfwa4iUoFHgcFt0zMTBJkHw@mail.gmail.com> <20130906160621.GF22763@mtj.dyndns.org> <20130906233205.GF12956@google.com> <20130909152044.GA24962@dhcp-26-207.brq.redhat.com> <20130909152658.GG24962@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:54075 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3IJMmS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Sep 2013 08:42:18 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so6211506lbj.13
        for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2013 05:42:17 -0700 (PDT)
In-Reply-To: <20130909152658.GG24962@dhcp-26-207.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>

Hello.

On 09-09-2013 19:26, Alexander Gordeev wrote:

> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>   arch/s390/pci/pci.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index f17a834..c79c6e4 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -427,6 +427,8 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>   	pr_debug("%s: requesting %d MSI-X interrupts...", __func__, nvec);
>   	if (type != PCI_CAP_ID_MSIX && type != PCI_CAP_ID_MSI)
>   		return -EINVAL;
> +	if (type == PCI_CAP_ID_MSI && nvec > 1)
> +		return 1;

    This contradicts to the patch subject.

WBR, Sergei

