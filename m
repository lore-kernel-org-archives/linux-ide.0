From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: libahci: Make host flags unsigned long
Date: Fri, 1 Aug 2014 08:52:06 -0400
Message-ID: <20140801125206.GB21624@htj.dyndns.org>
References: <1406893181-24764-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:44628 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbaHAMwK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2014 08:52:10 -0400
Content-Disposition: inline
In-Reply-To: <1406893181-24764-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 01, 2014 at 01:39:41PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 725c7b570fda (ata: libahci_platform: move port_map parameters
> into the AHCI structure) moves flags into the struct ahci_host_priv's
> .flags field, which causes compiler warnings on 64-bit builds when that
> value is cast to a void * pointer. Rather than adding additional casting
> to silence the warning, turn the flags field into a unsigned long.

Unless we're talking about a lot of places where such casting is
necessary, I'd actually prefer to keep the flags uint and use explicit
casting.  How many are we talking about?

Thanks.

-- 
tejun
