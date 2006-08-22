From: Tejun Heo <htejun@gmail.com>
Subject: Re: Some questions about new EH in libata
Date: Wed, 23 Aug 2006 00:51:33 +0900
Message-ID: <44EB2805.2010402@gmail.com>
References: <8202f4270608212154k787f63a1k15ed3dcfff0624c2@mail.gmail.com>	 <44EA91A8.5090309@gmail.com> <8202f4270608220840j6bdb4ae4u2c31803b4244e521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:3446 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750973AbWHVPvr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 11:51:47 -0400
Received: by nf-out-0910.google.com with SMTP id o25so91657nfa
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 08:51:44 -0700 (PDT)
In-Reply-To: <8202f4270608220840j6bdb4ae4u2c31803b4244e521@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Fajun Chen wrote:
> Hi Tejun,
> 
> Could you please elaborate all the conditions triggering the error
> handling? I know that command failure or HBA error can trigger EH, but
> does EH schedule any routine error checking autonomously? The
> particular scenario I am looking at is if a drive is moved away from
> interface mode (through back door noninterface command) for some time
> then move back, will EH detect and declare it as an interface error?

What do you mean by moving away from interface mode?  Do you refer to 
transfer mode?  libata doesn't do any autonomous EH.  Unless command 
fails or host reports exception (phy status change, etc...), EH won't 
kick in except for one case - it snoops cache on/off and schedule EH to 
revalidate device and configure SCSI dev accordingly.

-- 
tejun
