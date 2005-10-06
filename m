From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATAPI corruption found
Date: Thu, 06 Oct 2005 15:12:52 +0900
Message-ID: <4344C064.80103@gmail.com>
References: <4343A564.2060308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.204]:40976 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751238AbVJFGM7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 02:12:59 -0400
Received: by xproxy.gmail.com with SMTP id s14so210840wxc
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 23:12:58 -0700 (PDT)
In-Reply-To: <4343A564.2060308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


  Hi, Jeff.

Jeff Garzik wrote:
> 
> When atapi_qc_complete() takes the error path, completes the SCSI 
> command, SCSI EH runs, and the code attempts to complete the SCSI 
> command again, this time with scsi_finish_command().

  Umm.. that's how it worked until now by design.  Can you elaborate how 
corruption occurs?

> 
> Ideally what we should be doing is simply not completing the SCSI 
> command until REQUEST SENSE is complete, more accurately simulating 
> autosense.
> 
> I should have a fix in the next day or so, unless somebody beats me to it.

  Hehheh, nobody beat you. :-)

-- 
tejun
