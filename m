From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Fri, 9 Aug 2013 18:26:16 -0400
Message-ID: <20130809222616.GX20515@mtj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
 <20130809140358.GA20515@mtj.dyndns.org>
 <5204FE63.4010903@cogentembedded.com>
 <20130809145311.GK20515@mtj.dyndns.org>
 <5205617C.3010308@cogentembedded.com>
 <20130809215148.GW20515@mtj.dyndns.org>
 <52056A74.9040006@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33202 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031329Ab3HIW0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 18:26:21 -0400
Received: by mail-qc0-f180.google.com with SMTP id j10so2476758qcx.39
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 15:26:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52056A74.9040006@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hey,

On Sat, Aug 10, 2013 at 02:17:24AM +0400, Sergei Shtylyov wrote:
>    So why not place it to 'struct ata_queued_cmd' then? If it
> doesn't really matter where to put it if it serves to describe a
> command, and additionally will save you some memory?

Because it's just more churn?  Now TF basically matches what goes into
FIS.  Adding aux to qc break that for no good reason (no, 4 bytes
isn't a good reason).

>    In x86 world maybe but how much does it help you with the legacy
> stuff you have to drag around?
>    Tell about AHCI to my embedded customer, Renesas. Remember the
> most recent sata_rcar driver I have submitted? It's taskfile based
> (there's also SATA driver we at MontaVista did write but didn't
> submit). And it's used in their top-notch R-Car SoCs.

Oh sure, we'll carry the existing ones and there will be new drivers
for sure.  I'm saying that in terms of command protocol and standard,
it is and has long been a dead end.  Nothing can happen there anymore.
There's no point in putting TF based interface in the center of
attention.

> >I don't see why you're getting all passive agressive about it.
> 
>    Don't intimidate me with psychological terms. :-)

Please adjust your tone then because your original reply was very
easily escalatable.  If you want to escalate things, I'm game but if
you don't want that, please make that clear too.

> >If you have technical arguments, dish them out.
> 
>    I have. It seems you intentionally ignore them, and reply to
> non-technical passage only.

The only concrete thing I got upto this point is saving 4 bytes, which
is a bit difficult to consider seriously.  Other parts, I don't get at
all.  Sure there are TF drivers, but how does adding aux field to TF
make it worse for them?

Thanks.

-- 
tejun
