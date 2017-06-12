From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: declare ata_port_info structures as const
Date: Mon, 12 Jun 2017 14:06:55 -0400
Message-ID: <20170612180655.GE19206@htj.duckdns.org>
References: <1497008708-9026-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34613 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbdFLSG6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jun 2017 14:06:58 -0400
Content-Disposition: inline
In-Reply-To: <1497008708-9026-1-git-send-email-bhumirks@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 09, 2017 at 05:15:08PM +0530, Bhumika Goyal wrote:
> ata_port_info structures are either copied to other objects or their
> references are stored in objects of type const. So, ata_port_info
> structures having similar usage pattern can be made const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
