From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4 v2] libata: Implement disk shock protection support
Date: Fri, 19 Sep 2008 21:48:52 -0700
Message-ID: <48D480B4.3030104@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local>	<20080917163144.9870.97008.stgit@denkblock.local>	<48D147E2.3020601@gmail.com> <87skrwmpng.fsf@denkblock.local>	<48D3979F.10305@gmail.com> <87ljxokz67.fsf@denkblock.local>	<48D3B3EE.70702@gmail.com> <87fxnwkwov.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:14809 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYITEue (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Sep 2008 00:50:34 -0400
Received: by ti-out-0910.google.com with SMTP id b6so391121tic.23
        for <linux-ide@vger.kernel.org>; Fri, 19 Sep 2008 21:50:32 -0700 (PDT)
In-Reply-To: <87fxnwkwov.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> Elias Oltmanns wrote:
> Will do. By the way, it's just occurred to me that we really need to
> call complete_all() in ata_scsi_park_store(). So, thanks for making me
> think it all through once more.

Hmmm... just replied to the updated patch.  complete_all() will
potentially overflow the done counter (which BTW is interface problem
in completion) why is it necessary?  (probably best to continue on the
other thread).

Thanks.

-- 
tejun

