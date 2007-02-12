From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [Fedora-ia64-list] Re: The 5th bar of ide controller at legacy
 mode
Date: Mon, 12 Feb 2007 13:24:24 -0500
Message-ID: <45D0B0D8.1020103@redhat.com>
References: <617E1C2C70743745A92448908E030B2A011E7BEC@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44543 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965268AbXBLSY2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Feb 2007 13:24:28 -0500
In-Reply-To: <617E1C2C70743745A92448908E030B2A011E7BEC@scsmsx411.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ia64 Fedora Core Development <fedora-ia64-list@redhat.com>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>, linux-ide@vger.kernel.org


>
> If many other BIOS writers believe the same thing as ours, then maybe
> it might be worth fixing ... otherwise it looks like we'll need a quirk
> (this machine is old, there isn't much liklihood of an updated BIOS release
> for just this issue).
>
>   

Tony,

As Alan suggested I think Yanmin should put together an 
arch/ia64/kernel/quirks.c (similar to arch/i386/kernel/quirks.c).

Note that my worry is by opening up quirks.c to this type of fix, 
vendors will be less inclined to fix other serious BIOS issues...

P.

