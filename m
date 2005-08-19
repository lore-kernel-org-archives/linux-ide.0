From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata total system lockup fix
Date: Fri, 19 Aug 2005 12:21:47 +0900
Message-ID: <4305504B.7080201@gmail.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <42FA70A9.6080608@pobox.com> <43052C03.7060306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:39018 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751044AbVHSDV5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Aug 2005 23:21:57 -0400
Received: by zproxy.gmail.com with SMTP id i11so364370nzh
        for <linux-ide@vger.kernel.org>; Thu, 18 Aug 2005 20:21:53 -0700 (PDT)
In-Reply-To: <43052C03.7060306@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de


  Hi, Mark.

Mark Lord wrote:
> After a week of further experience with this patch,
> I regretfully inform one and all that it does not
> entirely fix the lockups.
> 
> My system has experienced three of them during the
> past 24 hours.. after many days without.

  Oh.. crap.

> I'm now reverting to the original "broken" patch
> that keeps my system alive.
> 
> Cheers!

  I've been trying to reproduce your lockup here, but haven't succeeded 
yet.  I'm currently doing multiple "while true; do cat /dev/sr0; done", 
bonnie, raw random IOs (latter two are to give some randomness to test 
condition).

  I'm also digging code to discover how exactly the lockup loop occurs. 
  My lockup was between scsi_softirq and scsi_eh_scmd_add (EIP jumped 
between the two functions), and I orginally assumed adding eh_entry to 
corrupt eh_cmd_q screwed local_q iteration in scsi_softirq.  And as 
clearing eh_cmd_q solved my problem, I didn't look into it further.

  If possible, can you please hook up your notebook to a serial console 
and, when lockup occurs (with or without INIT_LIST_HEAD one liner), dump 
call trace by ctrl-alt-sysrq-p multiple times (10times across 5secs 
should do, I think) to verify that we're looking at the same problem? 
It would be best if I can find a way to reproduce it here, but the busy 
loop has been running for two hours now and nothing happened.  :-(

  Thanks.

-- 
tejun
