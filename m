From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Date: Mon, 06 Feb 2006 15:13:27 +1100
Message-ID: <1139199208.4994.2.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0602010113210.5670-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:25220 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750946AbWBFEMr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Feb 2006 23:12:47 -0500
In-Reply-To: <Pine.LNX.4.44.0602010113210.5670-100000@gate.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 01:19 -0600, Kumar Gala wrote:
> I was hoping to get some comments on this work in progress driver for
> using a compact flash device running in True IDE Mode connect via a MMIO
> interface.  The driver is working, however the embedded system I'm running
> on need some HW fixes to address the fact that the byte lanes for the data
> are swapped.  I figured now was a good time to incorporate any changes
> while I wait for the HW fixes (which will allow me to remove the 
> cfide_outsw & cfide_insw).

Your driver basically boils down to a simple IDE host driver configured
by platform functions. I suggest you remove "compact flash" here and
have the platform resource optinally be either PIO or MMIO and you
magically get a "generic" IDE driver useable by a lot of simple embedded
machines (it assumes all timing related things have been handled by the
firmware). Want to be sneakier ? Add a timing setup callback to the
platform data you pass to it and you get one that can even do PIO
modes :)

Ben.


