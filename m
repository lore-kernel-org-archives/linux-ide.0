From: "Benjamin S." <sbenni@gmx.de>
Subject: Re: ahci sometimes fails to suspend controller
Date: Mon, 27 Jul 2009 14:06:12 +0200
Message-ID: <20090727140612.27d176ca@pluto-lenny.milky.way>
References: <20090719220423.54e8c75d@uranus>
	<4A683755.60909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:32929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751374AbZG0MDQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jul 2009 08:03:16 -0400
In-Reply-To: <4A683755.60909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Thu, 23 Jul 2009 19:11:33 +0900
Tejun Heo <tj@kernel.org> wrote:

> Benjamin S. wrote:
> > It works great until I have suspended 
> > (to ram) and resumed my system several times and then the kernel fails
> > to suspend (or maybe resume). 
> 
> Does "pci=nomsi" help?

Thanks for your suggestion. It has an uptime of almost 4 days and had 
at least 40 suspends and resumes till now. That is a good sign but 
even without pci=nomsi sometimes it has taken 2 weeks until I have
got this error. Thus I want to wait another week to be sure.


Regards, Benjamin
