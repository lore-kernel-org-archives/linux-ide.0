From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci sometimes fails to suspend controller
Date: Tue, 28 Jul 2009 11:50:28 +0900
Message-ID: <4A6E6774.6030909@kernel.org>
References: <20090719220423.54e8c75d@uranus>	<4A683755.60909@kernel.org> <20090727140612.27d176ca@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46954 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbZG1CsW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jul 2009 22:48:22 -0400
In-Reply-To: <20090727140612.27d176ca@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Shane Huang <Shane.Huang@amd.com>

(cc'ing Shane)

Benjamin S. wrote:
> On Thu, 23 Jul 2009 19:11:33 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
>> Benjamin S. wrote:
>>> It works great until I have suspended 
>>> (to ram) and resumed my system several times and then the kernel fails
>>> to suspend (or maybe resume). 
>> Does "pci=nomsi" help?
> 
> Thanks for your suggestion. It has an uptime of almost 4 days and had 
> at least 40 suspends and resumes till now. That is a good sign but 
> even without pci=nomsi sometimes it has taken 2 weeks until I have
> got this error. Thus I want to wait another week to be sure.

Shane, this is the msi pci quirk not being applied during resume,
right?  IIRC, the patch has been posted upstream (did I do that or did
you?).  Maybe it would be nice to send the patch to -stable?

Oh.. the original thread is..

http://thread.gmane.org/gmane.linux.ide/41926

Thanks.

-- 
tejun
