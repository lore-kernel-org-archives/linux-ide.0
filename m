From: =?UTF-8?B?TnVubyBNYWdhbGjDo2Vz?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Fri, 05 Dec 2014 22:12:35 +0000
Message-ID: <54822DD3.6040405@eu.ipp.pt>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com> <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com> <20140817133942.GD7679@mtj.dyndns.org> <CADqA9ubrD1+Ri9d080X4xjrr7wsjqGGz5fjTC45QHjr4Fb1QJg@mail.gmail.com> <CADqA9uaj0MrpffnzE8xnhU57Hx9pv7O1sAhB+xS_4hi8z_dkMA@mail.gmail.com> <20141202195653.GQ10918@htj.dyndns.org> <547E4817.8000603@eu.ipp.pt> <20141204174819.GC2995@htj.dyndns.org> <5480F54B.9070306@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:54109 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaLEWMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2014 17:12:40 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so2001991wgh.36
        for <linux-ide@vger.kernel.org>; Fri, 05 Dec 2014 14:12:38 -0800 (PST)
In-Reply-To: <5480F54B.9070306@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 2014-12-04 23:59, Phillip Susi wrote:
> Looks a lot like a drive that has Power Up In Standby enabled; on 
> power up they don't know what to report for many of the fields 
> until the media has been read.

The problem is this only happens sometimes and only on WD drives, but
i'll look into that, thanks.
