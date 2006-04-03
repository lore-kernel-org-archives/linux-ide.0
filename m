From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take 2
Date: Mon, 3 Apr 2006 10:37:23 -0400
Message-ID: <87f94c370604030737y7ef96ed8g5d887ff768845956@mail.gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
	 <442FE142.7030304@pobox.com> <4430ECEF.30307@tw.ibm.com>
	 <4430FB37.6040600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.199]:34773 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751608AbWDCOhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Apr 2006 10:37:24 -0400
Received: by uproxy.gmail.com with SMTP id c2so690964ugf
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 07:37:23 -0700 (PDT)
In-Reply-To: <4430FB37.6040600@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 4/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:

> For the record, I do consider irq-pio upstream ready.  It still needs to
> wait for Tejun's EH work to make it upstream, to give upstream people
> the test sets of
>
>         - prep EH (2.6.17-rc1)
>         - EH
>         - NCQ
>         - irq-pio
>
> Since each of these sets is staged, upstream testers will be able to say
> "2.6.17-rc1 works, but 2.6.18-git1 doesn't", which gives us a lot of
> good info.
>
>         Jeff

So for those of us anxiously waiting for the above great enhancements
it looks like it will be 5 months or so before it is in a released
vanilla kernel?  ie. assuming 2 1/2 months per kernel release.

Not as good as I hoped, but not horrible either.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
