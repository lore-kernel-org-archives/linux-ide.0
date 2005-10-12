From: Tejun Heo <htejun@gmail.com>
Subject: Re: SCSI EH tidbit
Date: Thu, 13 Oct 2005 00:27:19 +0900
Message-ID: <434D2B57.4010806@gmail.com>
References: <434D263A.1070708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:11541 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964815AbVJLP11 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2005 11:27:27 -0400
Received: by zproxy.gmail.com with SMTP id i11so174894nzi
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 08:27:27 -0700 (PDT)
In-Reply-To: <434D263A.1070708@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


  Hi, Jeff.

Jeff Garzik wrote:
> 
> I'm thinking that __scsi_done() might be more appropriate than 
> scsi_finish_command(), for use in completing commands in the EH path. 
> There may need to be some timer-related mods somewhere to make that 
> work, though.

  Can you elaborate on why you think that would be a good idea?  I see 
cons but not many pros.  My cons are...

* SCSI EH uses scsi_finish_command()

* iodone/err counters will be incremented twice

* has possibility of looping

-- 
tejun
