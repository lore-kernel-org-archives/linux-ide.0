From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_nv regression on Supermicro H8DMT+ for kernels newer than
 2.6.25
Date: Mon, 01 Sep 2008 09:53:56 +0200
Message-ID: <48BB9F94.8030304@kernel.org>
References: <20080831204147.GG30238@arachsys.com> <20080831213258.GE13757@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39450 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725AbYIAHzM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Sep 2008 03:55:12 -0400
In-Reply-To: <20080831213258.GE13757@arachsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
Cc: linux-ide@vger.kernel.org

Chris Webb wrote:
> Chris Webb <chris@arachsys.com> writes:
> 
>> I'm having some trouble with the sata_nv driver on a Supermicro Opteron
>> motherboard. It's an H8DMT+ with an onboard nVidia MCP55V Pro SATA controller
>> running the latest release of the BIOS.
> [...]
>> I imagine this implies that the chipset on this board has trouble with hard
>> resets in some way, but I'd be grateful for any advice as to the most sensible
>> next step to debug this!
> 
> Just to follow up to my report, the following patch seems to cure these
> symptoms:

Thanks.  Known problem.  Patch pending.

-- 
tejun
