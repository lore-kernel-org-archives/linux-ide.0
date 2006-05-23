From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/13] libata-hp: implement SCSI part of hotplug
Date: Tue, 23 May 2006 07:52:11 -0700
Message-ID: <4473219B.2070307@gmail.com>
References: <1148053707416-git-send-email-htejun@gmail.com> <446DECCD.1020100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:7501 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932429AbWEWVz1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:27 -0400
Received: by py-out-1112.google.com with SMTP id z59so2003389pyg
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:27 -0700 (PDT)
In-Reply-To: <446DECCD.1020100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>> +void ata_eh_scsi_hotplug(void *data)
> 
> Would prefer ata_eh_scsi_hotplug() to be in libata-scsi.  Otherwise ACK.

Will move.

-- 
tejun

