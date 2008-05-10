From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH 1/6] sgiioc4: use ->extra_base instead of ->dma_status for dma_handle
Date: Sat, 10 May 2008 02:41:19 -0700
Message-ID: <20080510094119.GD36873@sgi.com>
References: <200805071939.41558.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:56223 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752356AbYEJJlW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 May 2008 05:41:22 -0400
Content-Disposition: inline
In-Reply-To: <200805071939.41558.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 07, 2008 at 07:39:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This is a preparation for removal of ->dma_status field from ide_hwif_t.
> 
> There should be no functional changes caused by this patch.
> 
> Cc: Jeremy Higdon <jeremy@sgi.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Jeremy Higdon <jeremy@sgi.com>
