From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/4] Series short description
Date: Mon, 11 May 2009 13:33:42 -0400
Message-ID: <4A086176.8030007@garzik.org>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>	<4A085EA7.4070104@garzik.org> <20090511182513.5ed7ab9b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53828 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbZEKRdn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 13:33:43 -0400
In-Reply-To: <20090511182513.5ed7ab9b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> On Mon, 11 May 2009 13:21:43 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>> A quick batch of PIIX updates
>>> ---
>>>
>>> Alan Cox (4):
>>>       ata_piix: Remove stale comment
>>>       ata_piix: Turn on hotplugging support for older chips
>>>       ata_piix: The Sony TZ90 needs the cable type hardcoding
>>>       ata_piix: ICH7 does not support correct MWDMA timings
>> I guess 1 & 2 are #upstream-fixes material, and 3 & 4 are #upstream ?
> 
> I'd say they are all fixes. In terms of urgency #4 hasn't been reported
> by anyone it was found when checking errata, #3 is a real problem
> encountered by users #2 affects only fairly obscure hardware and isn't a
> regression, #1 is a comment.

I was referring to the patch numbering provided by you, in your 
submission, which is the reverse of the order listed above:

patch #1: ICH7 MWDMA timings
patch #2: TZ90
patch #3: turn on hotplugging
patch #4: fix comment

patch #3 is a behavior change IMO very late in -rc cycle, and patch #4 
is not urgent.

	Jeff



