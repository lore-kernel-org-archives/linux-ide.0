From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 3 Sep 2007 13:03:39 +0100
Message-ID: <6f9550040709030503m1d0db50bo4266aed0475f951d@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com>
	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
	 <46DB755C.308@gmail.com>
	 <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
	 <46DBF430.1050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:64993 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbXICMDo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 08:03:44 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1365076fkz
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 05:03:43 -0700 (PDT)
In-Reply-To: <46DBF430.1050508@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 03/09/07, Tejun Heo <htejun@gmail.com> wrote:
> The report mechanism is simple and the controller doesn't have much to
> do with it.  Bridge chip may affect it but I'm doubtful.

> >
> > My X41 has a 1.5Ghz P4M, and a 0.1MB/s hit (if it is using PIO) is
> > hardly going to make a dent - I'm fairly sure that it is spending most
> > of its time waiting for IO, but I shall take a deeper look tonight.
>
> The beautiful thing about PIO is that it doesn't matter how fast your
> cpu is.  Faster CPUs will just burn more cycles while transferring data
> at the same measly speed. :-)

Ahh yes, that makes sense - it's more about the time it takes rather
than the cycles consumed...

> > What's confusing me is that my 40MB/s card only supporting MWDMA2 -
> > which offers only a max transfer rate of 16.7MB/s - how have other
> > people achieved 30MB/s then!?! (I'm referring to an ICH8 user who
> > claims he has here, with a very similar CF card:
> > http://www.opensubscriber.com/message/linux-ide@vger.kernel.org/6818048.html
>
> Whatever the device is, it should support UDMA to do 30MB/s.  MWDMA2
> just can't reach that speed electronically.

Sorry, I was implying that he mustn't be using MWDMA to achieve them
sort of speeds, and indeed from his hdparm -I he is not. I'm currently
in touch with an X41 user who has reported success with a different CF
card, who is getting 35MB/s and 0.2ms access time under Windows
*drool*

> > Also, does libATA support the PIO5 and PIO6 modes, which according to
> > Wikipedia are not part of the ATA standard, but the CF 2.0 standard?
> > (source: http://en.wikipedia.org/wiki/Programmed_input/output )
>
> I dunno much about those fancy PIO modes.  Maybe Alan knows?

>From the wiki article, I get the impression that the faster PIO modes
are simply lower cycle times, with everything else more or less the
same - so that shouldn't be too hard to add if it's not already there?
More importantly I guess, I wonder if hdparm -I supports the detection
of pio5 or pio6? I'll dig into the sources later.

Thanks,

Eddie
