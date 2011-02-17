From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [Patch] enable AHCI mode on certain ich chipsets
Date: Thu, 17 Feb 2011 17:52:32 -0500
Message-ID: <4D5DA6B0.5080902@teksavvy.com>
References: <20110216090548.GQ5778@Redstar.dorchain.net> <4D5C2974.4070608@garzik.org> <20110217163649.GC20662@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:1584 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752169Ab1BQWwh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Feb 2011 17:52:37 -0500
In-Reply-To: <20110217163649.GC20662@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Joerg Dorchain <joerg@dorchain.net>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>

On 11-02-17 11:36 AM, Matthew Garrett wrote:
> On Wed, Feb 16, 2011 at 02:45:56PM -0500, Jeff Garzik wrote:
> 
>> How is the assignment of the AHCI BAR handled?  Does this happen  
>> automatically because it's an early fixup?
>>
>> That is traditionally the stumbling block...
> 
> Yes, because it's an early fixup the kernel should allocate it itself. 
> It's small enough that I'd hope we don't have trouble finding one...


It works here (the AHCI BAR setup) with this patch,
though the workaround itself doesn't work because my
Dell machine requires extra/secret fiddling to switch
things fully over to AHCI.

The patch does seem harmless enough to include in the kernel, though.
