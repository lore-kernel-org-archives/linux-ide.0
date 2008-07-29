From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide pmac breakage
Date: Tue, 29 Jul 2008 15:20:57 +1000
Message-ID: <1217308857.11188.237.camel@pasglop>
References: <1217208596.11188.144.camel@pasglop>
	 <1217210545.11188.146.camel@pasglop>
	 <200807281631.56446.bzolnier@gmail.com>
	 <20080729141750V.fujita.tomonori@lab.ntt.co.jp>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51205 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572AbYG2FVS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Jul 2008 01:21:18 -0400
In-Reply-To: <20080729141750V.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, petkovbb@gmail.com

On Tue, 2008-07-29 at 14:17 +0900, FUJITA Tomonori wrote:
> If q->elevator is NULL, the media-bay code might mess up the ref
> counting of the request queue...

Well, all I do is call into Bart's new helpers to scan for or unregister
devices ...

Ben.


