From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_cs5520: remove incorrect warning message
Date: Wed, 12 Oct 2011 17:27:46 +0200
Message-ID: <201110121727.46778.bzolnier@gmail.com>
References: <201110112000.44960.bzolnier@gmail.com> <20111011205616.15d0b3b3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56871 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab1JLP2t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 11:28:49 -0400
In-Reply-To: <20111011205616.15d0b3b3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Tue, 11 Oct 2011 20:00:44 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_cs5520: remove incorrect warning message
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Nothing incorrect about it. It's rather useful information for debugging
> CS5520 problems. Users should never see it - and I've not seen it
> occuring on any standard VSA releases.
> 
> Do you have any examples of it confusing users or even showing up ? 

This driver dooen't even use DMA mode so warning about forcing the setting
may be puzzling.  In addition we do the same thing cs5520_reinit_one()
but without warning the user this time.  Thus removal of the warning makes
it easier for *_reinit_one() replacement by ->init_host method later
(patch is ready for this).
