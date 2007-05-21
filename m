From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 16:52:42 +0200
Message-ID: <4651B23A.40207@gmail.com>
References: <20070521151332.4ec9ea1d@the-village.bc.nu>	<4651AB20.7070103@gmail.com> <20070521154741.490bcdb6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:42687 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940AbXEUOwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:52:54 -0400
Received: by wx-out-0506.google.com with SMTP id i26so307378wxd
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 07:52:53 -0700 (PDT)
In-Reply-To: <20070521154741.490bcdb6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I'm not sure this is correct.  The SATA bridge can be at the far side of
>> PATA cable near to the drive.  ie.
>>
>> PATA host <========= PATA cable ==========> P/SATA bridge : SATA drive
> 
> Yes
> 
>> In this case, most of the cable is PATA and cable detection matters.
> 
> The cable detection is done by the drive not the bridge, and for the
> boards I've got access to this means that the cable detection doesn't work
> at all. This is a big problem with things like the VIA C7 embedded boards
> which currently run at the wrong speeds as a result.

I think host side detection should work as long as the bridge properly
releases CBLID after IDENTIFY.  Drive side detection seems hopeless
unless the bridge modifies IDENTIFY data accordingly.  Maybe the best we
can do here is allowing user to select transfer mode.  :-(

>> Another problem is that there are still codes which interpret ap->cbl ==
>> ATA_CBL_SATA as SATA host port.  They need to be fixed first before
>> using ap->cbl for the actual cable type.
> 
> I thought we had those all sorted now. A grep shows there is nobody doing
> conditional checking off the ap->cbl cable in drivers/ata any more. They
> did in the past - which is this patch got held up - but no longer that I
> can see.

Hmm... I was looking at sata_scr_valid().  I think this needs to be
converted to ATA_FLAG_SATA test too.

-- 
tejun
