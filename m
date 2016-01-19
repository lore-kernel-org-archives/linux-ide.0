From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] drivers: ata: wake port before DMA stop for ALPM
Date: Tue, 19 Jan 2016 12:26:50 -0500
Message-ID: <20160119172650.GR3520@mtj.duckdns.org>
References: <1452547346-31735-1-git-send-email-dpetigara@broadcom.com>
 <569D7A7B.8090603@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34505 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbcASR0x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2016 12:26:53 -0500
Content-Disposition: inline
In-Reply-To: <569D7A7B.8090603@broadcom.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danesh Petigara <dpetigara@broadcom.com>
Cc: linux-ide@vger.kernel.org, f.fainelli@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com

On Mon, Jan 18, 2016 at 03:51:23PM -0800, Danesh Petigara wrote:
> Hi Tejun,
> 
> I was wondering if you had an opportunity to review this patch? Any
> chance of this going into v4.5 along with the other patches, or would
> you like to defer it to v4.6? I am fine either way.

Looks fine to me.  I'll route it through for-4.5-fixes once -rc1 is
cut.

Thanks.

-- 
tejun
