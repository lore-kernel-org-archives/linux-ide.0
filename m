From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2 #upstream] libata: assume ATA_DEV_ATA on diagnostic
 failure
Date: Wed, 8 Aug 2007 09:33:26 +0100
Message-ID: <20070808093326.345b30a5@the-village.bc.nu>
References: <20070808053739.GS13674@htj.dyndns.org>
	<20070808054008.GT13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59984 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754077AbXHHI0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 04:26:07 -0400
In-Reply-To: <20070808054008.GT13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, amsden_linux@earthlink.net

On Wed, 8 Aug 2007 14:40:08 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Certain device which reports diagnostic failure also reports invalid
> device signature.  Assume ATA_DEV_ATA on diagnostic failure if reset
> indicates device presence.
> 
> This is fix for bugzilla bug 8784.

Acked-by: Alan Cox <alan@redhat.com>
