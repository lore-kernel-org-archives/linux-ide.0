From: Tejun Heo <htejun@gmail.com>
Subject: Re: shut down msg
Date: Sat, 08 Sep 2007 16:15:51 +0900
Message-ID: <46E24C27.1090208@gmail.com>
References: <46D7ED36.9080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:42612 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbXIHRHU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:07:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so940117wah
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:07:20 -0700 (PDT)
In-Reply-To: <46D7ED36.9080304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruno Buys <bruno.grupos@gmail.com>
Cc: linux-ide@vger.kernel.org

Bruno Buys wrote:
> Hi,
> I am using debian sid in an acer notebook, and I do see the spin down
> msg referred in http://linux-ata.org/shutdown.html. Linux is
> 2.6.22-1-686 and hd is sata. Am I to worry?
> Thanks!

You better update your shutdown program.  Especially so if your drive
makes funny sound during shutdown.  On shutdown, the drives should make
about the same sound as running 'hdparm -y' on it.

-- 
tejun

