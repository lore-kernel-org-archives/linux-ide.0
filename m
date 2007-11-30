From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Fri, 30 Nov 2007 15:12:06 +0900
Message-ID: <474FA9B6.105@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:23295 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbXK3GMN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Nov 2007 01:12:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1817039rvb
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 22:12:13 -0800 (PST)
In-Reply-To: <006101c83301$bf79bef0$6539a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

sam song wrote:
> Attached pls see the details debug log on SUSE Linux Enterprise 10 I just
> did. As for code, I will send to you in private for it is kind of poor and
> confidential. Really sorry for that.

Aieee... SLES10.  Is it SLES10SP1 or just SLES10.  I'm fairly sure
passthrough support is broken in SLES10.  Can you please try the program
on vanilla kernel (2.6.23.X)?

-- 
tejun
