From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: fix Null pointer dereference in
 achi_host_active()
Date: Tue, 23 Jul 2013 10:26:25 -0400
Message-ID: <20130723142625.GA18186@mtj.dyndns.org>
References: <20130722212822.GB16776@mtj.dyndns.org>
 <1374551650-56759-1-git-send-email-xtfeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f169.google.com ([209.85.213.169]:44266 "EHLO
	mail-ye0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab3GWO0d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jul 2013 10:26:33 -0400
Content-Disposition: inline
In-Reply-To: <1374551650-56759-1-git-send-email-xtfeng@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiaotian Feng <xtfeng@gmail.com>
Cc: Alexander Gordeev <agordeev@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 23, 2013 at 11:54:10AM +0800, Xiaotian Feng wrote:
> commit b29900e6 (AHCI: Make distinct names for ports in /proc/interrupts)
> introuded a regression, which resulted Null pointer dereference for achi
> host with dummy ports. For ahci ports, when the port is dummy port, its
> private_data will be NULL, as ata_dummy_port_ops doesn't support ->port_start.
> 
> changes in v2: use pp to check dummy ports, update comments
> 
> Reported-and-tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Xiaotian Feng <xtfeng@gmail.com>
> Cc: Alexander Gordeev <agordeev@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to libata/for-3.11-fixes.

Thanks.

-- 
tejun
