From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Sat, 27 Sep 2008 18:19:56 +0200
Message-ID: <200809271819.57244.bzolnier@gmail.com>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <48D57245.8060606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:63134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYI0R2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:28:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so963865fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:28:52 -0700 (PDT)
In-Reply-To: <48D57245.8060606@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Saturday 20 September 2008, Sergei Shtylyov wrote:

[...]

>    But actually setting the controller's timings prior to issuing SET 
> FEATURES doesn't seem safe anyway. Bart, don't you think that we should 
> always call set_{dma|pio}_mode() AFTER ide_config_drive_speed() --
> we have no guarantee that the drive will accept the mode...

I remember some discussion about this issue in the past but currently I
don't see a reason why we shouldn't do it this way.  Care to make a patch?

Thanks,
Bart
