From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [RFC 3/3] ata: sata_mv, avoid trigerrable BUG_ON
Date: Fri, 14 Jun 2019 10:33:01 +0200
Message-ID: <75a4a778-6862-a0d0-1033-cd5fe57d6dbf@suse.cz>
References: <20190614071140.6233-1-jslaby@suse.cz>
 <20190614071140.6233-3-jslaby@suse.cz>
 <0e9f8a3b-65b9-4d87-21f1-684f7e44b166@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e9f8a3b-65b9-4d87-21f1-684f7e44b166@cogentembedded.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 14. 06. 19, 10:24, Sergei Shtylyov wrote:
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -2098,12 +2098,10 @@ static int mv_qc_prep(struct ata_queued_cmd *qc)
>>            * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
>>            * of which are defined/used by Linux.  If we get here, this
>>            * driver needs work.
>> -         *
>> -         * FIXME: modify libata to give qc_prep a return value and
>> -         * return error here.
>>            */
>> -        BUG_ON(tf->command);
>> -        break;
>> +        ata_port_err(ap, "%s: unsupported command: %d\n", __func__,
>> +                tf->command);
> 
>    I'd use "%x" here instead of "%d".

Hi, that makes sense. Fixed locally to %.2x as the commands are defined
as such. Waiting for more comments before [v2] :).

thanks,
-- 
js
suse labs
