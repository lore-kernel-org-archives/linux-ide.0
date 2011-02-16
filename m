From: Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH 1/10] ide: use pci_dev->revision
Date: Wed, 16 Feb 2011 11:26:49 -0800
Message-ID: <4D5C24F9.3070607@intel.com>
References: <200708292316.38779.bzolnier@gmail.com> <46D5E77B.5030800@intel.com> <4D5C0EFA.9060507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61280 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457Ab1BPT0u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Feb 2011 14:26:50 -0500
In-Reply-To: <4D5C0EFA.9060507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

On 02/16/11 09:52, Sergei Shtylyov wrote:
> Hello.
>
> Kok, Auke wrote:
>
>>> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID so
>>> they were not converted by commit
>>> 44c10138fd4bbc4b6d6bff0873c24902f2a9da65.
>
>> that's actually another effort that I'm working on atm. You can either
>> hold off on your patch or we'll see how my patches bounce against yours ;)
>
>      What happened to that effort back then I wonder? I'm now dealing with
> PCI_CLASS_REVISON piecewise. BTW, there are also new PCI_REVISION_ID users. :-)

Ha, that was a while ago :)

I've not done any ""real"" driver work for a while now, so feel free to 
pick this cleanup off the floor and blow some life in it. I currently do 
not have the time to follow up there :)

Auke
