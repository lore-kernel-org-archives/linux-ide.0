From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: remove experimental tag on PATA drivers
Date: Fri, 13 Nov 2009 11:07:50 +0000
Message-ID: <20091113110750.735d7a67@lxorguk.ukuu.org.uk>
References: <4AFCC0D4.9020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42065 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753835AbZKMLGD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2009 06:06:03 -0500
In-Reply-To: <4AFCC0D4.9020708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

On Thu, 12 Nov 2009 20:13:40 -0600
Robert Hancock <hancockrwd@gmail.com> wrote:

> Remove the experimental tag on Parallel ATA drivers. Though some of the
> individual PATA drivers are still marked as experimental, as a group they can
> hardly be considered to be, given they've been used in various distros for some
> time.
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>

And we should probably thin down the EXPERIMENTALs in the drivers too.
I'll take a look at those in a bit
