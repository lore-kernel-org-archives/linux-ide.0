From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Sat, 13 May 2006 00:19:12 -0400
Message-ID: <44655E40.2090004@garzik.org>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com> <4462F667.3060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36066 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932203AbWEMETP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 00:19:15 -0400
In-Reply-To: <4462F667.3060504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Tejun Heo wrote:
> zhao, forrest wrote:
>> Hi, Tejun
>>
>> We just tested your git tree on thinkpad T43P laptop, and found that
>> after ata_piix resumed from S3, SATA disk can't be read/write anymore.
>> But according to the test result of kernel 2.6.16-rc6 on T43P, ata_piix
>> can resume from S3 successfully.
>>
>> We know that this problem may be not related to your patches, but I
>> think you know the libata development status very well, maybe you can
>> give us some clue about what happened to ata_piix between 2.6.16-rc6 and
>> your git tree.
>>
> 
> Hello, Zhao.
> 
> I haven't really followed AHCI suspend/resume stuff but AFAICT it never
> made to #upstream.  I don't know whether it was included in -rc# or not.
>  But it sounds like it did.

Hannes @ SuSE posted an AHCI suspend/resume patch that needs to go in.
Unfortunately AHCI is a high rate of churn, so it's still in my
'Pending' folder :/

	Jeff


