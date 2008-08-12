From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/22] ide: add ide_set_media_lock() helper
Date: Tue, 12 Aug 2008 19:48:30 +0200
Message-ID: <200808121948.31030.bzolnier@gmail.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <200808121105.49645.bzolnier@gmail.com> <9ea470500808120637w354b3ae0w3ceca791344bd7cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:31751 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYHLRu6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 13:50:58 -0400
Received: by nf-out-0910.google.com with SMTP id d3so905934nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 10:50:56 -0700 (PDT)
In-Reply-To: <9ea470500808120637w354b3ae0w3ceca791344bd7cc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 12 August 2008, Boris Petkov wrote:
> >> Are we switching to SCSI opcodes? What about the generic packet commands in
> >> <include/linux/cdrom.h>?
> >
> > I prefer to use them when possible but there is no strict policy.
> >
> > [ SCSI defines are shorter, one of the drivers was using them already
> >  and it also makes easier for comparing code with SCSI. ]
> 
> I still think we should stick to one format or the other. All
> the drivers' functions, for example, comply with a naming scheme
> (ide_cd/ide_floppy/...) so opcodes shouldn't be an exception, imho...

Some opcodes are only in <linux/cdrom.h> while the other ones only
in <scsi/scsi.h> so it is not that simple without additional effort.

I don't have a time for it at the moment (+ I consider it a low-prio
task).  However if you would like to look into it, please go ahead.

Thanks,
Bart
