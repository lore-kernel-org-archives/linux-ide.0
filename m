From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: added ls2088a platforms support
Date: Wed, 18 Jan 2017 11:53:51 -0800
Message-ID: <20170118195351.GD9171@mtj.duckdns.org>
References: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36011 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbdARTyR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2017 14:54:17 -0500
Content-Disposition: inline
In-Reply-To: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: yuantian.tang@nxp.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jan 17, 2017 at 02:12:01PM +0800, yuantian.tang@nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Ls2088a is new introduced arm-based soc with sata support with
> following features:
> 1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
>    specification
> 2. Contains a high-speed descriptor-based DMA controller
> 3. Supports the following:
>    a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
>       (second-generation SATA), and 6 Gb/s (third-generation SATA)
>    b. FIS-based switching
>    c. Native command queuing (NCQ) commands
>    d. Port multiplier operation
>    e. Asynchronous notification
>    f. SATA BIST mode
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Reverted due to build failure.  Did you even try to compile it before
submission?  We all make mistakes and that's fine but this one seems a
bit too careless.  Please don't do this.

Thanks.

-- 
tejun
