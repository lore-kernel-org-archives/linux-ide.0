From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
Date: Sun, 24 Mar 2019 11:10:02 -0600
Message-ID: <438179a3-6fd2-c277-7b00-5f1a12d8df72@kernel.dk>
References: <20190304230858.13387-1-pakki001@umn.edu>
 <66403341-fa27-4b80-ab6b-2413b6b6fb98@kernel.dk>
 <17a6d83b-c57e-b709-7443-302b84692a6d@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17a6d83b-c57e-b709-7443-302b84692a6d@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 3/24/19 10:47 AM, Aditya Pakki wrote:
> On 3/24/19 11:28 AM, Jens Axboe wrote:
>> On 3/4/19 4:08 PM, Aditya Pakki wrote:
>>> dma_async_tx_descriptor can contain a NULL variable and using
>>> it in dmaengine_submit without checking can crash the process.
>>> This patch avoids such a scenario.
>>>
>>> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>>> ---
>>>  drivers/ata/sata_dwc_460ex.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>>> index 6f142aa54f5f..44a0d7a1ef54 100644
>>> --- a/drivers/ata/sata_dwc_460ex.c
>>> +++ b/drivers/ata/sata_dwc_460ex.c
>>> @@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
>>>  					SATA_DWC_DMACR_RXCHEN);
>>>  
>>>  		/* Enable AHB DMA transfer on the specified channel */
>>> -		dmaengine_submit(desc);
>>> -		dma_async_issue_pending(hsdevp->chan);
>>> +		if (desc) {
>>> +			dmaengine_submit(desc);
>>> +			dma_async_issue_pending(hsdevp->chan);
>>> +		}
>>>  	}
>>>  }
>>
>> Hmm, if desc == NULL, is that an error condition?
>>
> Jens,
> In dmaengine_submit, the desc variable is dereferenced without a check for NULL.

Yes, that's not my point. My point is if desc is NULL, and you just work around it
by not issuing the DMA, are you just going to hang the drive/box? Should you be
erroring the IO at that point instead?

-- 
Jens Axboe
