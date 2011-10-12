From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] pata_serverworks: cleanup cable detection
Date: Wed, 12 Oct 2011 17:05:38 +0200
Message-ID: <201110121705.39026.bzolnier@gmail.com>
References: <201110112011.44748.bzolnier@gmail.com> <20111011205141.7a8bac1c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56871 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1JLP2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 11:28:41 -0400
In-Reply-To: <20111011205141.7a8bac1c@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Tue, 11 Oct 2011 20:11:44 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_serverworks: cleanup cable detection
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Again no documentation although its at least a bit more obvious why

The patch only merges identical cable routines for Dell and Sun
systems into common oem_cable() one.  No behavior changes here.
