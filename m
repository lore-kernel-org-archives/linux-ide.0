From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] printk: implement printk_header() and merging printk,
 take #2
Date: Wed, 23 Jan 2008 09:02:58 +0900
Message-ID: <47968432.2090304@gmail.com>
References: <1200892437108-git-send-email-htejun@gmail.com> <20080121124821.GH27250@parisc-linux.org> <Pine.LNX.4.64.0801230036250.9183@fbirervta.pbzchgretzou.qr> <47968183.3050704@gmail.com> <Pine.LNX.4.64.0801230056510.9183@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:62792 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYAWADG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 19:03:06 -0500
Received: by py-out-1112.google.com with SMTP id u52so3837673pyb.10
        for <linux-ide@vger.kernel.org>; Tue, 22 Jan 2008 16:03:05 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801230056510.9183@fbirervta.pbzchgretzou.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Matthew Wilcox <matthew@wil.cx>, randy.dunlap@oracle.com, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 23 2008 08:51, Tejun Heo wrote:
>> What do you think about the second suggestion then?
>>
>> ata1.00: line0
>> ata1.00  line1
>> ata1.00  line2
>>
>> It allows you to grab for the header && has indication for message
>> boundaries.
> 
> Then again, why not "[ata1.00] line0", then it matches what sd_mod does :)

Well, that's fine too but using ':' is much more common.  Just take a
look at the boot log and if we go with '[]', any ideas on how to
indicate multiline messages?

-- 
tejun
