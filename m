From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/12] libata-hp-prep: store attached SCSI device
Date: Mon, 29 May 2006 18:14:01 +0900
Message-ID: <447ABB59.4000209@gmail.com>
References: <11488839582227-git-send-email-htejun@gmail.com> <1148892344.3466.19.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:13109 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWE2JOI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 05:14:08 -0400
Received: by wr-out-0506.google.com with SMTP id i7so838256wra
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 02:14:07 -0700 (PDT)
In-Reply-To: <1148892344.3466.19.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Mon, 2006-05-29 at 15:25 +0900, Tejun Heo wrote:
>> @@ -2743,16 +2743,22 @@ void ata_scsi_simulate(struct ata_device
>>  
>>  void ata_scsi_scan_host(struct ata_port *ap)
>>  {
>> -	struct ata_device *dev;
>>  	unsigned int i;
>>  
>>  	if (ap->flags & ATA_FLAG_DISABLED)
>>  		return;
>>  
>>  	for (i = 0; i < ATA_MAX_DEVICES; i++) {
>> -		dev = &ap->device[i];
>> +		struct ata_device *dev = &ap->device[i];
>> +		struct scsi_device *sdev;
>> +
>> +		if (!ata_dev_enabled(dev) || dev->sdev)
>> +			continue;
>>  
>> -		if (ata_dev_enabled(dev))
>> -			scsi_scan_target(&ap->host->shost_gendev, 0, i, 0, 0);
>> +		sdev = __scsi_add_device(ap->host, 0, i, 0, NULL);
> Is it better to use macro scsi_add_device() than invoking
> __scsi_add_device() directly here? I know this is only a trivial change.

Again, could be.  The change is mostly cosmetic.  I like the current
form because it explicitly signifies that libata doesn't hold reference
to sdev.

-- 
tejun
