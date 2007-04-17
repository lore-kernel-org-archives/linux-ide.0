From: Tejun Heo <htejun@gmail.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA
 hd
Date: Wed, 18 Apr 2007 02:45:24 +0900
Message-ID: <462507B4.2010404@gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>	 <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>	 <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com>	 <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>	 <4624FD7F.4070200@gmail.com> <a7108f870704171030i6076a147lc4580ee720ba3e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:22473 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161224AbXDQRpa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 13:45:30 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1879737wra
        for <linux-ide@vger.kernel.org>; Tue, 17 Apr 2007 10:45:29 -0700 (PDT)
In-Reply-To: <a7108f870704171030i6076a147lc4580ee720ba3e82@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rodrigo Severo <rodrigo@fabricadeideias.com>
Cc: linux-ide@vger.kernel.org

Rodrigo Severo wrote:
> SMART Error Log Version: 1
> No Errors Logged

It seemed like a transmission problem so I was hoping the drive's SMART
log recorded something.  Apparently not.  :-(

> This is the SATA board running now. Everything else is exactly the
> same. I got no syslog messages after rsyncing 255GB.
> 
> I believe the smartctl output is still valid despite having other SATA
> board.

Yeap, it's valid.

> Please let me know if there is anything else I can do to help debug this
> issue.
> 
> I can put the ULi M5281/M5283 back for tests.

ULi SATA is a fairly standard controller and the driver doesn't do much
other than feeding IO addresses to generic ATA layer, so there's nothing
much to go wrong there.  It might be a genuine hardware problem on the
controller side or driver missing some undocumented magic tweaks.  I
think the former is more likely.

Occasional errors should be okay.  libata EH can recover most conditions
and there won't be any data integrity problem.  Too long timeout (30s)
can be a problem tho.

Unfortunately, I don't think we have much to go on here.  Both SError
register and SMART log aren't reporting anything useful.  :-(

-- 
tejun
