From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] stop gcc warning about uninitialized 'dev' in
 ata_scsi_scan_host
Date: Thu, 16 Oct 2008 14:24:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0810161424080.14604@shark.he.net>
References: <20081015232505.GB9272@ldl.fc.hp.com> <48F6A2E7.5090005@kernel.org>
 <20081016034042.GA27621@ldl.fc.hp.com> <20081016061638.GA23630@cs181140183.pp.htv.fi>
 <20081016212244.GB18274@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:57008 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755314AbYJPVYb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 17:24:31 -0400
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 14:24:27 -0700
In-Reply-To: <20081016212244.GB18274@ldl.fc.hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Adrian Bunk <bunk@kernel.org>, Tejun Heo <tj@kernel.org>, jeff@redhat.com, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

> > > I guess we don't want to sprinkle these around all over the place
> > > just to solve cosmetic issues, which makes sense, but is there
> > > some other approach we could take instead? Any suggestions? Or
> > > just live with it?
> > 
> > We have an annotation for these kinds of warnings in the kernel.
> 
> Oh, is it this?
> 
> from linux/compiler-gcc3.h
> #define uninitialized_var(x) x = x

Yes, you got it.

-- 
~Randy
