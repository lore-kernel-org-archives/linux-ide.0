From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Sun, 2 Sep 2007 19:41:22 +0100
Message-ID: <6f9550040709021141m1a76ed37n291274b06a9875fe@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <20070902150423.75687a98@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:26864 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbXIBSlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 14:41:24 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1168137fkz
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 11:41:23 -0700 (PDT)
In-Reply-To: <20070902150423.75687a98@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 02/09/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> O> - MDMA is not really supported, hence why it is so slow - if I can
> > disable mdma and tell it to use single word PIO4, then I might get =
a
> > reasonable 15Mb/s - however extensive searching has shown me that
> > libata doesn't allow a user to set the xfer mode?
>
> libata automatically picks the best mode for the device. Right now it
> doesn't allow hand hacking this. I've got some patches (which I think=
 I
> sent in for the latest -mm) which allow you to specify that pata dma
> doesn't occur for certain classes of device.
>
> > - UDMA is not detected for some reason, even if it is supported by =
the
> > card and by the controller (is there any way to force that to be
> > enabled, regardless of whether it is detected or not?)
> > - Even more worryingly for me, is that Windows also resorts to usin=
g
> > Multiword DMA 2, and it is frightfully slow (which is a big
> > disappointment - seeing as another X41 user (who is undoubtedly usi=
ng
> > windows!) has reported success!) - I am currently trying to get in
> > touch with this user
> > - I bought a card which is too fast for its own good - if only it
> > could only support PIO, then I might not be in this mess! =3D)
>
> If MWDMA2 is also very slow that is suprising. Is Windows in fact
> dropping back to PIO as well ? A lot of CF cards support MWDMA, very =
few
> UDMA. To complicate things many CF convertors do not support MWDMA, q=
uite
> a few are electrically inadequate for UDMA (I guess being defined lon=
g
> before anyone thought about UDMA and CF).
>
> Finally to completely screw you most SATA/PATA convertors don't suppo=
rt
> anything but a few UDMA modes and PIO.
>
> Alan
>

Hello Alan,

Thank you for helping.

In my research on this issue, I do remember coming across an
announcement you made not so long ago regarding the libata.pata_dma
command - however because of my revelations with Windows detailed at
the end of my reply to tejun, I am curious as to whether MWDMA is
really DMA at all? I also believe it runs at about the same speed as
the top PIO speeds too?

In which case, the setting may not be of any help to this scenario.

I'm not sure what Windows is doing - it doesn't like to tell me
anywhere near as much information as Linux does!!

I have one of the new Sandisk Extreme IV cards - which support 40Mb/s
- and it has been reported my various websites that it supports UDMA -
which is only utilised thus far in conjuction with the Sandisk reader.
One such review is here:
http://www.trustedreviews.com/storage/review/2006/09/26/SanDisk-Extreme=
-IV-2GB-CF-Card-Reader-Bundle/p1
=46rom where I quote:
"Before we find out how fast the card is, let's have a look at what
you get for your =A3165. First of all there's the actual card =96 in th=
is
case a 2GB one (the Extreme IV is also available in capacities of 4
and 8GB). The card design is typical of SanDisk but internally, it's
one of the only CF cards that uses a controller compliant with the
UDMA 4 transfer protocol. It also has an extended operating
temperature of -25 to 85C."

Whilst I can accept that 40Mb/s might be an exaggerated
lab-environment-only claim - I certainly would love to see 30Mb/s
which another user claims to have gotten!

I also know that my SATA-PATA arrangement is hardly ideal - but the
controller, using the original HDD, supports udma5 - so I am wondering
why it does not detect, and use, that with the CF card - this brings
me back to the question I originally posed and tejun answered - is
there any way to force it to use UDMA4 - because I know it is
supported by the card?

Also, the CF-IDE bridge is a cheap one (not that there were much
choices) from ebay - and the documentation that comes with it states
that it supports DMA - in which case is there any way I can verify
that? What are the prerequisites for DMA support? (Do certain pins
need to be connected, for example?)

Many, many thanks for your help,

Eddie
