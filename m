From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: don't call memcpy with the same source and
 destination
Date: Mon, 08 May 2017 17:37:21 -0400 (EDT)
Message-ID: <20170508.173721.1587256787895455007.davem@davemloft.net>
References: <alpine.LRH.2.02.1704141433280.10706@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:41622 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdEHVhX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 May 2017 17:37:23 -0400
In-Reply-To: <alpine.LRH.2.02.1704141433280.10706@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mpatocka@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jejb@parisc-linux.org, deller@gmx.de, dave.anglin@bell.net, linux-parisc@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 14 Apr 2017 14:35:33 -0400 (EDT)

> The parisc architecture recently reimplemented the memcpy function and
> their reimplementation crashed when source and destination overlapped.
> 
> The crash happened in the function ide_complete_cmd where memcpy is called
> with the same source and destination pointer. According to the C
> specification, memcpy behavior is undefined if the source and destination
> range overlaps. This patches fixes the undefined behavior.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Applied.
