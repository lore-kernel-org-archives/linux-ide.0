From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] amd74xx: Support MCP55 device IDs
Date: Sun, 3 Jul 2005 18:05:00 +0200
Message-ID: <58cb370e05070309055c64dd5e@mail.gmail.com>
References: <42C7DDAF.8000906@gentoo.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:15084 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261460AbVGCQFC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jul 2005 12:05:02 -0400
Received: by nproxy.gmail.com with SMTP id o25so126538nfa
        for <linux-ide@vger.kernel.org>; Sun, 03 Jul 2005 09:05:00 -0700 (PDT)
In-Reply-To: <42C7DDAF.8000906@gentoo.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, rpunkunus@nvidia.com

applied

On 7/3/05, Daniel Drake <dsd@gentoo.org> wrote:
> From: Rob Punkunus <rpunkunus@nvidia.com>
> 
> Rob Punkunus recently submitted a patch to enable support for MCP51/MCP55 in
> the amd74xx driver. This patch was whitespace-corrupted and didn't apply to
> 2.6.12 since MCP51 support was merged in the 2.6.12-rc series.
> 
> Gentoo would like to support this hardware for our upcoming release media, so
> I fixed the patch, and here it is :)
> 
> Jeff, since the next patch I'm sending (a libata patch) depends on the
> pci_ids.h change in this patch, it probably makes sense to include both in
> your tree..?
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
