From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pata_hpt37x: unify ->pre_reset methods
Date: Thu, 19 Nov 2009 18:24:57 +0000
Message-ID: <20091119182457.56545e7d@lxorguk.ukuu.org.uk>
References: <200911191912.24663.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37703 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751893AbZKSSW5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 13:22:57 -0500
In-Reply-To: <200911191912.24663.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Nov 2009 19:12:24 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> We can use the same ->pre_reset method for all HPT37x chipsets now.

Nice clean up

Acked-by: Alan Cox <alan@linux.intel.com>
