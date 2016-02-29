From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA
 RAID device IDs
Date: Mon, 29 Feb 2016 01:55:54 -0800
Message-ID: <20160229095554.GA1474@infradead.org>
References: <1456737781-13494-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47822 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbcB2Jzz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Feb 2016 04:55:55 -0500
Content-Disposition: inline
In-Reply-To: <1456737781-13494-1-git-send-email-hehy1@lenovo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ocean,

no, all AHCI devices should be driven by the Linux kernel driver.
We do not offer support for '3rd party' drivers in Linux.
