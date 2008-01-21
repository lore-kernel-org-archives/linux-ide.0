From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk, take #2
Date: Mon, 21 Jan 2008 05:48:21 -0700
Message-ID: <20080121124821.GH27250@parisc-linux.org>
References: <1200892437108-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57676 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYAUMsX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 07:48:23 -0500
Content-Disposition: inline
In-Reply-To: <1200892437108-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 21, 2008 at 02:13:52PM +0900, Tejun Heo wrote:
> In a nutshell, printk_header() lets you do the following atomically
> (against other messages).
> 
>  code:
>   printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");
> 
>  output:
>   <6>ata1.00: line0
>   <6>         line1
>   <6>         line2

I think this is a really bad idea.  It's much better to have:

<6>ata1.00: line0
<6>ata1.00: line1
<6>ata1.00: line2

That way you can grep for ata1.00 and get all messages relevant to that
device.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
