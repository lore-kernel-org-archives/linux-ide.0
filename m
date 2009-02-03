From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [stable] [Bugme-new] [Bug 12351] New: sata_nv hotplug not work
 in 2.6.27.10
Date: Mon, 02 Feb 2009 20:04:42 -0600
Message-ID: <4987A63A.1020801@gmail.com>
References: <bug-12351-10286@http.bugzilla.kernel.org/> <20090105153644.8a0eea74.akpm@linux-foundation.org> <4962AC5C.1000605@shaw.ca> <20090106102758.GA7309@libero.it> <4963F520.4060500@shaw.ca> <20090115184502.GC10674@kroah.com> <4971449A.9010601@shaw.ca> <20090202225500.GB32075@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:45230 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbZBCCEp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 21:04:45 -0500
Received: by yx-out-2324.google.com with SMTP id 8so647227yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Feb 2009 18:04:43 -0800 (PST)
In-Reply-To: <20090202225500.GB32075@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Tejun Heo <tj@kernel.org>, gpanco@tiscali.it, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org

Greg KH wrote:
> On Fri, Jan 16, 2009 at 08:38:18PM -0600, Robert Hancock wrote:
>> Greg KH wrote:
>>> On Tue, Jan 06, 2009 at 06:19:44PM -0600, Robert Hancock wrote:
>>>> Giovanni Pancotti wrote:
>>>>> On Monday 05 January 2009, alle 18:57, Robert Hancock wrote:
>>>>>
>>>>>>>> Hardware Environment:x86 ASUS M2N-E
>>>>>> OK, this is an MCP61 board. We're now using softreset instead of hardreset 
>>>>>> on hotplug and apparently that doesn't work. Thing is that:
>>>>> no, it is not MCP61, but MCP55:
>>>> Ahh, ok, that is less contradictory then :-) Presumably we should still 
>>>> be using hardreset on that chipset.
>>> So, do we know how to solve this in the 2.6.27.y tree?
>> Can you try reverting this patch?
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=3c324283e6cdb79210cf7975c3e40d3ba3e672b2
>>
>> This likely isn't a proper fix as it will probably re-break some other 
>> chipsets but it will confirm what the problem is in this case. It looks 
>> like this patch changed MCP55 to inherit from generic_ops instead of 
>> common_ops which caused it to use soft reset instead of hard reset. Not 
>> sure if that was intentional or not.. Tejun?
> 
> I don't want to revert that, as I don't want to break anything else :)

That was directed at the reporter :-) However, hopefully this patch in 
current git will resolve the problem:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2d775708bc6613f1be47f1e720781343341ecc94
