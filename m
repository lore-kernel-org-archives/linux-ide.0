From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Wed, 21 Sep 2005 13:21:58 -0400
Message-ID: <433196B6.8000607@rtr.ca>
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751274AbVIURWD@vger.kernel.org>
In-Reply-To: <1127321829.18840.18.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> 
> I can't comment on the MMC layer or its core requirements as I don't
> know them well. IDE PCMCIA does however encompass removal devices. The
> removable flag is set so that we get removable media behaviour - that is
> the media can change under us and we must not cache partition data. The
> current behavioiur in that sense is correct.

Mmm.. I'm not so sure about that.

In the case of CF cards in ide-cs, removing the card is equivalent
to removing the entire IDE controller, not just the media.

So "media change" is not what happens here.

But yes, it still should be managed as a removable device,
but we currently seem to be using this bit to mean two things,
as explained by Russell in the given link.

 > http://lkml.org/lkml/2005/1/8/165

Cheers
