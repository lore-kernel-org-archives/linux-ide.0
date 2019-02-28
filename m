From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: libahci: Only warn for AHCI_HFLAG_MULTI_MSI set when
 genuine custom irq handler implemented
Date: Thu, 28 Feb 2019 14:08:12 -0700
Message-ID: <639bded2-54a5-882d-b782-b7b59f8dbc93@kernel.dk>
References: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: linuxarm@huawei.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 2/18/19 10:43 AM, John Garry wrote:
> For an AHCI controller with AHCI_HFLAG_MULTI_MSI flag set, we may get the
> following log, regardless of whether a custom irq handler was implemented
> or not:
> 
> [   14.700238] ahci 0000:74:03.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented
> 
> This is because we can set hpriv->irq_handler to
> ahci_single_level_irq_intr() if not already set, in
> ahci_init_one()->ahci_pci_save_initial_config()->ahci_save_initial_config().
> 
> Stop having this warn being misleading by adding a check for
> hpriv->irq_handler != ahci_single_level_irq_intr.

Applied, thanks.

-- 
Jens Axboe
