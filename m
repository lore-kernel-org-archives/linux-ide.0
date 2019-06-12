From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] libata: Extend quirks for the ST1000LM024 drives with
 NOLPM quirk
Date: Wed, 12 Jun 2019 07:33:00 +0200
Message-ID: <be8260f7-cb3c-36b1-22d7-edc6b2657512@redhat.com>
References: <20190611143259.28647-1-hdegoede@redhat.com>
 <yq1d0jjeaj6.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <yq1d0jjeaj6.fsf@oracle.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 12-06-19 05:40, Martin K. Petersen wrote:
> 
> Hans,
> 
>> -	/* drives which fail FPDMA_AA activation (some may freeze afterwards) */
>> -	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
>> -	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA },
>> +	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
>> +	   the ST disks also have LPM issues */
>> +	{ "ST1000LM024 HN-M101MBB", "2AR10001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
>> +						ATA_HORKAGE_NOLPM, },
>> +	{ "ST1000LM024 HN-M101MBB", "2BA30001",	ATA_HORKAGE_BROKEN_FPDMA_AA |
>> +						ATA_HORKAGE_NOLPM, },
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> Slightly orthogonal, and I know it's been discussed before, but I think
> it would be worth considering just blacklisting all firmware revs for
> this model.
> 
> There were several firmware releases for these drives. And while it's
> conceivable that post-2BA30001 may fix the issues, I think it's safe to
> say that all the intermediate releases between the two we have are
> equally broken.

Dropping the firmware version sounds reasonable to me. Do you want me to
send a follow-up patch doing this?

Regards,

Hans
