From: Eric Mudama <edmudama@gmail.com>
Subject: Re: libata PATA support - work items?
Date: Sat, 1 Jan 2005 12:19:20 -0700
Message-ID: <311601c9050101111929aef5ba@mail.gmail.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.203]:11312 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVAATTV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Jan 2005 14:19:21 -0500
Received: by rproxy.gmail.com with SMTP id j1so15174rnf
        for <linux-ide@vger.kernel.org>; Sat, 01 Jan 2005 11:19:21 -0800 (PST)
In-Reply-To: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

On Thu, 30 Dec 2004 18:42:33 +0800, Albert Lee <albertcc@tw.ibm.com> wrote:
>     2. C/H/S addressing; libata currently hardcoded to use LBA


Are there really people who want to run a newer 2.4 or a 2.6 kernel,
who have disks that do not support LBA mode?  CHS will never address
more than 32GB of the drive (unless you use vendor unique
implementations) and heck, most companies don't even build drives that
small anymore...  CHS is very messy, LBA is so much simpler.   Can we
just stick with that?

--eric
