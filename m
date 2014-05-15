From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC 05/11] ata: Remove ARCH_KIRKWOOD dependency
Date: Thu, 15 May 2014 13:46:43 -0400
Message-ID: <20140515174643.GA20738@mtj.dyndns.org>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-10-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:41076 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbaEORqr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2014 13:46:47 -0400
Received: by mail-qg0-f43.google.com with SMTP id 63so2340284qgz.30
        for <linux-ide@vger.kernel.org>; Thu, 15 May 2014 10:46:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400163836-9831-10-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Thu, May 15, 2014 at 04:23:50PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route the patch as you see fit.

Thanks.

-- 
tejun
