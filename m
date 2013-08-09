From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/3] libata: Populate host-to-device FIS "auxiliary"
 field
Date: Sat, 10 Aug 2013 01:39:08 +0400
Message-ID: <5205617C.3010308@cogentembedded.com>
References: <1376023752-3105-1-git-send-email-marc.ceeeee@gmail.com> <1376023752-3105-2-git-send-email-marc.ceeeee@gmail.com> <20130809140358.GA20515@mtj.dyndns.org> <5204FE63.4010903@cogentembedded.com> <20130809145311.GK20515@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:38906 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031211Ab3HIVjA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 17:39:00 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3382995lab.13
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 14:38:59 -0700 (PDT)
In-Reply-To: <20130809145311.GK20515@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Marc C <marc.ceeeee@gmail.com>, linux-ide@vger.kernel.org

Hello.

On 08/09/2013 06:53 PM, Tejun Heo wrote:

>>> Ummm... I'm sorry but I'm gonna do 180 from Sergei on this one.  The

>>     That's very unfortunate for me. :-(

> Hehe, sorry. :)

    I've started to work on my taskfile patchset about a year ago (while being 
in hospital) and worked on it on my copious free time (perhaps, not actively 
enough until I realized I don't have much time anymore), so it doesn't sound 
funny for me. If you're going to reject my patches once submitted outright, 
just tell me now, and with some regret for the wasted time, I'll find a better 
use for my free time, making a note to myself that the taskfile support in 
libata is hopeless and the maintainer doesn't care a bit about that. (In case 
you want an example of better taskfile support, look at IDE).

>>> So, please put the aux field into ata_taskfile.  That's where it
>>> belongs.

>>     Can't agree to that. I was going to make 'struct ata_taskfile'
>> reflect the historical notion and remove from it all not belonging
>> to that notion. Alas, libata has a bad history of mistreating the
>> historical terms...

> But what does sticking to the historical definition give us when the
> whole concept of TF is no longer maintained in new specs.

    It predated even the old specs, so what?

> The
> distinction between "command proper" and "supporting / plumbing
> information" is still useful

    Yes, it's just the border was drawn incorrectly from the start IMO.
Jeff even placed the structure and friends into ata.h for no apparent reason 
(part of those *enum* friends eventually got shared by IDE).

> so I think it's natural to assign the
> former to ata_taskfile and the latter to ata_queuedcmd.

    That's exactly what I want to do.

> After all, there are cases where we want to describe command without all the
> plumbing stuff libata imposes

    Exactly what I want to achieve.

> and given that the aux field is part of
> FIS proper it might even get used for command results too in the
> future.

    If and when this happens, we'll see. So far, the structure of H2D and D2H 
FIS is different enough that libata doesn't have a stucture defined for FISes, 
and just treats them as array of u8.

> I mean, FIS is the new TF.

    FISes are used by what, handful of controllers? While the others, even 
SATA are still taskfile based and can't transfer FISes directly (especially 
true for the embedded world where not everybody wants to use AHCI). So that's 
kind of wishful thinking for now. And don't forget about the PATA legacy 
you'll have to drag around forever.

> We can rename ata_taskfile to
> ata_fis and map things the other way but that'd just be extra churn.

    Indeed. And totally stupid move concerning the amount of direct FIS 
support in different hardware.

> Thanks.

WBR, Sergei

