From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: AHCI + ST3160023AS + NCQ problems
Date: Tue, 30 Oct 2007 22:41:40 +0300
Message-ID: <472788F4.60300@msgid.tls.msk.ru>
References: <305c16960710291713v22875d26v8ccfc76daab102bd@mail.gmail.com>	 <47270CE9.4060501@msgid.tls.msk.ru> <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:21183 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757484AbXJ3Tlm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 15:41:42 -0400
In-Reply-To: <311601c90710300615j33bf0959l51b1b2505e9b2048@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Matheus Izvekov <mizvekov@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Eric D. Mudama wrote:
> On 10/30/07, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> By the way, did you forget to remove a jumper on the drive
>> (the only jumper installed by default) that limits drive
>> usage to SATAI?
> ...
>> ..etc.   Try again without the jumper?  Note that NCQ is NOT supported
>> in SATAI mode, or there were some pre-standard implementations of it.
>> In SATAII, NCQ is standard (well... more or less anyway ;)
> 
> Huh?
> 
> To my knowledge, the jumper should only limit the bus rate to
> 1.5Gbit/s, for compatibility with one or more chipsets.  It shouldn't
> affect the command set supported by the device.

The thing is that I don't know.  I had some other probs with seagate
sata drives when the jumper was there.  So I learned a lesson -
always remove the jumper before using their drives.  I don't want
to test which other restrictions this and other drive families
apply when jumpered... ;)

/mjt
