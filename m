From: Tejun Heo <tj@kernel.org>
Subject: Re: BUG: AHCI: ata8 port resetting needlessly, slow boot
Date: Tue, 4 Nov 2014 12:59:28 -0500
Message-ID: <20141104175928.GG14459@htj.dyndns.org>
References: <54564A6C.4060009@bitsync.net>
 <20141103091116.GA21659@kwain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60749 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaKDR7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Nov 2014 12:59:32 -0500
Received: by mail-qc0-f174.google.com with SMTP id r5so11162117qcx.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Nov 2014 09:59:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141103091116.GA21659@kwain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Zlatko Calusic <zcalusic@bitsync.net>, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org

On Mon, Nov 03, 2014 at 10:11:16AM +0100, Antoine Tenart wrote:
> From 78af1100856d5f304b794727005fda589d2c4c84 Mon Sep 17 00:00:00 2001
> From: Antoine Tenart <antoine.tenart@free-electrons.com>
> Date: Mon, 3 Nov 2014 09:56:11 +0100
> Subject: [PATCH] ahci: fix AHCI parameters not taken into account
> 
> Changes into the AHCI subsystem have introduced a bug by not taking into
> account the force_port_map and mask_port_map parameters when using the
> ahci_pci_save_initial_config function. This commit fixes it by setting
> the internal parameters of the ahci_port_priv structure.

Applied to libata/for-3.18-fixes w/ tested-by tag added.

Thanks.

-- 
tejun
