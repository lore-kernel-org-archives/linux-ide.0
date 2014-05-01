From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] ata: SATL compliance for Inquiry Product Revision
Date: Thu, 1 May 2014 10:44:59 -0600 (MDT)
Message-ID: <alpine.LRH.2.03.1405011011010.5666@AMR>
References: <1398799524-5625-1-git-send-email-keith.busch@intel.com> <20140501151510.GF31611@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21480 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbaEAQpX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2014 12:45:23 -0400
In-Reply-To: <20140501151510.GF31611@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-ide@vger.kernel.org

On Thu, 1 May 2014, Tejun Heo wrote:
> On Tue, Apr 29, 2014 at 01:25:24PM -0600, Keith Busch wrote:
>> @@ -1993,7 +1993,10 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>>  	memcpy(rbuf, hdr, sizeof(hdr));
>>  	memcpy(&rbuf[8], "ATA     ", 8);
>>  	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
>> -	ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
>> +	if (args->id[25] == 0x2020 && args->id[26] == 0x2020)
>
> Maybe strncmp(" ") is more readable?  And can you please add some
> comment explaining what's going on?

Sounds good. Will do a v2 with that.

>> +		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
>> +	else
>> +		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV + 2, 4);
>
> So, this would change the behavior for devices which were reporting
> stuff in ATA_ID_FW_REV.  Prolly no biggiee.

Yep, though many devices do pad with spaces so it won't change for
those. I did do a sanity check on both kinds to make sure it looked right.
