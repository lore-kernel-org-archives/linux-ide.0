From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Sun, 27 Aug 2017 21:25:11 +0300
Message-ID: <20170827182511.GA26677@splinter>
References: <20170824112932.GA12461@shredder.mtl.com>
 <20170824120728.GA23186@lst.de>
 <20170824121804.GA14057@shredder.mtl.com>
 <20170826171537.GA4755@shredder>
 <20170827090546.GA16766@lst.de>
 <20170827105331.GA18386@shredder.mtl.com>
 <20170827170348.GA22437@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:49184
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751260AbdH0SZW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 27 Aug 2017 14:25:22 -0400
Content-Disposition: inline
In-Reply-To: <20170827170348.GA22437@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

On Sun, Aug 27, 2017 at 07:03:48PM +0200, Christoph Hellwig wrote:
> Does this make your boot issue go away?

Yes.

Feel free to submit officially with my tag:

Tested-by: Ido Schimmel <idosch@mellanox.com>

Hopefully the patch can be sent to Linus sometime this week, before 4.13
is released.

Thanks a lot Christoph!
