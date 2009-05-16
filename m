From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] Fix ide-tape compilation error.
Date: Sat, 16 May 2009 17:08:02 +0200
Message-ID: <20090516150802.GA8386@liondog.tnic>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com> <20090505211259.GA2723@localhost> <20090505211939.GA6281@localhost> <20090506061048.GA3406@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44482 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbZEPPIG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 11:08:06 -0400
Received: by fxm2 with SMTP id 2so2433069fxm.37
        for <linux-ide@vger.kernel.org>; Sat, 16 May 2009 08:08:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090506061048.GA3406@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: Mark de Wever <koraq@xs4all.nl>, sshtylyov@ru.mvista.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>

On Wed, May 06, 2009 at 08:10:48AM +0200, Borislav Petkov wrote:
> On Tue, May 05, 2009 at 11:19:39PM +0200, Mark de Wever wrote:
> > This error only occurs when IDETAPE_DEBUG_LOG is enabled.
> > 
> > Signed-off-by: Mark de Wever <koraq@xs4all.nl>
> 
> Acked-by: Borislav Petkov <petkovbb@gmail.com>

Bart,

can you please pick that one up - it is 2.6.30 material.

Thanks.

-- 
Regards/Gruss,
    Boris.
