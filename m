From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Prepare for hard drives w/ non-512 sector sizes
Date: Wed, 08 Apr 2009 14:47:43 -0400
Message-ID: <49DCF14F.1060407@garzik.org>
References: <20090408065955.GA29845@havoc.gtf.org> <20090408183243.GK20983@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57226 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585AbZDHSrr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 14:47:47 -0400
In-Reply-To: <20090408183243.GK20983@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Matthew Wilcox wrote:
> On Wed, Apr 08, 2009 at 02:59:55AM -0400, Jeff Garzik wrote:
>> I checked this into libata-dev.git#sectsize and #NEXT...  comments
>> welcome.  It's willy's patch, cut down such that it introduces no
>> major behavior changes [READ CAPACITY improves slightly].
> 
> Umm.  If you wanted me to split the patch up, why didn't you ask?

I've had trouble until recently simply getting you to post patches at 
all.  It was faster and simpler for me to do it myself.


> I really do think I should be credited as 'Author' here.  You credit me
> in the patch description, but the automated tools don't show that.

If that is your preference, that's fine.  I did it this way to avoid 
your taking the blame for anything I did, while still noting in the 
patch description you did the original work.


>> @@ -2354,10 +2355,25 @@ saving_not_supp:
>>   */
>>  static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
>>  {
>> -	u64 last_lba = args->dev->n_sectors - 1; /* LBA of the last block */
>> +	struct ata_device *dev = args->dev;
>> +	u64 last_lba = dev->n_sectors - 1; /* LBA of the last block */
>> +	u32 sector_size;
>> +	u8 log_per_phys = 1;
> 
> This was a bug I had fixed, but possibly not sent out.  It should be 0,
> not 1 (it's the power of 2, not the raw count).

Ok.

	Jeff



