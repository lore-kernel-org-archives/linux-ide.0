From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Sat, 10 Aug 2013 02:17:24 +0400
Message-ID: <52056A74.9040006@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com> <20130809140358.GA20515@mtj.dyndns.org> <5204FE63.4010903@cogentembedded.com> <20130809145311.GK20515@mtj.dyndns.org> <5205617C.3010308@cogentembedded.com> <20130809215148.GW20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33489 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031204Ab3HIWRQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 18:17:16 -0400
Received: by mail-la0-f52.google.com with SMTP id fq13so3340521lab.25
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 15:17:14 -0700 (PDT)
In-Reply-To: <20130809215148.GW20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hello.

On 08/10/2013 01:51 AM, Tejun Heo wrote:

>>     I've started to work on my taskfile patchset about a year ago
>> (while being in hospital) and worked on it on my copious free time
>> (perhaps, not actively enough until I realized I don't have much
>> time anymore), so it doesn't sound funny for me. If you're going to
>> reject my patches once submitted outright, just tell me now, and
>> with some regret for the wasted time, I'll find a better use for my
>> free time, making a note to myself that the taskfile support in
>> libata is hopeless and the maintainer doesn't care a bit about that.
>> (In case you want an example of better taskfile support, look at
>> IDE).

> Can you explain why following the traditional TF definition matters so
> much?

    Because it's more clear, saves some memory and matches the (rather poor) 
capabilities of the libata's driver taskfile interface (which you can't throw 
out however you wanted).

> What practical difference does that make?  The new field is
> part of command code definition, so it belongs with the rest of them
> regardless of what the structure it's contained in is named.

    So why not place it to 'struct ata_queued_cmd' then? If it doesn't really 
matter where to put it if it serves to describe a command, and additionally 
will save you some memory?

> If the only reason for strictly separating TF regs into a separate struct is
> because the spec says so,

    No. Besides, as I told you, taskfile isn't in any spec, it's pre-ATA term.

> I indeed don't give a flying hoot.

    Excellent reply from a maintainer. :-D

> Also, the only controller interface which would continue to be
> relevant is ahci and that's it.  There will be no new development
> whatsoever happening with TF based interface, ever.

    In x86 world maybe but how much does it help you with the legacy stuff you 
have to drag around?
    Tell about AHCI to my embedded customer, Renesas. Remember the most recent 
sata_rcar driver I have submitted? It's taskfile based (there's also SATA 
driver we at MontaVista did write but didn't submit). And it's used in their 
top-notch R-Car SoCs.

> I don't see why you're getting all passive agressive about it.

    Don't intimidate me with psychological terms. :-)

> If you have technical arguments, dish them out.

    I have. It seems you intentionally ignore them, and reply to non-technical 
passage only.

> Thanks.

WBR, Sergei

