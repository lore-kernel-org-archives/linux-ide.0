From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH RFC] libata: FUA updates
Date: Wed, 21 Feb 2007 16:57:54 +0900
Message-ID: <45DBFB82.3090504@gmail.com>
References: <45DA4E13.10700@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:9706 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbXBUH56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:57:58 -0500
Received: by py-out-1112.google.com with SMTP id a29so1131838pyi
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:57:57 -0800 (PST)
In-Reply-To: <45DA4E13.10700@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Robert Hancock wrote:
> This updates libata FUA support to be more more in line with reality.
> FUA support remains off by default.
> 
> Add a setting for the fua command-line parameter on libata which enables
> FUA only on NCQ-supporting disks.
> 
> Update the ata_dev_supports_fua function to remove the blacklisting of
> Maxtor BANC1G10 firmware, as there is no conclusive evidence it was ever
> needed.
> 
> Centralize all of the FUA on/off decisions in this function.
> 
> Bypass the checks for FUA command support bit for NCQ disks, since that
> bit only applies to non-NCQ FUA, and FUA is part of the spec for NCQ
> commands.
> 
> When queue depth is set by the user resulting in enabling/disabling
> NCQ, trigger a revalidate so that the FUA state will be rechecked,
> since disabling/enabling NCQ may also affect FUA support on some disks.
> 
> Add a controller flag to indicate it doesn't support FUA commands, and
> set this flag for Silicon Image 311x (since that one is known to have
> problems) as well as for ITE821x when in smart mode.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Yeap, I like the clean up.  Just a few comments.

* s/if(/if (/

* The patch adds a number of trailing white spaces.  I suggest using git
or quilt for patch management.  They complain when they see such things.

I'm still not so sure about NCQ FUA.  I still think that separate opcode
for FUA ops is the right thing to do (tm), well, or the safer thing to
do (tm).  Regarding drives which support NCQ but not separate opcode for
FUA, unless many drives are like that, I don't think the loss is too
great.  Also, I'm more uncomfortable with trusting those drives doing
NCQ FUA properly.

Let's talk about this on the other thread.

Thanks.

-- 
tejun
