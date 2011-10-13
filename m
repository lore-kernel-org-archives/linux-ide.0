From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] pata_oldpiix: enable parallel scan
Date: Thu, 13 Oct 2011 18:06:08 +0200
Message-ID: <201110131806.27248.bzolnier@gmail.com>
References: <201110131603.34443.bzolnier@gmail.com> <20111013164753.69a5e92c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49914 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab1JMQKq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 12:10:46 -0400
In-Reply-To: <20111013164753.69a5e92c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Thu, 13 Oct 2011 16:03:34 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_oldpiix: enable parallel scan
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Have you tested this. When I talked with Intel people about parallel
> scanning nobody in Intel I could find could answer whether it was safe on
> the ancient PIIX versions.

No, it wasn't tested on the real hardware.

I think it should be in libata-dev or -mm/-next for rather long time..
