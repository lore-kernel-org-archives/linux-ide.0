From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Mon, 3 Sep 2007 13:51:47 +0100
Message-ID: <6f9550040709030551n30fe67e8w576a5d7fd9270aec@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com>
	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
	 <46DB755C.308@gmail.com>
	 <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
	 <46DBF430.1050508@gmail.com>
	 <6f9550040709030503m1d0db50bo4266aed0475f951d@mail.gmail.com>
	 <6f9550040709030520q1682ca06k99a2537cae847ec6@mail.gmail.com>
	 <46DC00D8.30205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:48600 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbXICMvt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Sep 2007 08:51:49 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1196812nfh
        for <linux-ide@vger.kernel.org>; Mon, 03 Sep 2007 05:51:47 -0700 (PDT)
In-Reply-To: <46DC00D8.30205@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 03/09/07, Tejun Heo <htejun@gmail.com> wrote:
> Eddie Hung wrote:
> > I am pursuing another possibility: the CF card is not a genuine
> > Sandisk one at all, especially as it was off eBay! I compared my
> > hdparm -I with the one in the thread above (which as I've found out is
> > a Sandisk Extreme II 4GB) and there are big differences, namely the
> > model number, serial number and firmware version.
> >
> > This might explain everything!
>
> We still need to fix your device.  :-)
>

Haha.. well if the CF card is cheap knockoff which doesn't support
MDMA (or does it extremely, extremely badly) then we have our culprit!

I am beginning to be more and more inclined to think that it's a fake
(the packaging and presentation was the genuine deal, though!) - and
I'm in touch with Sandisk to confirm. I've not found that much
information on the Internet - but one particularly interesting post is
that another user had bought a Kingston card off ebay, and his -I is
very similar to mine. For the record:

Kingston Elite Pro 45x (possibly fake):
ATA device, with non-removable media
Model Number: SMI MODEL
Serial Number: AS 0055FA00
Firmware Revision: 20070131

Source; http://1src.com/forums/showpost.php?p=993663&postcount=655

Don't forget my device works just fine with the original HDD, though!

Eddie
