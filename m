From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6 SATA NCQ support
Date: Thu, 25 Jan 2007 21:28:35 +0900
Message-ID: <45B8A273.9030501@gmail.com>
References: <25b3869e0701250407q7fc6996eua411aeaec5a67444@mail.gmail.com>	 <45B89EC8.8060602@gmail.com> <25b3869e0701250419p7bcd41a4g38c05722df416115@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:36959 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114AbXAYM2p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 07:28:45 -0500
Received: by an-out-0708.google.com with SMTP id b33so308975ana
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 04:28:43 -0800 (PST)
In-Reply-To: <25b3869e0701250419p7bcd41a4g38c05722df416115@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: V VS <v.vvsrini@gmail.com>
Cc: linux-ide@vger.kernel.org

V VS wrote:
> Thanks for your immediate response. Really appreciate it very much.
> 
> With the kind of output that 2.16.19.1 <http://2.16.19.1> has displayed,
> should we be suspecting lack of NCQ support in the on-board SATA port or
> the hard disk or anywhere else?

Nope, just driver bug, I think.

> Have started the download of 2.6.20 now...

Good luck.

-- 
tejun
