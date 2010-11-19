From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH #upstream-fixes] sata_via: apply magic FIFO fix to
 vt6420 too
Date: Fri, 19 Nov 2010 15:40:36 +0100
Message-ID: <1290177636.2109.1608.camel@laptop>
References: <4CE689BF.40703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52985 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab0KSOk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2010 09:40:26 -0500
In-Reply-To: <4CE689BF.40703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Joseph Chan <JosephChan@via.com.tw>, q@maq.dk, stable <stable@kernel.org>

On Fri, 2010-11-19 at 15:29 +0100, Tejun Heo wrote:
> vt6420 has the same FIFO overflow problem as vt6421 when combined with
> certain devices.  This patch applies the magic fix to vt6420 too.

Thanks!
