From: Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH] ata: fix a race condition when internal cmd time out
Date: Sat, 16 Feb 2019 16:43:49 +0800
Message-ID: <98d269d2-da80-fdd4-13c3-84e2868c05d3@huawei.com>
References: <20190216034257.30226-1-yanaijie@huawei.com>
 <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63bc665b-4f5f-0845-9767-825925ead80a@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-ide@vger.kernel.org, tj@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi, Sergei

Thanks for the review.

On 2019/2/16 15:45, Sergei Shtylyov wrote:
> Hello!
> 
> On 16.02.2019 6:42, Jason Yan wrote:
> 
>> For internal cmds, we will unmap DMA memory associated with the cmd
>> before we abort the cmd. If DMA transfering data before the aborting,
> 
>     Transferring.
> 
>> bus error will occured.
> 
>     Occur.
> 
>> ata_exec_internal_sg
>>    ->ata_port_freeze if timeout
>>      ->ata_qc_complete
>>        ->ata_sg_clean
>>                                        dma transfering data = bus error
>>    ->ap->ops->post_internal_cmd
>>      ->sas_ata_post_internal
>>        ->sas_ata_internal_abort
>>          ->abort the cmd
>>
>> Fix this by move post_internal_cmd() before unmapping the DMA memory
> 
>     Moving.
> 
>> when time out. Notice that we have to set ATA_QCFLAG_FAILED flag before
>> calling post_internal_cmd() so that the aborting will work.
>>
>> Reported-by: luojian <luojian5@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> [...]
> 
> MBR, Sergei
> 
> 
