From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy fix
Date: Wed, 23 Jul 2008 20:51:11 +0200
Message-ID: <200807232051.12226.bzolnier@gmail.com>
References: <20080715053356.GA18628@gollum.tnic> <200807222149.19939.bzolnier@gmail.com> <20080723063224.GB17724@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:7588 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbYGWSzL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 14:55:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so940068nfc.21
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 11:55:10 -0700 (PDT)
In-Reply-To: <20080723063224.GB17724@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@kernel.org

On Wednesday 23 July 2008, Borislav Petkov wrote:

[...]

> > Now it should be finally fixed.
> 
> True story. Works here too.

Thanks for verifying it.

> Hm, let's see whether there's time during the weekend. I already have something
> stolen from pata_legacy but I'll do some more testing first. By the way, what
> are the chances of exporting those pieces of code from drivers/ata/pata_legacy.c
> and adding the function def into some header instead of duplicating the code into
> ide_generic.c?

Good idea (<linux/ata.h> sounds like a perfect spot).

Thanks,
Bart
