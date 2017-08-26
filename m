From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Sat, 26 Aug 2017 20:15:37 +0300
Message-ID: <20170826171537.GA4755@shredder>
References: <20170824112932.GA12461@shredder.mtl.com>
 <20170824120728.GA23186@lst.de>
 <20170824121804.GA14057@shredder.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:10272
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750737AbdHZRPq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 26 Aug 2017 13:15:46 -0400
Content-Disposition: inline
In-Reply-To: <20170824121804.GA14057@shredder.mtl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

On Thu, Aug 24, 2017 at 03:18:04PM +0300, Ido Schimmel wrote:
> On Thu, Aug 24, 2017 at 02:07:29PM +0200, Christoph Hellwig wrote:
> > What kind of device is this?   Seems like we need to blacklist it
> > as it chokes when we tried to read the Identify Devіce Log.
> 
> Is the below enough or do you need more info?

Ping?
