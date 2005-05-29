From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 18:57:31 +0200
Message-ID: <4299F47B.5020603@gmail.com>
References: <20050526140058.GR1419@suse.de> <1117382598.4851.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:35678 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbVE2Q5f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2005 12:57:35 -0400
Received: by wproxy.gmail.com with SMTP id 69so2102884wri
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 09:57:35 -0700 (PDT)
In-Reply-To: <1117382598.4851.3.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Erik Slagter schrieb:

>On Thu, 2005-05-26 at 16:00 +0200, Jens Axboe wrote:
>  
>
>>Now, this patch is not complete. It should work and work well, but error
>>handling isn't really tested or finished yet (by any stretch of the
>>imagination). So don't use this on a production machine, it _should_ be
>>safe to use on your test boxes and for-fun workstations though (I run it
>>here...). I have tested on ich6 and ich7 generation ahci, and with
>>Maxtor and Seagate drives.
>>    
>>
>
>Is this supposed to work on ICH7 in legacy mode as well?
>
>Another question: is there a fundamental problem to have the ICH6/7
>enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
>don't offer the choice to enable AHCI (like mine :-().
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hello,

here on my Mainboard ASUS P5WAD2-Premium (i955X/ICH7) I need to enable
AHCI support
like on the ICH6R based ASUS P5AD2-E xx the same here.
What I have noticed is when I enable Intel Raid support AHCI is on by
default, maybe it used AHCI if
drive is capable?! There are also performance regressions from within
used bios.
What mainboard are you using Erik? All mainboards with ICH6R I saw and
had (925X,925XE) offer options to enable AHCI.

Greets and best regards
 
    Michael
