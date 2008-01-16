From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk
Date: Wed, 16 Jan 2008 10:07:04 +0900
Message-ID: <478D58B8.1000705@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:25038 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYAPBHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 20:07:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so100484wah.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 17:07:23 -0800 (PST)
In-Reply-To: <1200445210549-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, randy.dunlap@oracle.com, jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This patchset implements printk_header() and mprintk - merging printk
> - to make printing multiline messages and assembling message
> piece-by-piece easier.
> 
> In a nutshell, printk_header() lets you do the following atomically
> (against other messages).
> 
>  code:
>   printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");

That should have been printk_header instead of printk.  Sorry.

-- 
tejun
