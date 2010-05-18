From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/23] libata-sff: rename ap->ops->drain_fifo() to sff_drain_fifo()
Date: Tue, 18 May 2010 10:40:34 +0200
Message-ID: <4BF25282.8070206@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-13-git-send-email-tj@kernel.org> <4BF203AA.9090601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46268 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab0ERIkm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2010 04:40:42 -0400
In-Reply-To: <4BF203AA.9090601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

Hello, Jeff.

On 05/18/2010 05:04 AM, Jeff Garzik wrote:
> At this point, I am going to drop the rest of the patchset, and await a
> resend.  This is largely due to my wish to avoid a large deviation on
> sata_mv, which continues to be patched in further patches.

Hmm... the sata_mv one was a legit change.  mv6 is partially BMDMA and
thus inherits from BMDMA although it ends up overriding most ops
anyway but that way it's clear that mv6 uses BMDMA facility and when
later further facilities are added to BMDMA, it gets automatically
inherited (which cuts both ways but at least it's easier to locate
exceptions when everything which uses bmdma inherits from it).

Thanks.

-- 
tejun
