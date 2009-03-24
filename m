From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select()
	method (take 2)
Date: Tue, 24 Mar 2009 08:40:52 +0100
Message-ID: <20090324074052.GA1485@liondog.tnic>
References: <200903231518.07703.sshtylyov@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:35129 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804AbZCXHk7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2009 03:40:59 -0400
Received: by bwz17 with SMTP id 17so2076765bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2009 00:40:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200903231518.07703.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

On Mon, Mar 23, 2009 at 04:18:07PM +0400, Sergei Shtylyov wrote:
> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> This patch is atop of the latest pata-2.6 series...
> Changes since the first take:
> - fixed compilation error in ns87415.c;
> - added 'ide_dev_select' reference to 'default_tp_ops', fixing kernel oops;

yep, oops is fixed.

Tested-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
