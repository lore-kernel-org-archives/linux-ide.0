From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ATA: sata_mv: Fix warnings when no PCI
Date: Sat, 29 Sep 2012 14:19:37 -0700
Message-ID: <20120929211937.GG12999@quad.lixom.net>
References: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54988 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2I2VTW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2012 17:19:22 -0400
Received: by pbbrr4 with SMTP id rr4so6455016pbb.19
        for <linux-ide@vger.kernel.org>; Sat, 29 Sep 2012 14:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org

On Fri, Sep 28, 2012 at 05:04:10PM +0200, Andrew Lunn wrote:
> Dove can be configured with PCI. We then get a number of warnings:
> 
> warning: 'msi' defined but not used
> warning: 'mv5_sht' defined but not used
> warning: 'mv_dump_pci_cfg' defined but not used.
> 
> Move around variables and add #ifdef as necassary to fix the warnings.

Hi,

This should probably go through the libata maintainer, or at least be cc:d him
so you can get an ack on it (in case there are other dependencies on ARM
changes for it).  

-Olof
