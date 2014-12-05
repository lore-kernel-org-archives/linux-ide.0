From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Fri, 5 Dec 2014 09:51:48 -0500
Message-ID: <20141205145148.GI4080@htj.dyndns.org>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
 <20141204170611.GB2995@htj.dyndns.org>
 <yq14mtahmil.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:40565 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbaLEOv7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2014 09:51:59 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so540848qcy.32
        for <linux-ide@vger.kernel.org>; Fri, 05 Dec 2014 06:51:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <yq14mtahmil.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Dec 04, 2014 at 09:13:22PM -0500, Martin K. Petersen wrote:
> Tejun> If there's something on the horizon which would solve the
> Tejun> identification problem and we only have to worry about the
> Tejun> current batch of devices, whitelisting can be useful but
> Tejun> otherwise I'm not sure this is a good idea.
> 
> There isn't :( The only saving grace is that SSDs are gravitating
> towards NVMe and other non-ATA interfaces.

Yeap, that's true.  This whole thing is on the way out.

> I've already tightened up things in SCSI so we now prefer WRITE SAME
> which does give hard guarantees unlike UNMAP. But because we use WRITE
> SAME in the libata SATL it is imperative that we change our internal
> flagging to be equally restrictive.

Can you please elaborate this in the changelog and add comments
explaning why ATA_HORKAGE_ZERO_AFTER_TRIM is necessary and how it's
used?

> I just feel bad about disabling the feature for the many existing users
> (and there are quite a few) that are using well-behaved drives in their
> RAID deployments. And the filesystem folks have been begging for the
> zeroout discard variant that I posted a few weeks ago. So the users are
> there. I'm just trying to accommodate them the best I can given the lame
> spec.

Can you please explain further the practical gains of using trims
which guarantee zeroing?

Thanks.

-- 
tejun
