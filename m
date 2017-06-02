From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: qoriq: add ls1088a platforms support
Date: Fri, 2 Jun 2017 09:50:03 -0400
Message-ID: <20170602135003.GA18930@htj.duckdns.org>
References: <1496388183-11534-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36638 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBNuF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jun 2017 09:50:05 -0400
Content-Disposition: inline
In-Reply-To: <1496388183-11534-1-git-send-email-andy.tang@nxp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuantian Tang <andy.tang@nxp.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 02, 2017 at 03:23:03PM +0800, Yuantian Tang wrote:
> Ls1088a is new introduced arm-based soc with sata support with
> following features:
> 
> * Complies with the serial ATA 3.0 specification
>   and the AHCI 1.3.1 specification
> * Contains a high-speed descriptor-based DMA controller
> * Supports the following:
> * Speeds of 1.5 Gb/s (first-generation SATA),
>   3 Gb/s (second-generation SATA), and 6 Gb/s (third-generation SATA)
> * FIS-based switching
> * Native command queuing (NCQ) commands
> * Port multiplier operation
> * Asynchronous notification
> * SATA Vendor BIST mode
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
