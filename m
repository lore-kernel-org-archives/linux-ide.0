From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Mon, 17 Sep 2007 15:05:23 -0400
Message-ID: <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>
	 <46EE4679.7030600@gmail.com>
	 <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>
	 <46EEB449.8010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:17449 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbXIQTFX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 15:05:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1384908rvb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 12:05:23 -0700 (PDT)
In-Reply-To: <46EEB449.8010305@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu

On 9/17/07, Tejun Heo <htejun@gmail.com> wrote:
> [cc'ing Bruce Allen]
>
> Andrew Paprocki wrote:
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> > ata2.00: cmd b0/db:f8:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 0
> >          res 51/04:f8:00:4f:c2/00:00:00:00:00/00 Emask 0x1 (device error)
> > ata2.00: configured for UDMA/100
> > ata2: EH complete
>
> Upgrading smartd should fix it.  Which version are you using?

smartmontools release 5.36 dated 2006/04/12 at 17:39:01 UTC
smartmontools configure arguments: '--prefix=/opt/smartmontools'

I see a newer experimental 5.37 is out. I'll give it a go and see if
the trace goes away.

Thanks, -Andrew
