From: Tejun Heo <tj@kernel.org>
Subject: Re: [Patch v3] 2/7] ata: Remove ARCH_KIRKWOOD dependency
Date: Sun, 31 Aug 2014 07:02:46 -0400
Message-ID: <20140831110246.GD19853@htj.dyndns.org>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1409417172-6846-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:39313 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaHaLCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2014 07:02:50 -0400
Received: by mail-qa0-f43.google.com with SMTP id cm18so3952708qab.30
        for <linux-ide@vger.kernel.org>; Sun, 31 Aug 2014 04:02:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409417172-6846-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org

On Sat, Aug 30, 2014 at 06:46:07PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> ARCH_MVEBU is sufficient.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
