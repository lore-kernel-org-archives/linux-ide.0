From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Add quirk to set AHCI mode on ICH boards
Date: Thu, 08 Nov 2007 23:44:22 -0500
Message-ID: <4733E5A6.30808@rtr.ca>
References: <20071109020235.GA2031@ceren> <20071109023129.GA25581@havoc.gtf.org> <4733D421.7000505@rtr.ca> <20071109034622.GB25581@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2215 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758344AbXKIEoY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 23:44:24 -0500
In-Reply-To: <20071109034622.GB25581@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Riki Oktarianto <rkoktarianto@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> On Thu, Nov 08, 2007 at 10:29:37PM -0500, Mark Lord wrote:
>> And I might even privately patch my own kernels to map the ACHI BAR
>> in the cases where the BIOS didn't...
> 
> The inability to do this in the general case is the main reason why
> AHCI was not unconditionally enabled, even in IDE mode, when it was
> originally added...  :/
..

Yeah, that one's always puzzled me.
It's just software,  so why don't we do it?  In the PCI layer, that is?
