From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: mcp89: enter AHCI mode under Apple BIOS emulation
Date: Fri, 22 Nov 2013 17:50:04 -0500
Message-ID: <20131122225004.GF8981@mtj.dyndns.org>
References: <20131119000637.GA6243@unibuddy.saluda.saludamedical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:52041 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755933Ab3KVWuI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 17:50:08 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so930997qaq.14
        for <linux-ide@vger.kernel.org>; Fri, 22 Nov 2013 14:50:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131119000637.GA6243@unibuddy.saluda.saludamedical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Laird <jhl@mafipulation.org>
Cc: linux-ide@vger.kernel.org

On Tue, Nov 19, 2013 at 11:06:38AM +1100, James Laird wrote:
> Apple's BIOS emulation forcibly disables MCP89 AHCI, eg. on Macbook7,1.
> We can re-enable it, replacing the previous workaround of using
> ata_generic.
> 
> Signed-off-by: James Laird <jhl@mafipulation.org>

Applied to libata/for-3.14 with whitespace adjusted.

Thanks.

-- 
tejun
