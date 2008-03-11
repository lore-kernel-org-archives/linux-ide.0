From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Build Failure] 2.6.25-rc5-mm1 Build fails with allmodconfig
 probe_4drives undefined
Date: Tue, 11 Mar 2008 11:19:58 -0700
Message-ID: <20080311111958.c0d3188d.akpm@linux-foundation.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D68126.40109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42966 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752009AbYCKSUr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 14:20:47 -0400
In-Reply-To: <47D68126.40109@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, apw@shadowen.org

On Tue, 11 Mar 2008 18:25:02 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

>   MODPOST 2279 modules
> ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!

Caused by ide-mm-ide-add-ide-4drives-host-driver-take-3.patch.  Applying
that patch alone to current mainline causes the above error after i386
`make allmodconfig'.

Just exporting the symbol doesn't fix it, so something funny is going on.

probe_4drives should not be initialised to zero.

probe_4drives should not be declared extern in drivers/ide/ide.c - please
declare it in a header which is included by the definition site and by all
users.
