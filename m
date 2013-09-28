From: Reartes Guillermo <rtguille@gmail.com>
Subject: Re: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Sat, 28 Sep 2013 01:23:40 -0300
Message-ID: <CAPVzhpzqs4VM6v59+XD-eR4aeh0GskQgonXZXKMY2Wwq31CL7Q@mail.gmail.com>
References: <20130927231346.GA5662@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63019 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab3I1EXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Sep 2013 00:23:42 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so3389420pdj.21
        for <linux-ide@vger.kernel.org>; Fri, 27 Sep 2013 21:23:42 -0700 (PDT)
In-Reply-To: <20130927231346.GA5662@animx.eu.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-ide@vger.kernel.org

Hi,

I am not sure it is the exact same [model] card., but check my bugreport:

https://bugzilla.redhat.com/show_bug.cgi?id=906532
Hard freezes with ASMedia SATA (1b21:0612) (PCIe) and Optical Drive
(iHBS112) (WORKAROUND = 'libata.atapi_passthru16=0')

Cheers.


On Fri, Sep 27, 2013 at 8:13 PM, Wakko Warner <wakko@animx.eu.org> wrote:
> I am not on this list, please keep me in CC.
>
> I have a SuperMicro X10SAE with a 2 port ASM1061 controller.  When a DVDRW
> is plugged into the port and is accessed (ie udev rules), there will be some
> errors, an ata reset then the system hangs.  Keyboard is non-responsive
> (lock key lights won't change).  SYSRQ doesn't work.
>
> I tried both ports with the same result with 2 DVDRW drives (both same
> model).
>
> I was able to use a hard disk attached to either port w/o problems.
>
> Kernel is vanilla 3.11.1 running on x86_64.
>
> --
>  Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
>  million bugs.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
