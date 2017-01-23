From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata:pata_atiixp: Don't use unconnected secondary
 port on SB600/SB700
Date: Mon, 23 Jan 2017 14:41:29 -0500
Message-ID: <20170123194129.GD7820@htj.duckdns.org>
References: <4978cadcbc.52dc8905@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36483 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdAWTld (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 14:41:33 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so14456363pgf.3
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2017 11:41:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4978cadcbc.52dc8905@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org

On Sun, Jan 22, 2017 at 07:37:03PM +0000, Darren Stevens wrote:
> The SB600 and SB700 southbridge chips from ATI/AMD only have
> connections for the primary IDE port. As these chips have unique
> pci device ID's use these to mark the secondary port as 'dummy'
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
