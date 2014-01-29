From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ATA: SATA_MV: Add missing Kconfig select statememnt
Date: Wed, 29 Jan 2014 13:20:35 -0500
Message-ID: <20140129182035.GM30842@htj.dyndns.org>
References: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
 <1390420593-27697-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34185 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbaA2SUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2014 13:20:39 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so3349437qcv.34
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2014 10:20:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390420593-27697-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-ide@vger.kernel.org

On Wed, Jan 22, 2014 at 08:56:33PM +0100, Andrew Lunn wrote:
> SATA_MV depends on GENERIC_PHY. So if SATA_MV is built in, GENERIC_PHY
> cannot be modular. Fixes build error found by kbuild test robot.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied to libata/for-3.14-fixes.  Thanks.

-- 
tejun
