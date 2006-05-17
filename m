From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 17:04:06 -0400
Message-ID: <446B8FC6.5040009@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34248 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751120AbWEQVEN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 17:04:13 -0400
In-Reply-To: <446B8F25.3040907@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Mark Lord wrote:
> Tejun Heo wrote:
> ..
>> sd forces disk revalidation (and thus ordered reconfiguration) if you 
>> change cache mode via /sys/class/scsi_disk/X\:0\:0\:0/cache_type.
> 
> That's not implemented for libata --> the emulation in libata-scsi
> rejects any attempt at a MODE_SELECT command, which is what the sysfs
> attr triggers.
> 
> Wasn't there a patch to implement MODE_SELECT in libata once upon a time?

A couple iterations from Douglas Gilbert, probably in linux-scsi archives...

BTW, libata needs to trap IDENTIFY*DEVICE and update its cached copy of 
the identify page, whenever MODE SELECT or another independent entity 
issues IDENTIFY*DEVICE.

	Jeff



