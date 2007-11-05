From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/8] libata: factor out ata_eh_schedule_probe()
Date: Mon, 05 Nov 2007 21:29:25 +0900
Message-ID: <472F0CA5.7010800@gmail.com>
References: <1194241515653-git-send-email-htejun@gmail.com> <11942415162701-git-send-email-htejun@gmail.com> <200711051136.57793.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:47779 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723AbXKEM3e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 07:29:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1503252rvb
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 04:29:31 -0800 (PST)
In-Reply-To: <200711051136.57793.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>> -			if (!ata_dev_enabled(dev) &&
>> -			    ((ehc->i.probe_mask & (1 << dev->devno)) &&
>> -			     !(ehc->did_probe_mask & (1 << dev->devno)))) {
>> -				ata_eh_detach_dev(dev);
>> -				ata_dev_init(dev);
>> -				ehc->did_probe_mask |= (1 << dev->devno);
>> -				ehc->i.action |= ATA_EH_SOFTRESET;
>> -			}
>> +			/* schedule probe if necessary */
>> +			ata_eh_schedule_probe(dev);
> 
> !ata_dev_enabled() got lost, is this intended?

Definitely not.  Thanks a lot for catching this.  Jeff, I'll post an
updated version.  Thanks.

-- 
tejun
