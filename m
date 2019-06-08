From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
Date: Sat, 8 Jun 2019 12:12:52 +0300
Message-ID: <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
 <yq1wohxib7t.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yq1wohxib7t.fsf@oracle.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

On 07.06.2019 19:58, Martin K. Petersen wrote:
> 
> Konstantin,
> 
>> +			if (dev->horkage & ATA_HORKAGE_NOTRIM)
>> +				trim_status = "backlisted";
> 
> blacklisted

Oops. My bad.

> 
>> +			else
>> +				trim_status = "supported";
>> +
>> +			if (!ata_fpdma_dsm_supported(dev))
>> +				trim_queued = "no";
>> +			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
>> +				trim_queued = "backlisted";
> 
> ditto
> 
>> +			else
>> +				trim_queued = "yes";
> 
> Why is trim_status "supported" and trim_queued/trim_zero "yes"?

Hmm. This seems properties of trim, not independent features.

> 
>> +
>> +			if (!ata_id_has_zero_after_trim(id))
>> +				trim_zero = "no";
>> +			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
>> +				trim_zero = "yes";
>> +			else
>> +				trim_zero = "maybe";
>> +
>> +			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
>> +				     trim_status, trim_queued, trim_zero);
>> +		}
>> +
> 
> Otherwise no particular objections. We were trying to limit noise during
> boot which is why this information originally went to sysfs instead of
> being printed during probe.
> 

On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019 at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
 >
 > Do we really need to spam dmesg with even more ATA crap?  What about
 > a sysfs file that can be read on demand instead?
 >

Makes sense.

Trim state is exposed for ata_device: /sys/class/ata_device/devX.Y/trim
but there is no link from scsi device to ata device so they hard to match.

I'll think about it.
