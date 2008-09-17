From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/4 v2] Introduce ata_id_has_unload()
Date: Wed, 17 Sep 2008 09:57:54 -0700
Message-ID: <48D13712.1090904@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <20080917163144.9870.90985.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:47031 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbYIQQ7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 12:59:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1846204tic.23
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 09:59:31 -0700 (PDT)
In-Reply-To: <20080917163144.9870.90985.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
> Add a function to check an ATA device's id for head unload support as
> specified in ATA-7.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
