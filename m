From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/23] libata-sff: clean up inheritance in several drivers
Date: Tue, 18 May 2010 10:36:44 +0200
Message-ID: <4BF2519C.1020800@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-10-git-send-email-tj@kernel.org> <4BF200D1.6030600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46128 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662Ab0ERIg5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 May 2010 04:36:57 -0400
In-Reply-To: <4BF200D1.6030600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/18/2010 04:52 AM, Jeff Garzik wrote:
> applied, sans the sata_mv (mistakenly labelled as pata_marvell) patch

Oops.

> sata_mv is not standard BMDMA, unless I am confused about something?

mv6 uses BMDMA for ATAPI DMA commands, so it's partially bmdma and
it's clearer to make anything which uses BMDMA inherit from BMDMA,
so...

Thanks.

-- 
tejun
