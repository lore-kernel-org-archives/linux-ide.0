From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: palm_bk3710: add __initdata to
 palm_bk3710_port_info
Date: Mon, 27 Feb 2017 20:45:20 -0500 (EST)
Message-ID: <20170227.204520.476923849195276799.davem@davemloft.net>
References: <1483089602-6016-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:52388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdB1CD3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2017 21:03:29 -0500
In-Reply-To: <1483089602-6016-1-git-send-email-bhumirks@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bhumirks@gmail.com
Cc: julia.lawall@lip6.fr, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Fri, 30 Dec 2016 14:50:02 +0530

> The object palm_bk3710_port_info of type ide_port_info is never
> referenced anywhere after initialization by palm_bk3710_probe. It is
> also passed as a parameter to ide_host_add which is called from the init
> function but this call doesn't store the object reference anywhere, and
> it only dereferences the values of the fields. Therefore add __initdata
> to its declaration.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied, thanks.
