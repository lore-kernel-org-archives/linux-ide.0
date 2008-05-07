From: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: Compact Flash Question
Date: Wed, 07 May 2008 14:31:43 +0200
Message-ID: <4821A12F.2020800@aitel.hist.no>
References: <48215673.3060201@wpkg.org> <e2e108260805070044v42f596bbj39c5b52b6f0a096@mail.gmail.com> <48216039.3070001@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from embla.aitel.hist.no ([158.38.50.22]:60537 "EHLO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbYEGMbq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 May 2008 08:31:46 -0400
In-Reply-To: <48216039.3070001@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Bart Van Assche <bart.vanassche@gmail.com>, LKML <linux-kernel@vger.kernel.org>, YSadgat1@gcte.com, linux-os@analogic.com, Alan <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Tomasz Chmielewski wrote:
>
> How does it work, then?
> How can it do wear levelling over the whole CF if some (or most) area 
> of CF is already used by our precious data/metadata?
> It would have to know the areas where no data is stored, but it 
> contradicts the CF <-> filesystem separation.
It don't necessarily need to know. It can swap two used blocks, one 
often-used and one
rarely-used.  That way the rarely-used block is rewriten over the 
previously busy
block, and the busy block is moved to the rarely used area that isn't worn.
This implies an extra write whenever a busy block is moved.  Don't know if
anybody do this, but the technique is simple enough.

CF-filesystem separation is necessary, for they can't know in advance what
filesystem or partitioning scheme will be used.  (I have ext3 on CF, for 
example...)

Helge Hafting


