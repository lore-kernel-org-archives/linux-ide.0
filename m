From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata: fix a race condition when internal cmd time out
Date: Sat, 16 Feb 2019 10:45:49 +0300
Message-ID: <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
References: <20190216034257.30226-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216034257.30226-1-yanaijie@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org, tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 16.02.2019 6:42, Jason Yan wrote:

> For internal cmds, we will unmap DMA memory associated with the cmd
> before we abort the cmd. If DMA transfering data before the aborting,

    Transferring.

> bus error will occured.

    Occur.

> ata_exec_internal_sg
>    ->ata_port_freeze if timeout
>      ->ata_qc_complete
>        ->ata_sg_clean
>                                        dma transfering data = bus error
>    ->ap->ops->post_internal_cmd
>      ->sas_ata_post_internal
>        ->sas_ata_internal_abort
>          ->abort the cmd
> 
> Fix this by move post_internal_cmd() before unmapping the DMA memory

    Moving.

> when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
> calling post_internal_cmd() so that the aborting will work.
> 
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
[...]

MBR, Sergei
