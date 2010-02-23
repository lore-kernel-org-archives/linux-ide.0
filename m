From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patch] atang tree: enhanced SSD detection
Date: Tue, 23 Feb 2010 13:13:52 +0100
Message-ID: <201002231313.52569.bzolnier@gmail.com>
References: <201002211841.24936.bzolnier@gmail.com> <4B8370D5.1070302@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:43176 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab0BWMVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 07:21:05 -0500
In-Reply-To: <4B8370D5.1070302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 23 February 2010 07:08:21 am Jeff Garzik wrote:
> On 02/21/2010 12:41 PM, Bartlomiej Zolnierkiewicz wrote:
> > DISCLAIMER: the fact of getting patches merged into atang tree means
> > that from now on they will be getting updates for changes happening
> > in atang tree and it should not be treated as an indication regarding
> > decisions taken by 'upstream' kernel trees
> >
> >
> > Improve SSD detection so block layer optimizations can be applied
> > to many more SSD devices.
> >
> >
> > The following changes since commit 17c619273d412ed7b6120e448f87b2329457fc90:
> >    Bartlomiej Zolnierkiewicz (1):
> >          pata_oldpiix: enable parallel scan
> >
> > are available in the git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/bart/misc.git atang-v4.7
> >
> > Bartlomiej Zolnierkiewicz (1):
> >        libata: enhanced SSD detection
> >
> >   drivers/ata/libata-core.c |    3 +++
> >   drivers/ata/libata-scsi.c |   18 ++++++++++--------
> >   include/linux/libata.h    |    1 +
> >   3 files changed, 14 insertions(+), 8 deletions(-)
> >
> >
> > commit ded92e0d01fbb7f27bec7a35606847a2547e95e0
> > Author: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > Date:   Sun Feb 21 18:31:18 2010 +0100
> >
> >      libata: enhanced SSD detection
> >
> >      Many SSD devices predate or just don't implement non-rotational
> >      media type advertisement through the word 217 of the id block so
> >      check also the product id for 'SSD' substring to automatically
> >      detect SSD devices and apply relevant block layer optimizations.
> >
> >      This is based on earlier Jeff Garzik's patch from April 2009:
> >      http://lkml.org/lkml/2009/4/7/495
> >
> >      While at it:
> >      - cleanup ata_scsi_dev_config() a bit
> >
> >      Tested with ASUS-PHISON SSD devices found in Asus Eee 901.
> >
> >      Cc: Jeff Garzik<jeff@garzik.org>
> >      Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> 
> Yes, I agree we need something like this.  I will review for atang 
> dependencies, and then make sure it gets applied to upstream.
> 
> The previous discussion of this approach concluded weakly with "poor 
> heuristic", but a better approach did not materialize.
> 
> One question, though:  why did you drop ata_id_is_ssd() test?

This test is not in the 'upstream' any longer as 'standard' detection
is now handled through libata-scsi emulation layer (after SSD related
SCSI changes made by Martin K. Petersen, commit f17259a etc).

--
Bartlomiej Zolnierkiewicz
