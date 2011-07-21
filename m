From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 21 Jul 2011 11:00:22 +0200
Message-ID: <20110721090022.GF3455@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54605 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab1GUJA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jul 2011 05:00:28 -0400
Received: by ewy4 with SMTP id 4so1039757ewy.19
        for <linux-ide@vger.kernel.org>; Thu, 21 Jul 2011 02:00:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, Jul 14, 2011 at 05:37:37PM +0000, Derry Bryson wrote:
> Hi:
> 
> Dmesg with second timing value set to 1000 always, hotplugging WD 3TB drive:
> 
> [  139.145917] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
> [  139.156180] ata5.00: SError: { PHYRdyChg CommWake DevExch }
> [  139.166619] ata5.00: hard resetting link
> [  140.430401] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [  140.430453] ata5.00: issuing IDENTIFY
> [  140.430480] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
> [  140.430521] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
...
> [  145.431276] ata5.00: hard resetting link
> [  145.431298] ata5.00: XXXX hardreset hotplugged = false
> [  145.431304] ata5.00: XXX0 hardreset debounce 5 100 2000
> [  145.431310] ata5.00: XXX1 hardreset debounce 5 1000 2000
> [  146.690413] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
...
> [  152.940451] ata5.00: issuing IDENTIFY
> [  152.940477] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
> [  152.940518] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)

So, no change.  Weird.  I think we need to implement retry backoff
properly anyways but am still wondering why probing failure behaves
differently for you.  I'll try with similar drive but maybe it's
difference in PMP firmware?

Thanks.

-- 
tejun
