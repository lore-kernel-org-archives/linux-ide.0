From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] sata_via: use old SCR access pattern on vt6420
Date: Tue, 22 Aug 2006 18:17:06 +0200
Message-ID: <20060822181706.c7438002.ak@suse.de>
References: <200608141533.35448.ak@suse.de>
	<20060816051228.GH6371@htj.dyndns.org>
	<20060822160027.GC21866@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:26002 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751399AbWHVQRK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Aug 2006 12:17:10 -0400
In-Reply-To: <20060822160027.GC21866@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, 23 Aug 2006 01:00:27 +0900
Tejun Heo <htejun@gmail.com> wrote:

 
> Andi, can you please test this patch?  This adds two more SCR accesses
> for link status printing (as in the pre EH code) and prevents all SCR
> accesses once probing is complete.  This should work but I wanna make
> sure.

I tested booted it both 32bit and 64bit and didn't see any hangs.

-Andi
