From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Build Failure] 2.6.25-rc5-mm1 Build fails with allmodconfig probe_4drives undefined
Date: Tue, 11 Mar 2008 20:35:24 +0100
Message-ID: <200803112035.24811.bzolnier@gmail.com>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <47D68126.40109@linux.vnet.ibm.com> <20080311104137.3c6b3f22.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:60017 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYCKTXq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 15:23:46 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2528603fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 12:23:45 -0700 (PDT)
In-Reply-To: <20080311104137.3c6b3f22.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, apw@shadowen.org

On Tuesday 11 March 2008, Andrew Morton wrote:
> On Tue, 11 Mar 2008 18:25:02 +0530
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
> > The 2.6.25-rc5-mm1 kernel build fails with allmodconfig 
> > 
> >   MODPOST 2279 modules
> > ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!
> 
> Yes, it has been doing this for a while.  But apparently it doesn't happen
> for Bart with just his patch queue.  <slightlypeeved>If your subssytem
> fails in my tree, that doesn't automatically make it my
> problem</slightlypeeved>

No need to peeve - it is not like I forget about the problem or ignored it
after I got your _first_ mail.

I just couldn't reproduce it here so instead I has been working on making
_all_ probe_* variables static (it should make the problem vanish alongside
some other nice improvements).

Thanks,
Bart
