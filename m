From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 0063/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 15:32:57 +0300
Message-ID: <a4bf3836-1ffa-9f83-6e8f-998c99d5b507@cogentembedded.com>
References: <20160802103759.17958-1-baolex.ni@intel.com>
 <5391e340-1285-574d-1979-a19571341eb5@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5391e340-1285-574d-1979-a19571341eb5@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>, b.zolnierkie@samsung.com, tj@kernel.org, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, travis@sgi.com
List-Id: linux-ide@vger.kernel.org

Hello.

On 8/2/2016 2:30 PM, Sergei Shtylyov wrote:

>> I find that the developers often just specified the numeric value
>> when calling a macro which is defined with a parameter for access permission.
>> As we know, these numeric value for access permission have had the
>> corresponding macro,
>> and that using macro can improve the robustness and readability of the code,
>> thus, I suggest replacing the numeric parameter with the macro.
>>
>> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
>> Signed-off-by: Baole Ni <baolex.ni@intel.com>
>> ---
>>  drivers/ata/pata_legacy.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
>> index bce2a8c..1dc0beb 100644
>> --- a/drivers/ata/pata_legacy.c
>> +++ b/drivers/ata/pata_legacy.c
>> @@ -76,7 +76,7 @@
>>  #define NR_HOST 6
>>
>>  static int all;
>> -module_param(all, int, 0444);
>> +module_param(all, int, S_IRUSR | S_IRGRP | S_IROTH);
>
>    There's S_IRUGO for this case, no?

    Sending 1285 patches with the same subject also was a bad idea. You need a 
subsystem/driver prefix in order to somehow differ them.

MBR, Sergei
