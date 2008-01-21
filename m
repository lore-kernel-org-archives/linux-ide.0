From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #2
Date: Mon, 21 Jan 2008 22:04:54 +0900
Message-ID: <47949876.6070001@gmail.com>
References: <1200892437108-git-send-email-htejun@gmail.com> <20080121124821.GH27250@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:52841 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYAUNFD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 08:05:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1783606rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 05:05:00 -0800 (PST)
In-Reply-To: <20080121124821.GH27250@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Jan 21, 2008 at 02:13:52PM +0900, Tejun Heo wrote:
>> In a nutshell, printk_header() lets you do the following atomically
>> (against other messages).
>>
>>  code:
>>   printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");
>>
>>  output:
>>   <6>ata1.00: line0
>>   <6>         line1
>>   <6>         line2
> 
> I think this is a really bad idea.  It's much better to have:
> 
> <6>ata1.00: line0
> <6>ata1.00: line1
> <6>ata1.00: line2
> 
> That way you can grep for ata1.00 and get all messages relevant to that
> device.

It has some pros and cons.  Having indentation makes things easier on
human eyes but more difficult on scripts, but not too difficult -
indented lines can easily be matched with a bit of scripting.  Changing
the behavior is easy but I'm still inclined toward indentation because
printing header every line loses information about message boundaries.
Maybe there's a way to satisfy both like omitting the separator from the
second line on.

ata1.00: line0
ata1.00  line1
ata1.00  line2

Hmm... Any better ideas?

-- 
tejun
