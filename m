From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Thu, 8 Nov 2007 22:46:22 -0500
Message-ID: <20071109034622.GB25581@havoc.gtf.org>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:56378 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbXKIDqX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 22:46:23 -0500
Content-Disposition: inline
In-Reply-To: <4733D421.7000505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

On Thu, Nov 08, 2007 at 10:29:37PM -0500, Mark Lord wrote:
> And I might even privately patch my own kernels to map the ACHI BAR
> in the cases where the BIOS didn't...

The inability to do this in the general case is the main reason why
AHCI was not unconditionally enabled, even in IDE mode, when it was
originally added...  :/

	Jeff, taking a trip down memory lane



