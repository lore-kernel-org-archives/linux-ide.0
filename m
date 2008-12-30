From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA hard drive problem when MSI enabled (ahci.c)
Date: Tue, 30 Dec 2008 13:28:21 -0600
Message-ID: <495A7655.5040702@shaw.ca>
References: <320569.63272.qm@web30708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:56847 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbYL3T2W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 14:28:22 -0500
In-Reply-To: <320569.63272.qm@web30708.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven DuChene <tevend@yahoo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>, linux-ide@vger.kernel.org

Steven DuChene wrote:
> Robert:
> 
> See the attached file for the lspci output.
> 
> As far as only the MCP65 being the only known chipset with
> problems see below.
> 
> If you search for either "pci=nomsi ahci" or groups of keywords
> like "SATA failed to IDENTIFY ahci" you wll see others having
> the same issues. For instance here is a person writing to the
> lkml with the same problem with a NVidia MCP78B chipset on a
> FSC Esprimo P5625 motherboard.
> 
> http://lkml.org/lkml/2008/7/30/74

That was a different problem - there the BIOS did not assign an IRQ to 
the controller since it was not properly in AHCI mode in the BIOS. I 
believe they fixed that by enabling AHCI.

> 
> Here is a bug on the Ubuntu Launchpad where the same problem
> is showing up on several people's systems with NVidia chipsets
> like the 780a (GeForce 8200 again) and nforce 730a chipset.
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/199573

This one has the reporter saying that a later kernel worked properly 
without disabling MSI. It is hard to say what might have been going on 
with the other posters in that bug report as they didn't post any output.

> 
> Here is the same thing with an AHCI SATA controller on a VIA
> K8T890 motherboard:
> 
> http://forums.opensuse.org/install-boot-login/394883-opensuse-installation-cant-find-my-sata-drives.html
> 
> It seems the common ways for people to resolve these issues
> is to globally set pci=nomsi both during and after the install.
> I am not sure if globally turning off MSI for the whole system
> should be the "right" answer for these folks.

There wasn't any output posted there or exact PCI IDs there either. 
(Really wish people would encourage these bugs to be reported upstream, 
using pci=nomsi is no good permanent solution.) If a chipset is 
confirmed to not have working MSI then it can be disabled in the driver 
but we really need to narrow down specific device IDs.

Curious thing is that Vista should presumably be using MSI as well, so 
it should hit the same problem, unless it's using an NVIDIA-specific 
driver that knows about it.. Seems unlikely that wouldn't have been 
noticed, though..

> --
> Steve DuChene
> 
> --- On Tue, 12/30/08, Robert Hancock <hancockr@shaw.ca> wrote:
> 
> 
>> Hmm.. Can you post lspci -vvn output?
>>
>> CCing some NVIDIA people. Is there anything known about MSI
>> being broken on MCP78S AHCI controller? Currently the only
>> known NVIDIA AHCI problems with MSI are with MCP65 revisions
>> A1 and A2. I'm not actually sure what chipset listed in
>> the driver would match with MCP78S, that particular one
>> isn't listed..
> 
> 
>       
> 
