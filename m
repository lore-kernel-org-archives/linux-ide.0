From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_via: Enable hotplug only on VT6421
Date: Tue, 11 Apr 2017 09:12:50 +0900
Message-ID: <20170411001250.GB29406@wtj.duckdns.org>
References: <1490985342-16800-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33937 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdDKAND (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Apr 2017 20:13:03 -0400
Content-Disposition: inline
In-Reply-To: <1490985342-16800-1-git-send-email-linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Fri, Mar 31, 2017 at 08:35:42PM +0200, Ondrej Zary wrote:
> Commit 57e5568fda27 ("sata_via: Implement hotplug for VT6421") adds
> hotplug IRQ handler for VT6421 but enables hotplug on all chips. This
> is a bug because it causes "irq xx: nobody cared" error on VT6420 when
> hot-(un)plugging a drive:

Applied to libata/for-4.11-fixes.

Thanks.

-- 
tejun
