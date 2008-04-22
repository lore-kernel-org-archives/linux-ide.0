From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [2.6 patch] select ATA_SFF
Date: Tue, 22 Apr 2008 13:39:27 +0200
Message-ID: <20080422113927.GA12774@kernel.dk>
References: <20080421213147.GH2633@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:22939 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbYDVLjd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Apr 2008 07:39:33 -0400
Content-Disposition: inline
In-Reply-To: <20080421213147.GH2633@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, Apr 22 2008, Adrian Bunk wrote:
> Making ATA_SFF a user-visible option with the drivers needing it
> depending on it caused the following problems:
> - people lose their driver when accidentally disabling it
> - people not requiring it needlessly enable it
> 
> Fortunately, we don't have to bother the user with this option at all
> since we can simply select it when it's required.

Hear hear, the newly introduced ATA_SFF config is a mess, this is much
better.

-- 
Jens Axboe

