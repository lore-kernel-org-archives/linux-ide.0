From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] pata_serverworks: use standard cable detection methods
Date: Wed, 12 Oct 2011 17:03:44 +0200
Message-ID: <201110121704.07439.bzolnier@gmail.com>
References: <201110112009.32126.bzolnier@gmail.com> <20111011204954.2e2280b7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46317 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab1JLP2h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 11:28:37 -0400
In-Reply-To: <20111011204954.2e2280b7@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Tue, 11 Oct 2011 20:09:31 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_serverworks: use standard cable detection methods
> 
> You forgot to explain why, or why you want to do this given its
> explicitly contradictory to the supporting documentation.

The patch doesn't change this.  It only makes use of standard cable
helper routines instead of open-coding driver specific ones (the driver
was added before generic cable helpers were available IIRC). 
