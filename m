From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci: CAP_SSS and parallel scan
Date: Fri, 07 May 2010 07:16:07 +0200
Message-ID: <4BE3A217.2030407@kernel.org>
References: <4BE27C49.5090809@kernel.org> <4BE28C4F.9000903@linux.intel.com> <4BE2D5D6.1010705@kernel.org> <4BE3244A.7060607@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45286 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab0EGFQg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 May 2010 01:16:36 -0400
In-Reply-To: <4BE3244A.7060607@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, t.artem@mailcity.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 05/06/2010 10:19 PM, Mark Lord wrote:
> On 06/05/10 03:49 PM, Jeff Garzik wrote:
>>
>>> Currently, there's no way to tell whether staggered spin up is needed
>>> or drives are already spun up.
> 
> Perhaps by issuing a "CHECK POWER MODE" command?
> For many drives, a non-spinning drive is detectable from its IDENTIFY data.

Heh, yeah, I wish it were like that.  IIRC, there are two different
staggered spin up scheme.  The one implemented by CAP_SSS uses link
init sequence as signal to spin up which means you don't even know
whether there's a device attached before committing to spinning it up.
Gotta love ATA.  :-)

-- 
tejun
