From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [stable] [Bugme-new] [Bug 12351] New: sata_nv hotplug not work
   in 2.6.27.10
Date: Fri, 16 Jan 2009 20:38:18 -0600
Message-ID: <4971449A.9010601@shaw.ca>
References: <bug-12351-10286@http.bugzilla.kernel.org/> <20090105153644.8a0eea74.akpm@linux-foundation.org> <4962AC5C.1000605@shaw.ca> <20090106102758.GA7309@libero.it> <4963F520.4060500@shaw.ca> <20090115184502.GC10674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:32611 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934048AbZAQCiY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 21:38:24 -0500
In-Reply-To: <20090115184502.GC10674@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: gpanco@tiscali.it, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org, bugme-daemon@bugzilla.kernel.org

Greg KH wrote:
> On Tue, Jan 06, 2009 at 06:19:44PM -0600, Robert Hancock wrote:
>> Giovanni Pancotti wrote:
>>> On Monday 05 January 2009, alle 18:57, Robert Hancock wrote:
>>>
>>>>>> Hardware Environment:x86 ASUS M2N-E
>>>> OK, this is an MCP61 board. We're now using softreset instead of hardreset 
>>>> on hotplug and apparently that doesn't work. Thing is that:
>>> no, it is not MCP61, but MCP55:
>> Ahh, ok, that is less contradictory then :-) Presumably we should still 
>> be using hardreset on that chipset.
> 
> So, do we know how to solve this in the 2.6.27.y tree?

Can you try reverting this patch?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=3c324283e6cdb79210cf7975c3e40d3ba3e672b2

This likely isn't a proper fix as it will probably re-break some other 
chipsets but it will confirm what the problem is in this case. It looks 
like this patch changed MCP55 to inherit from generic_ops instead of 
common_ops which caused it to use soft reset instead of hard reset. Not 
sure if that was intentional or not.. Tejun?

We really ought to fix up some of the naming in this driver to be less 
confusing. Especially the "generic" stuff should be renamed, it's not 
generic at all (it seems to only apply to MCP61 currently) yet it's used 
as a base operations for other chipset types.
