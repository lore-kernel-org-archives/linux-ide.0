From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Wed, 17 Feb 2016 15:00:29 -0500
Message-ID: <20160217200029.GB4751@mtj.duckdns.org>
References: <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
 <56C37524.5090000@caviumnetworks.com>
 <56C37AD3.4030407@caviumnetworks.com>
 <56C37D94.8080403@caviumnetworks.com>
 <20160216211410.GI25086@rric.localdomain>
 <56C3AD1C.2000003@caviumnetworks.com>
 <20160217112931.GB31970@arm.com>
 <56C4C2AE.90009@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35967 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161065AbcBQUAb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2016 15:00:31 -0500
Content-Disposition: inline
In-Reply-To: <56C4C2AE.90009@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Will Deacon <will.deacon@arm.com>, Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>, stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Robert Richter <rric@kernel.org>, linux-arm-kernel@lists.infradead.org

Hello, David.

On Wed, Feb 17, 2016 at 10:57:50AM -0800, David Daney wrote:
> If the ahci/ata maintainers insist, we can add that.

I don't mind whether it is CONFIG_ARM64 or something more specific but
I think it's a good idea to gate it some way.

> <sarcasm>

If at all possible, please write plain arguments.

> Should we also add some CONFIG_ variables for:
> 
>   ahci_mcp89_apple_enable()
>   ahci_sb600_enable_64bit()
>   ahci_p5wdh_workaround()

And I think these should be gated behind CONFIG_X86.  The lack of
gating is historic, not intentional.

Thanks.

-- 
tejun
