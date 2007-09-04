From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Tue, 04 Sep 2007 12:37:02 -0400
Message-ID: <46DD89AE.7020802@redhat.com>
References: <200709030811.l838BC9a026315@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbXIDQhL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 12:37:11 -0400
In-Reply-To: <200709030811.l838BC9a026315@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@how.dk, linux-ide@vger.kernel.org

On 09/03/2007 04:11 AM, Mikael Pettersson wrote:
> On Mon, 03 Sep 2007 01:04:08 +0200, Peter Favrholdt wrote:
>> Hi Mikael Pettersson wrote:
>>> I'm easily able to reproduce this problem on my sata_promise test rig.
>>> Using 2.6.23-rc5 to dd read a single Seagate disk on a SATA300 TX4 card
>>> quickly fails as Peter described.
>>>
>>> Applying the 1.5Gbps patch to the driver appears to make things stable.
>>>
>>> Those SATAII chips really don't seem to like 3Gbps mode. Or else we're
>>> missing some critical documentation on how to make them work.
>> The funny thing is: I have the exact same adapter and disks in a Dell 
>> PE1800 server. This doesn't show any errors.
>>
>> Only difference is the card is in a PCI-X slot and the server is running
>> Linux 2.6.19.5.
> 
> I assume the PE1800 has some Intel chipset? Which one?
> And the machine that does have problems, what chipset does it have?
> 
> I'm actually beginning to think there's some PCI compatibility breakage
> somewhere, as I too see sata_promise working fine in some machines but
> not in others. Alas, my knowledge of PCI tweakables is close to nil.

I am seeing some problems solved by using pci=nomsi and/or pci=nommconf.
We either have a bug in MSI, especially on x86_64, or some chipsets just
don't work very well with it.


