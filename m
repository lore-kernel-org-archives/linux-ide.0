From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] Fix ide-tape compilation error.
Date: Wed, 6 May 2009 08:10:48 +0200
Message-ID: <20090506061048.GA3406@liondog.tnic>
References: <9ea470500904200230k5f0ea050u7411b7c9d9be7098@mail.gmail.com> <20090505211259.GA2723@localhost> <20090505211939.GA6281@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47258 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbZEFGKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 02:10:53 -0400
Received: by fxm2 with SMTP id 2so5169362fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 05 May 2009 23:10:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090505211939.GA6281@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, TejunHeo <tj@kernel.org>

On Tue, May 05, 2009 at 11:19:39PM +0200, Mark de Wever wrote:
> This error only occurs when IDETAPE_DEBUG_LOG is enabled.
> 
> Signed-off-by: Mark de Wever <koraq@xs4all.nl>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
