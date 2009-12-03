From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: use pci_dev->revision
Date: Thu, 03 Dec 2009 02:36:52 -0500
Message-ID: <4B176A94.8090000@pobox.com>
References: <200911242154.49540.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:47139 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbZLCHgr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:36:47 -0500
Received: by ywh12 with SMTP id 12so1181165ywh.21
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:36:53 -0800 (PST)
In-Reply-To: <200911242154.49540.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 11/24/2009 01:54 PM, Sergei Shtylyov wrote:
> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID, so
> they weren't converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65
> (PCI: Change all drivers to use pci_device->revision).
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   drivers/ata/pata_cmd64x.c  |    9 ++-------
>   drivers/ata/pata_hpt366.c  |    8 ++------
>   drivers/ata/pata_hpt37x.c  |   21 +++++++++------------
>   drivers/ata/pata_hpt3x2n.c |   15 +++++----------
>   drivers/ata/pata_sil680.c  |    6 ++----
>   5 files changed, 20 insertions(+), 39 deletions(-)

applied, thanks for doing this


