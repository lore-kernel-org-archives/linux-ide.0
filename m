From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Build Failure] 2.6.25-rc5-mm1 Build fails with allmodconfig
 probe_4drives undefined
Date: Tue, 11 Mar 2008 10:41:37 -0700
Message-ID: <20080311104137.3c6b3f22.akpm@linux-foundation.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D68126.40109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47812 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754314AbYCKRmB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 13:42:01 -0400
In-Reply-To: <47D68126.40109@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, apw@shadowen.org

On Tue, 11 Mar 2008 18:25:02 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> The 2.6.25-rc5-mm1 kernel build fails with allmodconfig 
> 
>   MODPOST 2279 modules
> ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!

Yes, it has been doing this for a while.  But apparently it doesn't happen
for Bart with just his patch queue.  <slightlypeeved>If your subssytem
fails in my tree, that doesn't automatically make it my
problem</slightlypeeved>

I'll take a look, see what went wrong.
