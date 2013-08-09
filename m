From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Fri, 9 Aug 2013 12:18:39 -0400
Message-ID: <20130809161839.GS20515@mtj.dyndns.org>
References: <1375946182-2831-1-git-send-email-marc.ceeeee@gmail.com>
 <1375946182-2831-2-git-send-email-marc.ceeeee@gmail.com>
 <5203DAD0.6040604@cogentembedded.com>
 <CAO1A-8DqjSAZ=GD6_BxxaBxvbsbYTUuPZSc-odr=bikUk3FtAg@mail.gmail.com>
 <5203EB9B.3050206@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:54153 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934227Ab3HIQSo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 12:18:44 -0400
Received: by mail-qa0-f47.google.com with SMTP id o19so979958qap.20
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 09:18:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5203EB9B.3050206@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

On Thu, Aug 08, 2013 at 11:03:55PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/08/2013 10:58 PM, Marc C wrote:
> 
> >>    How about non-AHCI FIS-based controllers?
> 
> >Right. Since it's cost prohibitive for me to test exhaustively on
> >non-AHCI FIS-based controllers, do you think it would be acceptable to
> 
>    You can mark your patch as RFT (request for testing) in this case.
> 
> >add a new ATA host flag... something like, ATA_FLAG_AHCI, which would
> >denote the controller as being AHCI-based? Then the flag could be used
> >to gate processing of READ/WRITE/SEND/RECEIVE FPDMA commands that have
> >the 'auxiliary' field set. Or, I could add a big fat warning print
> >whenever an ata_queued_cmd is passed to the drivers with a non-zero
> >'auxiliary' value.
> 
>    I was rather thinking about a flag (ATA_FLAG_FIS_BASED, maybe)
> marking a controller as FIS-based, so that libata would know whether
> it can issue the new commands using the 'auxiliary' value.

I'm not sure whether checking whether a controller is FIS based would
be enough.  sil24 is clearly FIS based but it snoops the command code
and likely to choke on commands which it doesn't know about.  I think
the best way to deal with it would be having a feature flag on the
host / port and setting it on controllers known to work.  In practice,
just enabling it on ahci's should cover most use cases from now on
anyway.

Thanks.

-- 
tejun
