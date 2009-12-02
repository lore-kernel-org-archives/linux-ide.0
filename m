From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Wed, 02 Dec 2009 10:07:27 +0900
Message-ID: <4B15BDCF.5020000@kernel.org>
References: <20091202003630.29919100851@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35090 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbZLBBHR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 20:07:17 -0500
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org

On 12/02/2009 09:36 AM, Benjamin Herrenschmidt wrote:
> This is a libata driver for the "macio" IDE controller used on most Apple
> PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> 
> It supports all the features of its predecessor, including mediabay hotplug
> and suspend/resume. It should also support module load/unload.
> 
> The timing calculations have been simplified to use pre-calculated tables
> compared to drivers/ide/pmac.c and it uses the new mediabay interface
> provided by a previous patch.

Other than the media bay locking thing I mentioned before, it looks
good to me and the media bay thing can be dealth with further patches,
so...

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
