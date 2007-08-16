From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels -
 shutdown too - BISECTED
Date: Thu, 16 Aug 2007 15:22:31 +0400
Message-ID: <46C43377.5030503@wasp.net.au>
References: <46C11BBE.6010802@wasp.net.au> <46C1316F.4010906@wasp.net.au> <46C1DB92.7080806@wasp.net.au> <46C2B046.7060708@gmail.com> <46C3273F.1070306@wasp.net.au> <46C3E3F7.2010803@gmail.com> <46C402AE.6010605@wasp.net.au> <46C430A2.7040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:51540 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759128AbXHPLWg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 07:22:36 -0400
In-Reply-To: <46C430A2.7040001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> Any attempt to spin down sdi-sdo in any order locks hard. Any attempt to
>> spin down sda-sdh works in any combination/permutation.
> 
> Hmmm... I'm out of ideas.  It definitely sounds like some sort of
> hardware problem to me.  I think the best way to diagnose the problem is
> playing the tedious but often rewarding add-remove-swap game with the
> hardware and see to which piece or combination of pieces the problem is
> attached.

The problem appears to be having more than 2 Promise cards in the system. Both machines have >2 
cards (one has 3 and the other has 4) and they both lock up on shutdown in the same fashion (first 8 
drives are ok, then it locks).

Between this and the intermittent BUS Errors under load, perhaps I toss the promise cards and 
upgrade to some 4 port SIL cards instead.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
