From: =?UTF-8?Q?Nuno_Magalh=C3=A3es?= <nunomagalhaes@eu.ipp.pt>
Subject: Re: SATA disks disabled on boot
Date: Wed, 16 Jul 2014 21:35:12 +0100
Message-ID: <CADqA9uYfncyrsnV8Fa2d4L0my2h=1rp=4-xX5RKazj0zJLhCPA@mail.gmail.com>
References: <CADqA9uaW6JwirSZQaHjCuB=9GSUQyakOEBAZor1ed-vyjoC=2g@mail.gmail.com>
 <20140714163641.GF31610@htj.dyndns.org> <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44839 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbaGPUff (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jul 2014 16:35:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so2002143wiw.0
        for <linux-ide@vger.kernel.org>; Wed, 16 Jul 2014 13:35:34 -0700 (PDT)
In-Reply-To: <CADqA9uYMCdT1ZpHD0fOVoD67PAx6RaY+8grfmG8SRoqnwyyHgw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

I've been fiddling with lm-sensors and noticed that loading it87 may
cause interference with the southbridge [2]. Can this be causing the
disks to drop or am i just adding noise (if so, sorry!)?
