From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata-acpi: filter out DIPM enable
Date: Sun, 6 Jul 2008 16:25:52 +0100
Message-ID: <20080706162552.47f39a6e@lxorguk.ukuu.org.uk>
References: <4870D367.40106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44965 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753440AbYGFPn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 11:43:57 -0400
In-Reply-To: <4870D367.40106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mathieu =?UTF-8?B?QsOpcmFyZA==?= <Mathieu.Berard@crans.org>

On Sun, 06 Jul 2008 23:15:03 +0900
Tejun Heo <tj@kernel.org> wrote:

> Some BIOSen enable DIPM via _GTF which causes command timeouts under
> certain configuration.  This didn't occur on 2.6.25 because 2.6.25
> defaulted to SRST, so _GTF wasn't executed during boot probe, so ahci
> host reset disabled DIPM and as _GTF wasn't executed after SRST, DIPM
> wasn't enabled.  On 2.6.26, hardreset is used during probe and after
> probe _GTF is executed enabling DIPM and thus the failures.
> 
> This patch could theoretically disable DIPM on machines which used to
> have it enabled on 2.6.25 but AFAIK ahci is currently the only driver
> which uses SATA ACPI hierarchy (_SDD) and as the host reset would have
> always disabled DIPM, this shouldn't happen.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Alan Cox <alan@redhat.com>
