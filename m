From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: IDE CDROM tail read errors
Date: Sun, 2 Apr 2006 20:13:29 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0604022011430.12603@yvahk01.tjqt.qr>
References: <m3wtedrrpf.fsf@defiant.localdomain> <Pine.LNX.4.61.0603301016290.30783@yvahk01.tjqt.qr>
 <m3hd5ctffo.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:59055 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750722AbWDBSNe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:13:34 -0400
In-Reply-To: <m3hd5ctffo.fsf@defiant.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

>>
>> I have heard from friends that this is due to how readahead works. It 
>> reads beyond the end of the track, and logically, the hardware signals an 
>> error (leading to missing bytes at the end). It is said to be solved using 
>> the -pad option when writing CDs.
>
>You mean the read error and not TOC <> .iso track length differences?

Maps to

  if(toc_len >= iso + pad)
      ok;
  else
      b0rk on last sectors;


