From: Tejun Heo <htejun@gmail.com>
Subject: Re: About the naming of ata_drive_probe_reset()
Date: Thu, 18 May 2006 12:24:05 +0900
Message-ID: <446BE8D5.5010404@gmail.com>
References: <446BE350.5000504@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:53961 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750854AbWERDYO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 23:24:14 -0400
Received: by ug-out-1314.google.com with SMTP id a2so387973ugf
        for <linux-ide@vger.kernel.org>; Wed, 17 May 2006 20:24:12 -0700 (PDT)
In-Reply-To: <446BE350.5000504@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Hi Tejun,
> 
> The ata_drive_probe_reset() is not drive-specific. 
> Actually what got reset is the port. (I guess the "drive" doesn't mean device here.)
> Maybe something like ata_port_probe_reset() or ata_do_probe_reset() is less ambiguous?

The 'drive' is actually a verb.  The function drives (verb) probe_reset 
  (object) using the given methods.  Maybe a bad naming.  Anyways, the 
whole probe_reset stuff is gonna be removed with the hotplug patchset, 
so I think it can be left as it is until then.

However, I also used the ata_drive_*() naming convention else where, 
like ata_bmdma_drive_eh().  We may need to rename them.  I still want to 
signify that the function isn't actually a callback but something that 
can be used to drive a callback.  I like 'drive' but as you have pointed 
out it can be confused with hard 'drive'.  Maybe ata_steer_*()?  Any 
other ideas?

-- 
tejun
