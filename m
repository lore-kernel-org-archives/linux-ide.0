From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCHSET] libata: improve ata_bus_probe failure handling, take 2
Date: Tue, 4 Apr 2006 09:02:18 -0400
Message-ID: <87f94c370604040602i7b9a5bbfu6c9285d77c5f75ed@mail.gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
	 <442FE142.7030304@pobox.com> <4430ECEF.30307@tw.ibm.com>
	 <4430FB37.6040600@pobox.com>
	 <87f94c370604030737y7ef96ed8g5d887ff768845956@mail.gmail.com>
	 <44314B32.1070004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from uproxy.gmail.com ([66.249.92.194]:14998 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932397AbWDDNCU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Apr 2006 09:02:20 -0400
Received: by uproxy.gmail.com with SMTP id c2so842212ugf
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2006 06:02:18 -0700 (PDT)
In-Reply-To: <44314B32.1070004@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 4/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Greg Freemyer wrote:
> > On 4/3/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >> For the record, I do consider irq-pio upstream ready.  It still needs to
> >> wait for Tejun's EH work to make it upstream, to give upstream people
> >> the test sets of
> >>
> >>         - prep EH (2.6.17-rc1)
> >>         - EH
> >>         - NCQ
> >>         - irq-pio
> >>
> >> Since each of these sets is staged, upstream testers will be able to say
> >> "2.6.17-rc1 works, but 2.6.18-git1 doesn't", which gives us a lot of
> >> good info.
> >>
> >>         Jeff
> >
> > So for those of us anxiously waiting for the above great enhancements
> > it looks like it will be 5 months or so before it is in a released
> > vanilla kernel?  ie. assuming 2 1/2 months per kernel release.
>
> Heavens no :)
>
> The stages above just need to be separated out by a few 2.6.X-gitX or
> 2.6.X-rcX releases.
>
>         Jeff

I'm confused.  You just poseted:

> Due to the merge window closing, the three pending patchsets will be in
> 2.6.18.

That sure sounds like 5 months before it is in a released vanilla
kernel.  ie. it has been taking about 10 weeks per kernel release. 
2.6.17 is likely to take another 8 weeks.  Then 10 weeks for 2.6.18 to
come out.

It seems that the only way around it is to petition Linus to get as
much of the above into 2.6.17 as possible.  Somehow I doubt that will
be successful, but I don't monitor LKML, so I don't know if he ever
responds to requests like that or not.

Greg
--
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
