From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: Errors with AHCI and 10K Raptor drive
Date: Mon, 19 Mar 2007 13:16:08 -0700
Message-ID: <20070319131608.6d93fbf4@freekitty>
References: <20070319075321.444c241e@freebird>
	<45FEA5D1.20101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:53742 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbXCSUQP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 16:16:15 -0400
In-Reply-To: <45FEA5D1.20101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Mon, 19 Mar 2007 11:01:37 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephen Hemminger wrote:
> > This is a new drive, so I suspect some driver incompatibility between the
> > driver (AHCI) and the hard drive (WD Raptor 10K 74G).
> 
> Driver incompatibilities between the driver (LLDD or libata-core) and a 
> hard drive are extremely rare.
> 
> The most common problem on modern SATA drives is drive firmware bugs, at 
> the moment.
> 

I moved the drive to another machine with ICH7 and it seems to work fine
there. Strange?


-- 
Stephen Hemminger <shemminger@linux-foundation.org>
