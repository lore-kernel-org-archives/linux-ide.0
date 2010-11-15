From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata-via: enable magic transmission fix for vt6420
Date: Mon, 15 Nov 2010 09:28:47 +0100
Message-ID: <4CE0EF3F.3040707@kernel.org>
References: <1289737911.24491.7.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60998 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757623Ab0KOI3E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Nov 2010 03:29:04 -0500
In-Reply-To: <1289737911.24491.7.camel@twins>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hello, Peter.

On 11/14/2010 01:31 PM, Peter Zijlstra wrote:
> I was able to reproduce and test the transmission error on vt6420
> hardware with the 2G WD drives. Adding the controller ID to this fix
> seems to result in a properly working system.

Yeah, there was another report on bugzilla and I contacted Joseph a
few days ago for confirmation.  There are multiple PCI IDs for vt6420
and I think we'll probably have to apply the workaround to all of
them.  Joseph, can you please confirm this?

Thanks.

-- 
tejun
