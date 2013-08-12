From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Mon, 12 Aug 2013 09:58:37 -0400
Message-ID: <20130812135837.GC15892@htj.dyndns.org>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com>
 <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com>
 <20130809140358.GA20515@mtj.dyndns.org>
 <5204FE63.4010903@cogentembedded.com>
 <20130809145311.GK20515@mtj.dyndns.org>
 <5205617C.3010308@cogentembedded.com>
 <20130809215148.GW20515@mtj.dyndns.org>
 <52056A74.9040006@cogentembedded.com>
 <20130809222616.GX20515@mtj.dyndns.org>
 <5206B7A9.1020802@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:56941 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab3HLN6l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Aug 2013 09:58:41 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so5617525veb.37
        for <linux-ide@vger.kernel.org>; Mon, 12 Aug 2013 06:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5206B7A9.1020802@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hello, Sergei.

On Sun, Aug 11, 2013 at 01:59:05AM +0400, Sergei Shtylyov wrote:
> >Oh sure, we'll carry the existing ones and there will be new drivers
> >for sure.  I'm saying that in terms of command protocol and standard,
> >it is and has long been a dead end.  Nothing can happen there anymore.
> >There's no point in putting TF based interface in the center of
> >attention.
> 
>    I still would like it improved regardless how old the issues
> there are, I'm just not sure I can do it. Being engaged in the
> embedded area, I feel more comfortable with the old stuff than the
> new, hence my interest.

Sure, improvements are always welcome.  My point is that when making
trade-offs, it'd make more sense to prioritize design concerns for FIS
based ones rather than the other way around.  Here, the only concrete
downside for TF based ones is 4 extra bytes in ata_taskfile, which I
don't think matters at all.

>    No, I don't want to escalate to Linus, if you meant it. I was
> just feeling somewhat bitter. However, I would like to hear a clear
> answer to my question about the taskfile patches currnetly in the
> works (although they seem to make less sence now that the taskfile
> "purity" is out of question): is there a chance you apply them or
> will you reject them as a needless churn?

I can't say for sure before actually looking at the patch but I'm
likely to nack it if the only reason behind it is saving some bytes
and conformance to the traditional definition of taskfile, especially
as I'd much prefer to be able to put all fields of a FIS into
ata_taskfile.  If the moving out the prot and flags out of ata_tf
makes the code generally cleaner, sure, but I'm a bit skeptical it
would.  Why don't you post the patch as-is?  Let's see how the whole
thing looks like.

>    Well, it seems I'm just out of arguments at this point. It seems
> just aesthetically unpleasing and not right to me to have a field in
> taskfile which can't be delivered via the taskfile interface, if you
> want.
>    To be honest, I also have a patch that makes the taskfile lose
> it's 'hob_' fields, and so the '[result_]tf' variables in the
> 'struct ata_queued_cmd' becoming arrays of 2 elements but I was
> somewhat afraid of publishing it because it's not exactly a memory
> saver (and a candidate of being labelled a pointless churn). Adding
> the new field to struct ata_taskfile just would make this patch
> completely impractical...

So, two things.  Code cleanup is always a good idea; however,
"aesthetically unpleasing" is pretty subjective and I'm not too likely
to be fond of changes which are puristic in its nature without any
practical cleanup value.

Secondly, optimization is good but it has to matter.  There's no point
in saving some bytes in a struct which aren't allocated in massive
numbers.  Likewise, there's no point in optimizing some cycles in
paths which aren't hot.  Straight-forwardness and maintainability
should be the prime concerns in most cases.

Thanks.

-- 
tejun
