From: CaT <cat@zip.com.au>
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Wed, 27 Oct 2004 23:34:31 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041027133431.GF1127@zip.com.au>
References: <58cb370e04102706074c20d6d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nessie.weebeastie.net ([220.233.7.36]:25735 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262437AbUJ0NfF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 09:35:05 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e04102706074c20d6d7@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:07:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> <bzolnier@trik.(none)> (04/10/26 1.2192)
>    [ide] pdc202xx_old: PDC20267 needs the same LBA48 fixup as PDC20265

What would the symptoms of this bug be? I've got a PDC20267 and I'm
having a few issues transferring from hde to hdh (ie across two ports)
it seems. My work at duplicating things seems to work best when I do a
transfer like that rather then going from say, a totall different
controller to the pdc (hdh) or even from generated input to the pdc (hdh).

-- 
    Red herrings strewn hither and yon.
