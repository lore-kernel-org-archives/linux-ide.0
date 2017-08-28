From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: quirk read log on no-name M.2 SSD
Date: Mon, 28 Aug 2017 10:28:34 -0700
Message-ID: <20170828172834.GW491396@devbig577.frc2.facebook.com>
References: <20170828062808.20717-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36912 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdH1R2i (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2017 13:28:38 -0400
Received: by mail-qk0-f181.google.com with SMTP id k126so5215529qkb.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2017 10:28:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170828062808.20717-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: idosch@mellanox.com, linux-ide@vger.kernel.org

On Mon, Aug 28, 2017 at 08:28:08AM +0200, Christoph Hellwig wrote:
> Ivo reported that reading the log page on his systems fails,
> so quirk it as it won't support ZBC or security protocols.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Tested-by: Ido Schimmel <idosch@mellanox.com>

Applied to libata/for-4.13-fixes w/ Ido's name fixed in the
description.

Thanks.

-- 
tejun
