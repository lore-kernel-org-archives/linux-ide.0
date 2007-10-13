From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: 2.6.23-mm1
Date: Sat, 13 Oct 2007 16:40:35 +0200
Message-ID: <64bb37e0710130740u78613f83wbd4f43d073bbe13d@mail.gmail.com>
References: <20071011213126.cf92efb7.akpm@linux-foundation.org>
	 <20071012140328.f82af8e8.kamezawa.hiroyu@jp.fujitsu.com>
	 <20071011234202.2f15bb76.akpm@linux-foundation.org>
	 <64bb37e0710120131y6b939951y74c50bd596b1d938@mail.gmail.com>
	 <20071012013729.ada2127b.akpm@linux-foundation.org>
	 <64bb37e0710130101y7fb8e4c0lf214fd821e8305ed@mail.gmail.com>
	 <4710A407.3070000@garzik.org>
	 <64bb37e0710130503haa66d6eu93e75ecdc78ac866@mail.gmail.com>
	 <4710B7C5.5050403@garzik.org>
	 <64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:14295 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603AbXJMOkg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 10:40:36 -0400
Received: by py-out-1112.google.com with SMTP id u77so2141212pyb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 07:40:36 -0700 (PDT)
In-Reply-To: <64bb37e0710130732p303547e3n54cfa9dac34c53b5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>, Peer Chen <pchen@nvidia.com>

On 10/13/07, Torsten Kaiser <just.for.lkml@googlemail.com> wrote:
> On 10/13/07, Jeff Garzik <jeff@garzik.org> wrote:
> > Torsten Kaiser wrote:
> > > Comparing sata_nv.c from 2.6.23-rc8-mm1 and 2.6.23-mm1 I see two
> > > changes, that look suspicious:
> > >
> > > http://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commitdiff;h=31cc23b34913bc173680bdc87af79e551bf8cc0d
> > >
> > > The comment says: "ahci and sata_sil24 are converted to use ata_std_qc_defer()."
> > > But the patch also adds ".qc_defer = ata_std_qc_defer," to sata_nv.c
>
> Looking more at this patch, I thing the code change is correct and
> only the comment is missing sata_nv. (Only ahci, sil24 and nv seem to
> use NCQ und so need the logic from qc_defer)

Wait!

I think I found the bug: Its a evil interaction between the above
patch and the swncq patch that is applied later.
The qc_defer patch removes the old ata_scmd_need_defer that was always
called for all drivers and substitutes it for ata_std_qc_defer and
adds it as aops->qc_defer to all drivers that support NCQ *at that
point*.
Then the swncq patch adds a new NCQ capable driver, but the nobody
added the qc_defer-ops to the ops-structure that is added. So swncq
will never defer any commands and the first command that would need to
be defered (the SMART commands) blows up, if there is still another
command in flight.

I will only add the qc_defer and try this...

Torsten
