From: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Tue, 30 Oct 2007 22:28:56 -0200
Message-ID: <305c16960710301728j557689a5rbec52a11ec606963@mail.gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
	 <47270CE9.4060501@msgid.tls.msk.ru>
	 <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
	 <472788F4.60300@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.184]:31962 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751147AbXJaA27 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 20:28:59 -0400
Received: by rn-out-0102.google.com with SMTP id s46so2118596rnb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 17:28:58 -0700 (PDT)
In-Reply-To: <472788F4.60300@msgid.tls.msk.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On 10/30/07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Eric D. Mudama wrote:
> > On 10/30/07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >> By the way, did you forget to remove a jumper on the drive
> >> (the only jumper installed by default) that limits drive
> >> usage to SATAI?
> > ...
> >> ..etc.   Try again without the jumper?  Note that NCQ is NOT supported
> >> in SATAI mode, or there were some pre-standard implementations of it.
> >> In SATAII, NCQ is standard (well... more or less anyway ;)
> >
> > Huh?
> >
> > To my knowledge, the jumper should only limit the bus rate to
> > 1.5Gbit/s, for compatibility with one or more chipsets.  It shouldn't
> > affect the command set supported by the device.
>
> The thing is that I don't know.  I had some other probs with seagate
> sata drives when the jumper was there.  So I learned a lesson -
> always remove the jumper before using their drives.  I don't want
> to test which other restrictions this and other drive families
> apply when jumpered... ;)
>
> /mjt
>

Indeed removing the jumper of sdb made it be recognised as SATA2. But
sdc, what the problem is really about, is neither SATA2, not has any
jumper whatsoever. but both the manufacturer and libata claim it
supports NCQ.
