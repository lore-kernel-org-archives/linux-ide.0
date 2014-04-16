From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Wed, 16 Apr 2014 09:57:03 -0400
Message-ID: <20140416135703.GA1257@htj.dyndns.org>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <20140415160317.GM1863@htj.dyndns.org>
 <20140416063510.GH2523@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:45531 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161304AbaDPN5G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 09:57:06 -0400
Received: by mail-qg0-f45.google.com with SMTP id j5so11198205qga.18
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2014 06:57:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140416063510.GH2523@dragon>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Wed, Apr 16, 2014 at 02:35:12PM +0800, Shawn Guo wrote:
> I'm seeing a lot of ata drivers use defines though.  And I'm not sure I
> understand the advantages of using enums over defines in ahci_imx
> driver, where register offset and bit position are defined in the same
> 'enum' without a particular enum type.
> 
> enum {
> 	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
> 	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
> 	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> };
> 
> To me it's a misuse of enum.

The difference isn't that significant but enums have the advantages of
the definitions being evaluated once rather than each time it's used
which prevents things like missing parentheses subtly messing up the
containing expressions and the compiler, and thus the debugger, being
aware of the constants in use.

The technical advantages not being enormous, it's a good bike shedding
material and argue about it back and forth forever without being
productive at all, so, please just stick with enums.

Thanks.

-- 
tejun
