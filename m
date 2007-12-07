From: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Fri, 7 Dec 2007 18:54:27 -0200
Message-ID: <305c16960712071254n5d78b293if8d5ba2879a66b4a@mail.gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>
	 <47270CE9.4060501@msgid.tls.msk.ru>
	 <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
	 <472788F4.60300@msgid.tls.msk.ru>
	 <305c16960710301728j557689a5rbec52a11ec606963@mail.gmail.com>
	 <305c16960711062221u69e8eb37p1367b18343d0e2a5@mail.gmail.com>
	 <4737C2C0.10905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:8867 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbXLGUy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 15:54:29 -0500
Received: by py-out-1112.google.com with SMTP id u77so1782372pyb
        for <linux-ide@vger.kernel.org>; Fri, 07 Dec 2007 12:54:27 -0800 (PST)
In-Reply-To: <4737C2C0.10905@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Nov 12, 2007 1:04 AM, Tejun Heo <htejun@gmail.com> wrote:
> Matheus Izvekov wrote:
> >> Indeed removing the jumper of sdb made it be recognised as SATA2. But
> >> sdc, what the problem is really about, is neither SATA2, not has any
> >> jumper whatsoever. but both the manufacturer and libata claim it
> >> supports NCQ.
> >>
> >
> > Anything i could do to help debug this? or perhaps it makes more sense
> > to just blacklist NCQ for this particular drive?
>
> Timeouts on modern SATA disks usually indicate hardware problem.
>
> * unstable power supply (this is quite common)
> * faulty cable or poorly seated connectors
> * faulty drive or controller (seems rare)
>
> Please apply common hardware debugging method - isolate problem by
> changing configuration piece-by-piece and finding out to which component
> the error actually belongs to.
>
> --
> tejun
>

Tried everything, short of trying the hd on another controller, but
the problem persists.
