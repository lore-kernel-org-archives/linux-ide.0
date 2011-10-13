From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/3] pata_serverworks: cleanup cable detection
Date: Thu, 13 Oct 2011 13:50:36 +0100
Message-ID: <20111013135036.6b95be36@lxorguk.ukuu.org.uk>
References: <201110112011.44748.bzolnier@gmail.com>
	<201110121705.39026.bzolnier@gmail.com>
	<20111012185548.4fa03544@lxorguk.ukuu.org.uk>
	<201110131232.18514.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57345 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752705Ab1JMMvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 08:51:49 -0400
In-Reply-To: <201110131232.18514.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] pata_serverworks: cleanup cable detection
> 
> Merge identical cable routines for Dell and Sun systems into
> common oem_cable() one.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> v2: updated patch description
> 
> earlier references:
> https://lkml.org/lkml/2010/1/18/324

Acked-by: Alan Cox <alan@linux.intel.com>
