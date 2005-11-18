From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/5] sil24: add sil24_restart_controller
Date: Fri, 18 Nov 2005 12:21:29 +0900
Message-ID: <20051118032129.GA27358@htj.dyndns.org>
References: <20051116080244.GB22807@htj.dyndns.org> <437B79BA.2040200@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:11053 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751446AbVKRDVq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Nov 2005 22:21:46 -0500
Received: by zproxy.gmail.com with SMTP id 40so90743nzk
        for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 19:21:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <437B79BA.2040200@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Falk <efalk@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Nov 16, 2005 at 10:26:02AM -0800, Edward Falk wrote:
> 
> 
> >+static int __sil24_restart_controller(void __iomem *port)
> 
> Hi; I'm curious:  why the leading underscores in the function name?
> 
> 	-ed falk

Hi, Edward.

It's the same as sil24_reset_controller.  __sil24_restart_controller
takes 'void __iomem *port' and sil24_restart_controller takes 'struct
ata_port *ap)' and prints error message when it fails.  The
underscored versions are needed as they are called from sil24_init_one
where we don't have ap yet.  __sil24_restart_controller isn't directly
 called from sil24_init_one but __sil24_reset_controller calls it to
kick the controller if the controller doesn't turn on PORT_CS_RDY
after reset is complete.

I don't know if this is necessary.  I was just trying to be on the
safe side.

-- 
tejun
