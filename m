From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v2 2/2] sd: check BLK_DEF_MAX_SECTORS against max_dev_sectors
Date: Sun, 14 Aug 2016 17:00:52 +0800
Message-ID: <CAGnHSE=yBrBCbyKMNKBpZHRX7YKR-TV-s5YybvTKW18_gcrAbw@mail.gmail.com>
References: <60518e90d462d4cbb1c528914eac64e2fe124717.1471011949.git.tom.ty89@gmail.com>
 <974f3a0aa9e82caf067353fd7d7119c07d7e98c1.1471011949.git.tom.ty89@gmail.com> <yq11t1tmzxb.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33215 "EHLO
	mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbcHNJAy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Aug 2016 05:00:54 -0400
In-Reply-To: <yq11t1tmzxb.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-block@vger.kernel.org

On 13 August 2016 at 05:37, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> It would be pretty unusual for a device that is smart enough to report a
> transfer length limit to be constrained to 1 MB and change.
>

Well, it is done pretty much for libata's SATL. Also since
opt_xfer_blocks is checked against dev_max, I think it makes sense in
logic that we do the equivalence for BLK_DEF_MAX_SECTORS. Not to
mention that since we check rw_max against the controller limit, no
reason not to make sure we check it against the device limit in both
cases.

>
> If you want to fix this please drop the braces and do:
>
>                 rw_max = min(BLK_DEF_MAX_SECTORS, q->limits.max_dev_sectors);

That won't really work. min_t() would, though the line is gonna be a
bit long; not sure if I can/should simply cast the type (unsigned int)
to BLK_DEF_MAX_SECTORS. And which braces are you referring to?

>
> --
> Martin K. Petersen      Oracle Linux Engineering
