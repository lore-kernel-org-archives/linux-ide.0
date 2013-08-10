From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH v3 2/3] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri, 09 Aug 2013 19:10:33 -0700
Message-ID: <5205A119.9030608@gmail.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-3-git-send-email-marc.ceeeee@gmail.com> <20130809140506.GB20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:45711 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031757Ab3HJCKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 22:10:39 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so7788701oag.1
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 19:10:39 -0700 (PDT)
In-Reply-To: <20130809140506.GB20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com

Hello,

On 8/9/2013 7:05 AM, Tejun Heo wrote:
> On Thu, Aug 08, 2013 at 09:49:11PM -0700, Marc C wrote:
>> @@ -2131,6 +2131,7 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>>  	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
>>  	unsigned int err_mask;
>>  	char *aa_desc = "";
>> +	u8 sata_setting[ATA_SECT_SIZE];
> 
> Nope.  Please don't do this.  Can't you use ap->sector_buf?
> 
Yup, I should be able to use that instead.

Thanks,
Marc
