From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc5] libata: be less verbose about hpa
Date: Mon, 25 Jun 2007 13:12:59 +0100
Message-ID: <20070625131259.62d7b79f@the-village.bc.nu>
References: <467FAAF2.9080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44529 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343AbXFYMHJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:07:09 -0400
In-Reply-To: <467FAAF2.9080104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, 25 Jun 2007 20:45:54 +0900
Tejun Heo <htejun@gmail.com> wrote:

> There's no reason to print out hpa related messages when HPA is not
> active.  Kill the unconditional message and add a warning message
> which is printed if HPA size is smaller than the current size.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

(Should it be a dprintk instead of vanish though ?)

