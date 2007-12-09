From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Sun, 09 Dec 2007 19:39:18 +0900
Message-ID: <475BC5D6.4030708@gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>	 <47270CE9.4060501@msgid.tls.msk.ru>	 <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>	 <472788F4.60300@msgid.tls.msk.ru>	 <305c16960710301728j557689a5rbec52a11ec606963@mail.gmail.com>	 <305c16960711062221u69e8eb37p1367b18343d0e2a5@mail.gmail.com>	 <4737C2C0.10905@gmail.com>	 <305c16960712071254n5d78b293if8d5ba2879a66b4a@mail.gmail.com>	 <4759DC85.8000100@gmail.com> <305c16960712071639x50a78699pbfc0b9d9c7501b96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:16385 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbXLIKj1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 05:39:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2633012wah
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 02:39:26 -0800 (PST)
In-Reply-To: <305c16960712071639x50a78699pbfc0b9d9c7501b96@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Matheus Izvekov wrote:
> Yes it follows the drive. I have another drive which is quite similiar
> to the offending one, but has no NCQ so the problem doesnt apply. i
> have another that is sata2 (has ncq) and shows no problem.

Hmmm... Everything looks normal.  The problem is that there's currently
only one report and I can't tell whether your specific drive is faulty
or the model with the firmware version is faulty.

Ah... okay.  Another drive with the same firmware version is already
blacklisted, which makes the latter far more likely.  I'll create a
blacklist entry for your drive.

Thanks.

-- 
tejun
