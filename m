From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: libahci: Silence compiler warning on 64-bit
Date: Fri, 1 Aug 2014 11:19:17 -0400
Message-ID: <20140801151917.GG21624@htj.dyndns.org>
References: <1406903437-13995-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:38413 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAPTU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2014 11:19:20 -0400
Content-Disposition: inline
In-Reply-To: <1406903437-13995-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 01, 2014 at 04:30:37PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 725c7b570fda (ata: libahci_platform: move port_map parameters
> into the AHCI structure) moves flags into the struct ahci_host_priv's
> .flags field, which causes compiler warnings on 64-bit builds when that
> value is cast to a void * pointer. Cast to an unsigned long so that the
> subsequent cast to a pointer doesn't produce a warning.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied to libata/for-3.17.

Thanks!

-- 
tejun
