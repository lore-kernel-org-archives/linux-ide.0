From: Riki Oktarianto <rkoktarianto@gmail.com>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Fri, 9 Nov 2007 19:45:33 +0700
Message-ID: <20071109124533.GA6665@ceren>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:54449 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758156AbXKIMps (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 07:45:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so455292rvb
        for <linux-ide@vger.kernel.org>; Fri, 09 Nov 2007 04:45:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071109023129.GA25581@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On Thu, Nov 08, 2007 at 09:31:30PM -0500, Jeff Garzik wrote:
> On Fri, Nov 09, 2007 at 09:02:35AM +0700, Riki Oktarianto wrote:
> > Some BIOSen map AHCI ABAR but lock the SATA controller to IDE mode.
> > This patch add quirk to set AHCI mode on ICH board with such case.
> > 
> > Tested on Macbook2,1 (ICH7M)
> 
> Intel will complain but it's awful tempting...
> 
> 	Jeff
> 
> 

Then the tempted users will complain back :)

-- 
Riki Oktarianto
