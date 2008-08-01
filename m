From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: libata badness
Date: Fri, 1 Aug 2008 11:43:47 +0100
Message-ID: <20080801104347.GM26938@trinity.fluff.org>
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org> <20080731210410.GA623@polina.dev.rtsoft.ru> <DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:34954 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbYHAKn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 06:43:59 -0400
Content-Disposition: inline
In-Reply-To: <DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: avorontsov@ru.mvista.com, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Thu, Jul 31, 2008 at 04:58:05PM -0500, Kumar Gala wrote:
> I figured out the issue.  Its related to the interrupt routing being  
> conveyed to the code from the device tree.  We have a missing 'space'  
> causing issues.

out of interest, is the M5229 attached to a single IRQ in this device
or has the bridge been configured to route the IRQs from the IDE to
the same pin on the PIC?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
