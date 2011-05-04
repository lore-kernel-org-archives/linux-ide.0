From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch v2 3/3] SATA: enable non-queueable flush flag
Date: Wed, 04 May 2011 06:29:42 -0400
Message-ID: <4DC12A96.7030305@pobox.com>
References: <20110504081725.946950281@sli10-conroe.sh.intel.com> <20110504082115.488846050@sli10-conroe.sh.intel.com> <20110504085323.GB8007@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56122 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab1EDK3p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 May 2011 06:29:45 -0400
In-Reply-To: <20110504085323.GB8007@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jaxboe@fusionio.com, hch@infradead.org, djwong@us.ibm.com

On 05/04/2011 04:53 AM, Tejun Heo wrote:
> On Wed, May 04, 2011 at 04:17:28PM +0800, shaohua.li@intel.com wrote:
>> @@ -3424,7 +3424,9 @@ void ata_scsi_scan_host(struct ata_port
>>   			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
>>   						 NULL);
>>   			if (!IS_ERR(sdev)) {
>> +				struct request_queue *q = sdev->request_queue;
>>   				dev->sdev = sdev;
>> +				blk_set_queue_flush_queueable(q, false);
>>   				scsi_device_put(sdev);
>>   			} else {
>>   				dev->sdev = NULL;

> Isn't ata_scsi_dev_config() better place for this?

Yes :)

