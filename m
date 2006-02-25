From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] sata_sil: clean up and add errata/workaround documentation
Date: Sat, 25 Feb 2006 16:36:52 +0900
Message-ID: <44000914.4050207@gmail.com>
References: <11408431501105-git-send-email-htejun@gmail.com> <4400074F.3020005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:46553 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbWBYHfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 02:35:47 -0500
Received: by zproxy.gmail.com with SMTP id 14so547407nzn
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 23:35:46 -0800 (PST)
In-Reply-To: <4400074F.3020005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> This patch collects into one place/update errata documentattion and
>> adds description of 3114 R_ERR on DMA activate FIS errata.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/sata_sil.c |   97 
>> ++++++++++++++++++++++++++++++++++++-----------
>>  1 files changed, 75 insertions(+), 22 deletions(-)
>>
>> 6b1cc9dff33ae20157946ae8b06f1a11079b4af6
>> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
>> index 9face3c..75784cd 100644
>> --- a/drivers/scsi/sata_sil.c
>> +++ b/drivers/scsi/sata_sil.c
>> @@ -30,8 +30,79 @@
>>   *  Documentation for SiI 3112:
>>   *  
>> http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
>>   *
>> + *  Documentation for SiI 3114:
>> + *  http://gkernel.sourceforge.net/specs/sii/sii-0680a-v1.31.pdf.bz2
>> + *
>>   *  Other errata and documentation available under NDA.
> 
> 
> I'll apply patches 1-2.
> 
> For this patch #3, two comments:
> 
> * the above URL points to CMD680 docs, not 3114

Oops. :-p

> 
> * I'm unconvinced that long exposition should be in the .c file.  I 
> think its far better to put it into Documentation/DocBook/libata.tmpl. I 
> have some long term plans to add more hardware details to the docbook 
> docs, infact.

Hmmm... I don't know. You know I'm not a big fan of docbook docs mainly 
because of accessibility. It's your call. Anyways, it would be nice to 
keep up-to-date information regarding libata hardware quirks in some 
easily-accessible place (wiki?).

-- 
tejun
