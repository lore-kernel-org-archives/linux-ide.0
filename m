From: Mark Lord <mlord@pobox.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 17:01:25 -0400
Message-ID: <446B8F25.3040907@pobox.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from proof.pobox.com ([207.106.133.28]:30895 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751118AbWEQVBe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 17:01:34 -0400
In-Reply-To: <446AAA33.5010800@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
..
> sd forces disk revalidation (and thus ordered reconfiguration) if you 
> change cache mode via /sys/class/scsi_disk/X\:0\:0\:0/cache_type.

That's not implemented for libata --> the emulation in libata-scsi
rejects any attempt at a MODE_SELECT command, which is what the sysfs
attr triggers.

Wasn't there a patch to implement MODE_SELECT in libata once upon a time?

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
