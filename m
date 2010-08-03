From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Can you guys please take a look at bko#16434?
Date: Mon, 02 Aug 2010 22:58:20 -0400
Message-ID: <4C5785CC.4060603@teksavvy.com>
References: <4C4AA8A2.4030107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:1207 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752718Ab0HCC6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Aug 2010 22:58:23 -0400
In-Reply-To: <4C4AA8A2.4030107@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Saeed Bishara <saeed@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 10-07-24 04:47 AM, Tejun Heo wrote:
> Hello,
>
> It looks like sata_mv triggers BUG_ON() when a command it doesn't know
> about is issued and discard support makes it happen.  Can you guys
> take a look?  And please update it such that it doesn't trigger
> BUG_ON() only because an unknown command is issued.  That's way too
> dangerous.  If void return from qc_prep is a problem, just move the
> whole qc_prep into qc_issue, the distinction is pretty arbitrary
> anyway.
..

I've been away on holiday for the past few weeks,
but I did make a note on the bugzilla entry for this
that there were two problems to be addressed.

Now that I'm back in the office, I'll have a look at this later
in the week, and see about getting TRIM working with sata_mv,
if possible.

Cheers
