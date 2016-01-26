From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Let AHCI dirver skip Lenovo SWRAID controller
Date: Tue, 26 Jan 2016 05:24:24 -0800
Message-ID: <20160126132424.GA1993@infradead.org>
References: <1453691440-42035-1-git-send-email-hehy1@lenovo.com>
 <20160125131850.64c5c22a@lxorguk.ukuu.org.uk>
 <56A76999.8050206@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45745 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933342AbcAZNY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jan 2016 08:24:28 -0500
Content-Disposition: inline
In-Reply-To: <56A76999.8050206@lenovo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jan 26, 2016 at 12:42:43PM +0000, Ocean HY1 He wrote:
> Hi Alan,
> 
> Thanks for your comments!
> 
> Lenovo SWRAID driver is a closed source driver at this time, I am afraid 
> it's not possible to submit it to kernel.

So you're violating our copyright and want help for that?  Be ashamed!

> This patch is very important and critical for Lenovo next generation 
> Servers. I have tried to make sure this patch only impacts Lenovo 
> dedicated hardware and add a on/off boot option to end user who may 
> still wants using open source SWRAID(such as MDRAID).

The right ting is to always use mdraid and contribute the lenovo
superblock format to it, similar to how we support half a dozen other
non-native formats.
