From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/9] devicetree: bindings: Add sata port phy config
 parameters in ahci-ceva
Date: Tue, 22 Aug 2017 19:41:55 -0500
Message-ID: <20170823004155.vl3p2neyglh5kmmc@rob-hp-laptop>
References: <cover.1503314240.git.michal.simek@xilinx.com>
 <ad403e69fd5f17255db7d5190993f55ceb72c5a0.1503314240.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34397 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdHWAl5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2017 20:41:57 -0400
Content-Disposition: inline
In-Reply-To: <ad403e69fd5f17255db7d5190993f55ceb72c5a0.1503314240.git.michal.simek@xilinx.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

On Mon, Aug 21, 2017 at 01:17:16PM +0200, Michal Simek wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> This patch adds device tree bindings for sata port phy parameters
> in the ahci-ceva.txt file.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - DT fix naming in parameters description use pN instead of phy
>   reported by Rob
> 
>  .../devicetree/bindings/ata/ahci-ceva.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
