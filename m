From: Tejun Heo <htejun@gmail.com>
Subject: Re: v2.6.25: WARNING: at kernel/lockdep.c:2437	__lock_acquire+0xc69/0xfa0()
Date: Sun, 12 Apr 2009 11:11:37 -0700
Message-ID: <49E22ED9.40100@gmail.com>
References: <19f34abd0804200329j3308b081vc0732c3ec5c0b721@mail.gmail.com> <1208782090.7115.179.camel@twins> <480FF821.9050208@gmail.com> <49E0C102.4020705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:45718 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZDMJTq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 05:19:46 -0400
In-Reply-To: <49E0C102.4020705@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vegard Nossum <vegard.nossum@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> (going through old, unresolved email)
> 
> It looks like this might still be needed?  I never saw an "it works"
> response to this email.

Indeed.  Peter Zijlstra, can you please test it?

-- 
tejun

