From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [git patches] libata (and devres) fixes
Date: Sat, 10 Mar 2007 16:28:52 +0100
Message-ID: <b637ec0b0703100728i5a38e17boe370c86c02791e02@mail.gmail.com>
References: <20070309163148.GA12848@havoc.gtf.org>
	 <b637ec0b0703091324q7f15fddbpc8c24b4e1131e3f4@mail.gmail.com>
	 <20070309234839.2070a265@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:9049 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161071AbXCJP2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 10:28:53 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1188061wxd
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 07:28:53 -0800 (PST)
In-Reply-To: <20070309234839.2070a265@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Maybe KERN_DEBUG instead of KERN_ERR?


On 3/10/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > scsi1 : ata_piix
> > ata2: port disabled. ignoring.
> > ata2: reset failed, giving up    <--- THIS IS NEW.
> >
> > However, I think it's just bogus as there is ata2 is disabled on this laptop.
>
> This is expected behaviour and it is what every controller except the
> PIIX has done for some time. I'm not sure its perfect but we could return
> 0 from the -ENOENT case in ata_eh_reset() if that is preferred.
>
>
