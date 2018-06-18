From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci: Fix possible Spectre-v1 pmp indexing in
 ahci_led_store()
Date: Mon, 18 Jun 2018 11:04:56 -0700
Message-ID: <20180618180456.GB1351649@devbig577.frc2.facebook.com>
References: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1528453593-225313-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 08, 2018 at 06:26:33PM +0800, John Garry wrote:
> Currently smatch warns of possible Spectre-V1 issue in ahci_led_store():
> drivers/ata/libahci.c:1150 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)
> 
> Userspace controls @pmp from following callchain:
> em_message->store()
> ->ata_scsi_em_message_store()
> -->ap->ops->em_store()
> --->ahci_led_store()
> 
> After the mask+shift @pmp is effectively an 8b value, which is used to
> index into an array of length 8, so sanitize the array index.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
