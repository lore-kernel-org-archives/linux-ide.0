From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: clear drvdata in ata_host_release()
Date: Sat, 24 Feb 2007 13:57:54 +0000
Message-ID: <20070224135754.6b64d662@lxorguk.ukuu.org.uk>
References: <20070224074823.GA20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59419 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752272AbXBXMyD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 07:54:03 -0500
In-Reply-To: <20070224074823.GA20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, 24 Feb 2007 16:48:23 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ata_host_release() uses drvdata to determine ata_host to release and
> clearing drvdata in ->remove_one causes NULL pointer deference.  Clear
> drvdata only in ata_host_release() after all resources are freed.
> 
> This bug was first analyzed by Alan Cox for pata_pcmcia.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>

Acked-by: Alan Cox <alan@redhat.com>
