From: Mark Lord <mlord@pobox.com>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Tue, 28 Jun 2011 23:53:37 -0400
Message-ID: <4E0AA1C1.6020406@pobox.com>
References: <20110626070820.GC24867@merlins.org>
 <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
 <20110629034125.GC32153@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab1F2Dxj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2011 23:53:39 -0400
In-Reply-To: <20110629034125.GC32153@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On 11-06-28 11:41 PM, Marc MERLIN wrote:
..
> So it seems it was a false alarm after all, I'll report back if I have
> problems again, but it looks like it's working solidly and for what it's
> worth with 5 drives and software raid 5, I can both read and write files
> at about 115MB/s, which isn't too shabby :)


Mmm.. power everything OFF, wait a few seconds,
then power on and verify that it all still works.

Thanks
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
