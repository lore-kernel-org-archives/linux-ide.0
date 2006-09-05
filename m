From: Tejun Heo <htejun@gmail.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 16:56:34 +0200
Message-ID: <44FD9022.5060208@gmail.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com> <44FD84E8.8000705@gmail.com> <44FD8781.9040905@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:44408 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965036AbWIEO4u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 10:56:50 -0400
Received: by wx-out-0506.google.com with SMTP id s14so2286605wxc
        for <linux-ide@vger.kernel.org>; Tue, 05 Sep 2006 07:56:50 -0700 (PDT)
In-Reply-To: <44FD8781.9040905@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Mark Lord <mlord@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Ric Wheeler wrote:
>> One of the problems is that currently libata EH can take some minutes 
>> recovering from an error condition.  With partial request retry from 
>> sd,  a batch of consecutive bad sectors can make recovery take a 
>> really long time.  This needs fixing.
> 
> So far, the new-init build has been running the recovery in the lab for 
> about 40 minutes ;-)

Ouch.  that's long.  BTW, from the log you posted.

sd 1:0:0:0: SCSI error: return code = 0x08000002
sdb: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sdb, sector 272900
Buffer I/O error on device sdb3, logical block 208640
Buffer I/O error on device sdb3, logical block 208641
Buffer I/O error on device sdb3, logical block 208642
Buffer I/O error on device sdb3, logical block 208643
Buffer I/O error on device sdb3, logical block 208644
Buffer I/O error on device sdb3, logical block 208645
Buffer I/O error on device sdb3, logical block 208646
Buffer I/O error on device sdb3, logical block 208647

This is sd failing the request and the error completion propagating 
through fs/buffer and thus back to its user - probably md.  It's a bit 
weird that md doesn't drop the device at this point.  I think it could 
be that special metadata path thing you mentioned.

-- 
tejun
