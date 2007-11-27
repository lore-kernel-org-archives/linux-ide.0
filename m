From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
 nodes
Date: Tue, 27 Nov 2007 20:34:11 +0300
Message-ID: <474C5513.6010801@ru.mvista.com>
References: <20071127153708.GA12490@localhost.localdomain> <20071127153940.GC14183@localhost.localdomain> <474C3C79.5060908@ru.mvista.com> <20071127164101.GA14790@localhost.localdomain> <474C49D5.2000206@ru.mvista.com> <20071127173456.GA15693@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:44503 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755368AbXK0Rd6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 12:33:58 -0500
In-Reply-To: <20071127173456.GA15693@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Anton Vorontsov wrote:

>>>2. "ioport" because shift^Wstride ;-) applies only to the io range
>>>  (yes, it's obvious, but worth open-wording, no?).

>>   Contrarywise, to memory range.

> By io range I meant "I/O base", in contrast to "CTL base".

> There is no need to apply shifting for CTL. That's why ioport-*
> appeared in the first place.

    So, a matter of wrong terminology then. The thing that you meant by "I/O" 
is actually called "command block".

MBR, Sergei
