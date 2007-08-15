From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: fix n_sectors failure handling
 during revalidation
Date: Wed, 15 Aug 2007 19:11:59 +0100
Message-ID: <20070815191159.18d66575@the-village.bc.nu>
References: <20070815180222.GC21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56881 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752241AbXHOSEM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:04:12 -0400
In-Reply-To: <20070815180222.GC21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, 16 Aug 2007 03:02:22 +0900
Tejun Heo <htejun@gmail.com> wrote:

> If revalidation fails because device has different n_sectors after
> configuration the original n_sectors should be restored before failing
> revalidation.  Without this fix, n_sectors difference will incorrectly
> and silently pass revalidation when revalidation is retried.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Eeep

Acked-by: Alan Cox <alan@redhat.com>
