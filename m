From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata NCQ implementation questions
Date: Tue, 13 May 2008 17:32:15 +0900
Message-ID: <4829520F.6020304@gmail.com>
References: <18471.32504.953679.399689@harpo.it.uu.se>	<48286938.1090301@rtr.ca> <18472.38839.647001.510236@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:25032 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418AbYEMIcW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 May 2008 04:32:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2646934wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 13 May 2008 01:32:21 -0700 (PDT)
In-Reply-To: <18472.38839.647001.510236@alkaid.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Mark Lord <liml@rtr.ca>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Mark Lord writes:
>  > Mikael Pettersson wrote:
>  > > I've started working on NCQ support for sata_promise,
>  > > and I have a few questions regarding NCQ and libata:
>  > > 
>  > > 1. Can I rely not seeing any non-NCQ commands while there
>  > >    are uncompleted NCQ commands on a port?
>  > ..
>  > 
>  > No, you cannot.  So you'll have to code a .qc_defer() method
>  > to hold them off in that case.  For a *really* good example,
>  > see my recently deployed mv_qc_defer() function in sata_mv.c
>  > as of linux-2.6.26-rc2.
> 
> Hmm, so I misinterpreted ata_std_qc_defer()? Ok, I'll look
> at sata_mv's version.

ata_std_qc_defer() which is inherited from sata_port_ops does guarantee 
that NCQ and non-NCQ commands don't mix on a single device.  Mark, 
you're talking about PMP, right?

Thanks.

-- 
tejun
