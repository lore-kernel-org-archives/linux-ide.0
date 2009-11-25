From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 45/86] pata_legacy: do not probe extra ports automatically if PCI is not present
Date: Wed, 25 Nov 2009 19:20:53 +0100
Message-ID: <200911251920.53484.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200911251845.52700.bzolnier@gmail.com> <20091125181205.24c2c97f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58833 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbZKYSXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 13:23:37 -0500
In-Reply-To: <20091125181205.24c2c97f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 07:12:05 pm Alan Cox wrote:
> > > NAK. You made a rather peculiar set of changes in the IDE layer but the
> > 
> > Please give commit numbers and describe such 'peculiar set of changes in
> > the IDE layer' in more details or skip such baseless, unjust and pointless
> 
> Disabling what can be a safe probe

In many of your comments recent you're referring to IDE state from five or
more years ago.

> > comments from your mails.
> 
> The old IDE code didn't do the full PCI check that libata did at the time
> there were public complaints. Libata legacy also doesn't fall for the bug
> where legacy loads and blocks PCI adapters as it has a smart check in it,
> including for weirdness like the CS55x0 and the MPIIX.

This was fixed long time ago and the needed checks were added
(despite complete lack of code input from you).

> So I'm firmly of the opinion that
> - We should leave it as is

We may as well decide to do it before we have more data or more recent
bug-report at hand.  No big deal.

> - If it causes a problem we should look at the exact case involved.

While it was being fixed a year or two ago you were on cc: for original
patch (+ asked whether the same should be needed for pata_legacy) and
the bug-report from mikpe was on linux-ide ML.

IOW You were not interested into it the issue back when it was reported.

>   Possibly it would need a CONFIG_X86 but thats sort of implied as
>   embedded use pata_platform in preference.
> 
> The fact it just works by default is very very important.

Agreed on this one.

--
Bartlomiej Zolnierkiewicz
