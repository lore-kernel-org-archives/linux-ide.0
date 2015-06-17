From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: ahci_mvebu: add suspend/resume support
Date: Wed, 17 Jun 2015 14:26:32 -0400
Message-ID: <20150617182632.GJ22637@mtj.duckdns.org>
References: <1434543061-3066-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33641 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757774AbbFQS0f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jun 2015 14:26:35 -0400
Received: by ykfr66 with SMTP id r66so47100768ykf.0
        for <linux-ide@vger.kernel.org>; Wed, 17 Jun 2015 11:26:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434543061-3066-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Wed, Jun 17, 2015 at 02:11:01PM +0200, Thomas Petazzoni wrote:
> This commit adds suspend/resume support to the ahci_mvebu driver. The
> suspend hook doesn't do anything special despite calling the generic
> ahci_platform_suspend_host() function. However, the resume hook has to
> restore the MBus windows configuration, as well as the regret option.
> 
> Tested on Marvell Armada 388 GP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.2.

Thanks.

-- 
tejun
