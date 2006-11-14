From: Tejun Heo <htejun@gmail.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Tue, 14 Nov 2006 11:02:29 +0900
Message-ID: <455923B5.3030608@gmail.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:28536 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754304AbWKNCCj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 21:02:39 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1270839ugc
        for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 18:02:37 -0800 (PST)
In-Reply-To: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Mattieu Fluhr.

Mathieu Fluhr wrote:
> The problem is that, on SATA devices controlled by libata, on some big
> files (like for example a 600 MB file) the READ command seems to fail
> and outputs garbage (not 1 or 2 bytes diff, but the whole buffer).
>  -> This problem does not come out everytime, and each time on    
>     different sectors.
> 
> Please note that:
> - it is not chipset dependant (tested on nforce4 and sii3114)
> - it is not medium or device dependant

Hmmm... Interesting.  So, you're reading the media by directly issuing 
commands through the sg interface, right?  Can you please try the 
followings?

* Try using /dev/srX or /dev/scdX device instead of /dev/sgX.  You can 
use the command SG_IO but the code path is different, so it will help us 
rule out sg bug.

* Perform rounds of read-verify test using standard block interface (ie. 
simply opening /dev/srX and reading it).

[--snip--]
> - When I force the bus type to be IDE, our software will then send ATA
> commands. In this case, everything works like a charm. No errors at all.

What do you mean by 'sending ATA commands'?  libata exports all devices 
as SCSI devices.  For ATA devices, you can use ATA passthrough but you 
send CDBs to ATAPI devices anyway.

Thanks.

-- 
tejun
