From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: [PATCH] libata: quirk read log on no-name M.2 SSD
Date: Tue, 29 Aug 2017 19:04:33 +0300
Message-ID: <20170829160433.GA26909@shredder.mtl.com>
References: <20170828062808.20717-1-hch@lst.de>
 <20170829154147.GP491396@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-he1eur01on0066.outbound.protection.outlook.com ([104.47.0.66]:9280
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752419AbdH2QEr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 29 Aug 2017 12:04:47 -0400
Content-Disposition: inline
In-Reply-To: <20170829154147.GP491396@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org

On Tue, Aug 29, 2017 at 08:41:48AM -0700, Tejun Heo wrote:
> Can you please verify whether the above patch works?  You can either
> remove the horkage patch and apply the above one or test the following
> git branch.

Applied the new one and reverted the old one. Works for me.

Thanks for verifying.
