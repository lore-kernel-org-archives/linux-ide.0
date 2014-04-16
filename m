From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Wed, 16 Apr 2014 14:35:12 +0800
Message-ID: <20140416063510.GH2523@dragon>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <20140415160317.GM1863@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:34107
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052AbaDPGfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 02:35:22 -0400
Content-Disposition: inline
In-Reply-To: <20140415160317.GM1863@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 15, 2014 at 12:03:17PM -0400, Tejun Heo wrote:
> On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> > Comparing to enums, macros are more conventional to be used for
> > registers and bits definition.  Let's switch to macros.
> > 
> > While at it, the names of the registers and bit-fields are updated to
> > have proper namespace prefix and match the hardware reference manual.
> > 
> > No functional change is involved.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Please don't switch to defines.  A lot of libata constants use enums
> and they tend to have more advantages anyway.

I'm seeing a lot of ata drivers use defines though.  And I'm not sure I
understand the advantages of using enums over defines in ahci_imx
driver, where register offset and bit position are defined in the same
'enum' without a particular enum type.

enum {
	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
};

To me it's a misuse of enum.

Shawn

