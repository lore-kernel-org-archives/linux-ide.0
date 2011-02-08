From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Tue, 8 Feb 2011 13:07:01 +0000
Message-ID: <20110208130701.19709cc6@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43895 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753645Ab1BHND1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:03:27 -0500
In-Reply-To: <20110208122409.19110.4233.sendpatchset@linux-mhg7.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 08 Feb 2011 13:24:09 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> >From 8acc9371550ce5f98da56f6888ae4b898096ed2c Mon Sep 17 00:00:00 2001
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 8 Feb 2011 12:39:25 +0100
> Subject: [PATCH 05/20] pata_efar: always program master_data before slave_data
> 
> We may need to set SITRE before programming slave_data.

Do you have a documentation cite for this or is it random fiddling with a
driver you can't test ?
