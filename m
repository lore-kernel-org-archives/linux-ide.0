From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 04/12] libata-hp-prep: update ata_scsi_find_dev() and
 friends
Date: Mon, 29 May 2006 18:09:51 +0900
Message-ID: <447ABA5F.2070608@gmail.com>
References: <11488839582103-git-send-email-htejun@gmail.com> <1148892037.3466.15.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:57965 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWE2JJ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:09:59 -0400
Received: by nz-out-0102.google.com with SMTP id s18so498120nze
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 02:09:58 -0700 (PDT)
In-Reply-To: <1148892037.3466.15.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-ide@vger.kernel.org

>> +static struct ata_device * ata_find_dev(struct ata_port *ap, int id)
>> +{
>> +	if (likely(id == 0 || (id == 1 && ap->flags & ATA_FLAG_SLAVE_POSS)))
>> +		return &ap->device[id];
>> +	return NULL;
>> +}
>> +
> 
>>From my understanding, the definition of function ata_find_dev() should
> be in libata-core.c instead of libata-scsi.c. Does it make sense to you?

Could be.  However, as it's currently used only inside libata-scsi.c, I
think we can leave it as static function for the time being.

-- 
tejun
