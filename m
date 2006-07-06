From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: Problems with ICH7R (AHCI) and WD5000YS
Date: Thu, 6 Jul 2006 14:47:46 +0200
Message-ID: <bb145bd20607060547i7e677e31j4d8b983a5e85e549@mail.gmail.com>
References: <bb145bd20606302342h4ed461eid035d80079b1349f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:14362 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030245AbWGFMrr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jul 2006 08:47:47 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2651867ugf
        for <linux-ide@vger.kernel.org>; Thu, 06 Jul 2006 05:47:46 -0700 (PDT)
In-Reply-To: <bb145bd20606302342h4ed461eid035d80079b1349f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> [...]
> ata2: port reset, p_is 8000000 is 2 pis 0 cmd 44017 tf d0 ss 123 se 0
> ata2: status=0x50 { DriveReady SeekComplete }
> sdc: Current: sense key: No Sense
>    Additional sense: No additional sense information
> ata2: handling error/timeout
> ata2: port reset, p_is 0 is 0 pis 0 cmd 44017 tf 150 ss 123 se 0
> ata2: status=0x50 { DriveReady SeekComplete }
> ata2: error=0x01 { AddrMarkNotFound }
> sdc: Current: sense key: No Sense
>    Additional sense: No additional sense information
> [repeat]

It has gone away after I exchanged one of the cables -- for the time
being I'll assume that fixes it.

C.
