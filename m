From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Sat, 08 Dec 2007 08:51:33 +0900
Message-ID: <4759DC85.8000100@gmail.com>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>	 <47270CE9.4060501@msgid.tls.msk.ru>	 <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>	 <472788F4.60300@msgid.tls.msk.ru>	 <305c16960710301728j557689a5rbec52a11ec606963@mail.gmail.com>	 <305c16960711062221u69e8eb37p1367b18343d0e2a5@mail.gmail.com>	 <4737C2C0.10905@gmail.com> <305c16960712071254n5d78b293if8d5ba2879a66b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:8092 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXLGXvl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 18:51:41 -0500
Received: by rv-out-0910.google.com with SMTP id k20so868752rvb
        for <linux-ide@vger.kernel.org>; Fri, 07 Dec 2007 15:51:40 -0800 (PST)
In-Reply-To: <305c16960712071254n5d78b293if8d5ba2879a66b4a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Matheus Izvekov wrote:
>> * unstable power supply (this is quite common)
>> * faulty cable or poorly seated connectors
>> * faulty drive or controller (seems rare)
> 
> Tried everything, short of trying the hd on another controller, but
> the problem persists.

Weird, ICH7 + 7200.7 combination is very widely tested.  Can you please
post the result of "hdparm -I /dev/sdX" and "smartctl -a /dev/sdX" where
sdX is the offending drive?  So, if you connect the drive to a different
port of the controller using a different cable, the problem follows the
drive, right?

Thanks.

-- 
tejun
