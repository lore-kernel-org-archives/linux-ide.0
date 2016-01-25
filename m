From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Let AHCI dirver skip Lenovo SWRAID controller
Date: Mon, 25 Jan 2016 01:56:24 -0800
Message-ID: <20160125095624.GA4237@infradead.org>
References: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57227 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbcAYJ4Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jan 2016 04:56:25 -0500
Content-Disposition: inline
In-Reply-To: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 25, 2016 at 03:11:40AM +0000, Ocean HY1 He wrote:
> Lenovo SWRAID solution is based on Intel Non-RSTE RAID controller which
> is called Lenovo SWRAID controller by set Lenovo dedicated PCI
> SVID:SDID.
> 
> Because AHCI driver now take control this Lenovo SWRAID controller for
> MDRAID, Lenovo SWRAID driver fails to load later.

And that's a good thing!
