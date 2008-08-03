From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 3 Aug 2008 15:37:40 +0200
Message-ID: <200808031537.41224.bzolnier@gmail.com>
References: <20080715053356.GA18628@gollum.tnic> <20080803073756.GA8762@gollum.tnic> <20080803125907.67676948@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:14049 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbYHCNkj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 09:40:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1479626fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 06:40:37 -0700 (PDT)
In-Reply-To: <20080803125907.67676948@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: petkovbb@gmail.com, petkovbb@googlemail.com, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

On Sunday 03 August 2008, Alan Cox wrote:
> On Sun, 3 Aug 2008 09:37:56 +0200
> Borislav Petkov <petkovbb@googlemail.com> wrote:
> 
> > Ok, here's a definitely better solution:
> 
> Please don't stuff large important pieces of code in header files where
> they will be overlooked
> 
> NAK this.
> 
> I'm happy to have a shared library directory for ATA stuff, containing
> useful C code, but hiding stuff in headers like that is just plain wrong.

The code in question is 65 LOC total (43 LOC without counting comments)
so having a shared library just for it sounds like an overkill and we may
just copy that one function from pata_legacy to ide_generic instead.

Jeff, what is your stance here?
