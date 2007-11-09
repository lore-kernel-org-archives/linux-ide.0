From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Thu, 8 Nov 2007 21:31:30 -0500
Message-ID: <20071109023129.GA25581@havoc.gtf.org>
References: <20071109020235.GA2031@ceren>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:60872 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758638AbXKICbb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 21:31:31 -0500
Content-Disposition: inline
In-Reply-To: <20071109020235.GA2031@ceren>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Riki Oktarianto <rkoktarianto@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On Fri, Nov 09, 2007 at 09:02:35AM +0700, Riki Oktarianto wrote:
> Some BIOSen map AHCI ABAR but lock the SATA controller to IDE mode.
> This patch add quirk to set AHCI mode on ICH board with such case.
> 
> Tested on Macbook2,1 (ICH7M)

Intel will complain but it's awful tempting...

	Jeff



