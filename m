From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 15:51:14 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04102706512283405@mail.gmail.com>
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
	 <20041027133431.GF1127@zip.com.au>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:18952 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262443AbUJ0NvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Oct 2004 09:51:16 -0400
Received: by wproxy.gmail.com with SMTP id 68so309319wri
        for <linux-ide@vger.kernel.org>; Wed, 27 Oct 2004 06:51:15 -0700 (PDT)
In-Reply-To: <20041027133431.GF1127@zip.com.au>
List-Id: linux-ide@vger.kernel.org
To: CaT <cat@zip.com.au>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2494

On Wed, 27 Oct 2004 23:34:31 +1000, CaT <cat@zip.com.au> wrote:
> On Wed, Oct 27, 2004 at 03:07:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > <bzolnier@trik.(none)> (04/10/26 1.2192)
> >    [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265
> 
> What would the symptoms of this bug be? I've got a PDC20267 and I'm
> having a few issues transferring from hde to hdh (ie across two ports)
> it seems. My work at duplicating things seems to work best when I do a
> transfer like that rather then going from say, a totall different
> controller to the pdc (hdh) or even from generated input to the pdc (hdh).
> 
> --
>     Red herrings strewn hither and yon.
