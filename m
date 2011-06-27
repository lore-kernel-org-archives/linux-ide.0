From: Mark Lord <mlord@pobox.com>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Sun, 26 Jun 2011 21:29:25 -0400
Message-ID: <4E07DCF5.1090506@pobox.com>
References: <20110626070820.GC24867@merlins.org>
 <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
 <20110627000614.GA5362@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756167Ab1F0B32 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2011 21:29:28 -0400
In-Reply-To: <20110627000614.GA5362@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On 11-06-26 08:06 PM, Marc MERLIN wrote:
> Speaking of which, what sata chips are recommended nowadays for PMP outside
> sil24 cards?

Well, sata_mv cards were once *the* best cards going for PMP.
Nowadays though, none of the chipsets I have here work with all
of the PMPs I have here.

JMicron are the most common eSATA chips on motherboards,
but even they have PMP troubles with Linux (but not with Windows).

So.. dunno.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
