From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 05 Jan 2009 20:47:22 +0300
Message-ID: <496247AA.1040809@ru.mvista.com>
References: <49615667.9020408@iwl.com>	<yq1vdsu317m.fsf@sermon.lab.mkp.net>	<496200A3.2000906@ru.mvista.com> <20090105133340.050858bb@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61650 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752137AbZAERqr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 12:46:47 -0500
In-Reply-To: <20090105133340.050858bb@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

Hello.

Alan Cox wrote:

>>>The IDE interface of the Geode CS5536 companion chip is a completely
>>>different beast.  It's a more or less standard AMD 8111 PCI IDE device
>>>with slightly different timings.

>>   I'm not sure I uderstand the passage about "slightly different 
>>timings"...

> The timing values used are different to those on the AMD 8111 even though
> the interface is similar.

    What do you mean by timing values anyway, clock counts or the register 
encoding itself?

>>   It's stange that the driver is using CPI config. space by default 
>>which not even documented in the datasheet. I guess the MSR accesses are 

> The PCI configuration is the portable way to drive it.

    Portable to what? As you have yorself noted below, this is Geode -- and I 
highly doubt that CS5536 will be used for anything else.

>>also somewhat faster because one doesn't have to access the address/data 
>>register pair at ports 0xcf8/0xcfc...

> This is a Geode.

    I know. :-)
    I have hacked on older Geode GX2 for some time back in 2004 (although not 
on something related to PCI); my "toy" board has RIP just recently.)

> What makes you think there is even a PCI bus 

    I sure know that it's not PCI (IIUC, it's the common tendency in the x86 
north-to-south-bridge busses has been emulating the PCI config. space with 
less and less PCI compatible "physical layer"). That does mean emulating PCI 
config. space mechanism #1 and Geode's not an exception here, see:

http://www.amd.com/files/connectivitysolutions/geode/geode_gx/32663C_lx_gx_pciconfig.pdf

> or that the 8111 interface isn't entirely a software construct.

    If that's the case (looks like so), it makes using it even appealing...

> Geode PCI hardware is mostly smoke and mirrors ;)

    When it comes to their internal controllers, yes (though e.g. their OHCI 
seem to have the real PCI config. space).

> Alan

WBR, Sergei
