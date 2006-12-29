From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: hda on Via Epia-ML motherboard seen on 2.6.18, but not 2.6.19
Date: Fri, 29 Dec 2006 16:25:04 +0100
Message-ID: <58cb370e0612290725j34c9063fw7e04752a17880beb@mail.gmail.com>
References: <200612291512.kBTFCpeI021382@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:14823 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbWL2PZF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Dec 2006 10:25:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so5945872nfa
        for <linux-ide@vger.kernel.org>; Fri, 29 Dec 2006 07:25:04 -0800 (PST)
In-Reply-To: <200612291512.kBTFCpeI021382@freya.yggdrasil.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-ide@vger.kernel.org

On 12/29/06, Adam J. Richter <adam@yggdrasil.com> wrote:
> On 12/22/06, I wrote
> >         I have a 666MHz Via Epia-ML motherboard (using a Via Eden, I
> > think).  I am booting it from a CompactFlash card attached by an
> > IDE-CF adapter.  Everything works fine under 2.6.18.  Under 2.6.19,
> > 2.6.19.1 and 2.6.20-rc1, the master device on ide0 is not seen.
> [...]
>
>         Argh!  This was my mistake.  It is not a new kernel bug.
>
>         Somehow, I inadvertently activated CONFIG_BLK_DEV_HD_IDE,
> which runs a much older IDE driver on hda only.

>         This older IDE hard disk driver apparently does not detect any
> of the flash disks that I tried.  which I suppose might be a bug, but
> I don't if anybody should care.  Indeed, I'm curious to know if there
> is any hardware that needs or benefits CONFIG_BLK_DEV_HD_IDE in recent
> kernels.  That is to say, what is it that the regular IDE driver does
> not handle well enough?  If there is no longer any benefit to
> CONFIG_BLK_DEV_HD_IDE, then maybe that code should be deleted.

Probably, care to make a patch?

>         I have verified that deactivating CONFIG_BLK_DEV_HD_IDE on
> 2.6.20-rc2 fixes the problem for me.
>
>         I believe the reason that the offending kernels previously
> worked with the same flash disks in the ide0/master slot of another
> computer that I have is that the computer on which it worked also has
> two SATA drives, which are now labelled by the kernel, starting around
> 2.6.19, as "hda" and "hdc", bumping the flash card to "hde", which I
> think resulted in it being controlled by the non-ancient IDE driver,
> since CONFIG_BLK_DEV_HD_IDE only applies to hda.
>
>         By the way, I did diff my .config files initially when
> researching this bug, but the configuration options from 2.6.18 to
> 2.6.19 changed enough that I missed this misconfiguration of mine.
> I'm not even sure how I made this mistake.  In any case, I apologize
> for what was basically a false alarm.

No problem, thanks for reporting this.

Bart
