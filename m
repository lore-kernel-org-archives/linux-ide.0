From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Too async libata breakage
Date: Thu, 8 Jan 2009 11:28:40 -0800
Message-ID: <20090108112840.46e3f063@infradead.org>
References: <b6fcc0a0901081115n1174aebj5f6a3fbb8adea789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53262 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759933AbZAHT0n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jan 2009 14:26:43 -0500
In-Reply-To: <b6fcc0a0901081115n1174aebj5f6a3fbb8adea789@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: torvalds@osdl.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Thu, 8 Jan 2009 22:15:56 +0300
"Alexey Dobriyan" <adobriyan@gmail.com> wrote:

> commit f29d3b23238e1955a8094e038c72546e99308e61 aka
> "fastboot: Make libata initialization even more async"
> results in no findable /dev/sda2 to mount / here.
> 
> Kernel correctly sees sda as 750GB drive and the rest too.
> 
> CONFIG_ATA_PIIX is in use, everything built-in, plain partitions,
> no initrd, DM, MD etc.

hmm. 
no initrd; 

can you try an experiment?
if you edit init/do_mounts.c and find the "async_synchronize_full" call.
that is just after a while() loop. 
Can you put another call to synchronize_full to also just before that
while loop and see if that fixes it ?

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
