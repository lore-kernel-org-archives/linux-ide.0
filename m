From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix interface autodetection in legacy IDE driver
 (trial #2)
Date: Tue, 27 Dec 2016 19:38:18 -0500 (EST)
Message-ID: <20161227.193818.1314136105272589794.davem@davemloft.net>
References: <CGME20161227172520epcas5p3e8ce2b1af4b5a3e1d9a42434d9c9b14f@epcas5p3.samsung.com>
        <1680456.bXBqjl9psU@amdc3058>
        <20161228003335.GA3720@giustizia>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:54406 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbcL1AiZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Dec 2016 19:38:25 -0500
In-Reply-To: <20161228003335.GA3720@giustizia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lramos.prof@yahoo.com.br
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, petkovbb@gmail.com

From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Date: Tue, 27 Dec 2016 22:33:35 -0200

> So, ide_generic_init() should test *primary for 1 in the case of an
> existing IDE primary resource, and *secondary for 1 in the case of a
> secondary IDE resource.
> 
> Unpatched code checks both for zero in order to set the proper bits in
> probe_mask, and IMHO this is reversed logic.

Right, and I can't see how this is intentional at all.
