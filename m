From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: LibATA ATAPI-Found lockup spot.
Date: Tue, 18 Jan 2005 21:35:50 +0100
Message-ID: <58cb370e05011812354b35494e@mail.gmail.com>
References: <20050118191122.4DC7ACA0AF@ws7-4.us4.outblaze.com>
	 <41ED66D8.2040808@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:57578 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261272AbVARUfv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2005 15:35:51 -0500
Received: by wproxy.gmail.com with SMTP id 67so13467wri
        for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2005 12:35:50 -0800 (PST)
In-Reply-To: <41ED66D8.2040808@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kien Pham <kienca@lycos.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Tue, 18 Jan 2005 14:43:20 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Kien Pham wrote:
> > Hi Jeff,
> >
> > It blocks forever on line 2450 of libata-core.c. This is on vanilla
> > 2.6.10 kernel source. Relevent snippet follows so you don't have to dig.
> > Basically, the middle SCSI layer successfully sends 3 INQUIRY commands.
> > Then it sends a REPORT LUNs command that fails with a status 0x50. The
> > error register reads 0x60 at this point. Then the ATAPI layer sends a
> > REQUEST SENSE which never completes because an interrupt never occurs
> > and we're stuck at line 2450 waiting for completion. O.K. I know the how
> > it happens, any ideas on the why? Or am I on my own? :)
> 
> I think Bart mentioned something about problems with REPORT LUNS... I
> bet things would work if we didn't send that command...

There were problems before we supported REQUEST SENSE.
AFAIR ide-scsi sends REPORT LUNS so it should be also OK for libata...
