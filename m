From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #2
Date: Wed, 23 Jan 2008 08:51:31 +0900
Message-ID: <47968183.3050704@gmail.com>
References: <1200892437108-git-send-email-htejun@gmail.com> <20080121124821.GH27250@parisc-linux.org> <Pine.LNX.4.64.0801230036250.9183@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:21845 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbYAVXvi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 18:51:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2282287rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 15:51:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801230036250.9183@fbirervta.pbzchgretzou.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Matthew Wilcox <matthew@wil.cx>, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 21 2008 05:48, Matthew Wilcox wrote:
>> On Mon, Jan 21, 2008 at 02:13:52PM +0900, Tejun Heo wrote:
>>> In a nutshell, printk_header() lets you do the following atomically
>>> (against other messages).
>>>
>>>  code:
>>>   printk(KERN_INFO "ata1.00: ", "line0\nline1\nline2\n");
>>>
>>>  output:
>>>   <6>ata1.00: line0
>>>   <6>         line1
>>>   <6>         line2
>> I think this is a really bad idea.  It's much better to have:
>>
>> <6>ata1.00: line0
>> <6>ata1.00: line1
>> <6>ata1.00: line2
>>
>> That way you can grep for ata1.00 and get all messages relevant to that
>> device.
> 
> Agreed, I too prefer <6>ata1.00 on every line.

What do you think about the second suggestion then?

ata1.00: line0
ata1.00  line1
ata1.00  line2

It allows you to grab for the header && has indication for message
boundaries.

-- 
tejun
