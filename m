From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 06:50:31 +0900
Message-ID: <446B9AA7.4000305@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:9045 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751143AbWEQVuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 17:50:35 -0400
Received: by py-out-1112.google.com with SMTP id z59so396689pyg
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 14:50:34 -0700 (PDT)
In-Reply-To: <446B8FC6.5040009@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <mlord@pobox.com>, Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>> ..
>>> sd forces disk revalidation (and thus ordered reconfiguration) if you 
>>> change cache mode via /sys/class/scsi_disk/X\:0\:0\:0/cache_type.
>>
>> That's not implemented for libata --> the emulation in libata-scsi
>> rejects any attempt at a MODE_SELECT command, which is what the sysfs
>> attr triggers.

I see.  I was just grepping for revalidation call.  It seems we're stuck 
then.

>> Wasn't there a patch to implement MODE_SELECT in libata once upon a time?
> 
> A couple iterations from Douglas Gilbert, probably in linux-scsi 
> archives...
> 
> BTW, libata needs to trap IDENTIFY*DEVICE and update its cached copy of 
> the identify page, whenever MODE SELECT or another independent entity 
> issues IDENTIFY*DEVICE.

Right.  Also, we need to snoop some passthrough commands and 
revalidate/reconfigure when configuration is explicitly changed.

-- 
tejun
