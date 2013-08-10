From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Sun, 11 Aug 2013 01:59:05 +0400
Message-ID: <5206B7A9.1020802@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com> <20130809140358.GA20515@mtj.dyndns.org> <5204FE63.4010903@cogentembedded.com> <20130809145311.GK20515@mtj.dyndns.org> <5205617C.3010308@cogentembedded.com> <20130809215148.GW20515@mtj.dyndns.org> <52056A74.9040006@cogentembedded.com> <20130809222616.GX20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61076 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860Ab3HJV6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Aug 2013 17:58:54 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so3993235lbv.3
        for <linux-ide@vger.kernel.org>; Sat, 10 Aug 2013 14:58:52 -0700 (PDT)
In-Reply-To: <20130809222616.GX20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hello.

On 08/10/2013 02:26 AM, Tejun Heo wrote:

>>     So why not place it to 'struct ata_queued_cmd' then? If it
>> doesn't really matter where to put it if it serves to describe a
>> command, and additionally will save you some memory?

> Because it's just more churn?  Now TF basically matches what goes into
> FIS.  Adding aux to qc break that for no good reason (no, 4 bytes
> isn't a good reason).

    Funny to remember, when I was just starting my Linux IDE development back 
in 2006, I published a patch that added 4-byte field to 'ide_hwif_t' and some 
people started complaining about memory waste, so that I had to promise I'd 
send a next patch that would remove another 40bte field. Clearly, they didn't 
expect an explosion in IDE development that stated happening the next year. 
:-) That time however is gone, and I probably can't promise as stable stream 
of patches as it was back then, especially given my one-year development 
period for the mentioned taskfile patches (which I still can't publish due to 
completely unexpected issue guaranteeing several debugging sessions).

>>     In x86 world maybe but how much does it help you with the legacy
>> stuff you have to drag around?
>>     Tell about AHCI to my embedded customer, Renesas. Remember the
>> most recent sata_rcar driver I have submitted? It's taskfile based
>> (there's also SATA driver we at MontaVista did write but didn't
>> submit). And it's used in their top-notch R-Car SoCs.

> Oh sure, we'll carry the existing ones and there will be new drivers
> for sure.  I'm saying that in terms of command protocol and standard,
> it is and has long been a dead end.  Nothing can happen there anymore.
> There's no point in putting TF based interface in the center of
> attention.

    I still would like it improved regardless how old the issues there are, 
I'm just not sure I can do it. Being engaged in the embedded area, I feel more 
comfortable with the old stuff than the new, hence my interest.

>>> I don't see why you're getting all passive agressive about it.

>>     Don't intimidate me with psychological terms. :-)

> Please adjust your tone then because your original reply was very
> easily escalatable.  If you want to escalate things, I'm game but if
> you don't want that, please make that clear too.

    No, I don't want to escalate to Linus, if you meant it. I was just feeling 
somewhat bitter. However, I would like to hear a clear answer to my question 
about the taskfile patches currnetly in the works (although they seem to make 
less sence now that the taskfile "purity" is out of question): is there a 
chance you apply them or will you reject them as a needless churn?

>>> If you have technical arguments, dish them out.

>>     I have. It seems you intentionally ignore them, and reply to
>> non-technical passage only.

> The only concrete thing I got upto this point is saving 4 bytes, which
> is a bit difficult to consider seriously.  Other parts, I don't get at
> all.  Sure there are TF drivers, but how does adding aux field to TF
> make it worse for them?

    Well, it seems I'm just out of arguments at this point. It seems just 
aesthetically unpleasing and not right to me to have a field in taskfile which 
can't be delivered via the taskfile interface, if you want.
    To be honest, I also have a patch that makes the taskfile lose it's 'hob_' 
fields, and so the '[result_]tf' variables in the 'struct ata_queued_cmd' 
becoming arrays of 2 elements but I was somewhat afraid of publishing it 
because it's not exactly a memory saver (and a candidate of being labelled a 
pointless churn). Adding the new field to struct ata_taskfile just would make 
this patch completely impractical...

> Thanks.

Not at all.

WBR, Sergei

