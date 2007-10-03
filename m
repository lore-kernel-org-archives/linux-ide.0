From: Marc MERLIN <marc@merlins.org>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Tue, 2 Oct 2007 22:59:36 -0700
Message-ID: <20071003055936.GB2533@merlins.org>
References: <20071002170445.GB2902@merlins.org> <47030CC0.8040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:52582 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbXJCF7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 01:59:37 -0400
Content-Disposition: inline
In-Reply-To: <47030CC0.8040601@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, Oct 03, 2007 at 12:30:08PM +0900, Tejun Heo wrote:
> 1. Does booting with fewer number of drives (say 5) help?
 
Boot is ok with 10 drives now with your latest code (20070808 instead
of 20070803)
 
> 2. Does limiting PHY speed to 1.5Gbps using DIP switch on the harddrive
> help?

Those drives do not have any DIP switches at all. Can I limit this in
software in the driver maybe?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
