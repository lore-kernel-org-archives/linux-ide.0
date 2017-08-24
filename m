From: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Thu, 24 Aug 2017 14:07:29 +0200
Message-ID: <20170824120728.GA23186@lst.de>
References: <20170824112932.GA12461@shredder.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49419 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbdHXMHa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 24 Aug 2017 08:07:30 -0400
Content-Disposition: inline
In-Reply-To: <20170824112932.GA12461@shredder.mtl.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ido Schimmel <idosch@mellanox.com>
Cc: hch@lst.de, tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

What kind of device is this?   Seems like we need to blacklist it
as it chokes when we tried to read the Identify Devіce Log.
