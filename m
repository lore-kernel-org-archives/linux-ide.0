From: Tejun Heo <htejun@gmail.com>
Subject: Re: Linux 2.6 SATA NCQ support
Date: Thu, 25 Jan 2007 21:12:56 +0900
Message-ID: <45B89EC8.8060602@gmail.com>
References: <25b3869e0701250407q7fc6996eua411aeaec5a67444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:28579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880AbXAYMNE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 07:13:04 -0500
Received: by an-out-0708.google.com with SMTP id b33so304092ana
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 04:13:04 -0800 (PST)
In-Reply-To: <25b3869e0701250407q7fc6996eua411aeaec5a67444@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: V VS <v.vvsrini@gmail.com>
Cc: linux-ide@vger.kernel.org

V VS wrote:
> Can you  please give us your inputs on why the NCQ depth is not getting
> set correctly? Should we be looking at any other place for fixing this
> problem?

Please give a shot at 2.6.20-rc5.  There was a related bug fix for ahci.
 Thanks.

-- 
tejun
