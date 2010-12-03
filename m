From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata updates for 2.6.37
Date: Fri, 03 Dec 2010 11:10:12 +0100
Message-ID: <4CF8C204.8010904@kernel.org>
References: <4CF52652.4030802@kernel.org> <20101130163150.GA25668@bombadil.infradead.org> <20101130175317.GB25668@bombadil.infradead.org> <20101130210938.GF25668@bombadil.infradead.org> <4CF62EE0.7040607@kernel.org> <20101201124445.GG25668@bombadil.infradead.org> <4CF6595A.6010104@kernel.org> <20101201155026.GH25668@bombadil.infradead.org> <20101201200907.GI25668@bombadil.infradead.org> <4CF77225.3040904@kernel.org> <20101202212346.GK25668@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35898 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab0LCKK3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Dec 2010 05:10:29 -0500
In-Reply-To: <20101202212346.GK25668@bombadil.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hello, Kyle.

On 12/02/2010 10:23 PM, Kyle McMartin wrote:
> On Thu, Dec 02, 2010 at 11:17:09AM +0100, Tejun Heo wrote:
>> Hmmm... something is setting EH_PENDING while EH is in progress.
>> Let's see what's doing it.  Can you please apply the following patch
>> on top of the previous one and report the kernel log?
>>
> 
> This gets triggered a bunch on boot-up:

Yeah, that's expected.  Can you please do the usual testing routine
and trigger the EH giving up message and then attach the full kernel
log?

Thanks.

-- 
tejun
