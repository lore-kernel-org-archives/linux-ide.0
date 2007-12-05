From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issuing a vendor specific ATA cmd on SATA Disk via ATA Pass Thru
Date: Wed, 05 Dec 2007 12:16:08 +0900
Message-ID: <475617F8.7090607@gmail.com>
References: <004d01c83273$68ded140$6539a8c0@usish.com.cn> <474F64F5.9070205@gmail.com> <006101c83301$bf79bef0$6539a8c0@usish.com.cn> <474FA9B6.105@gmail.com> <008f01c8331a$50efacb0$6539a8c0@usish.com.cn> <474FAECC.6070303@gmail.com> <009901c8331c$30d2c780$6539a8c0@usish.com.cn> <474FB1FB.9050904@gmail.com> <009b01c8331e$e8f40200$6539a8c0@usish.com.cn> <474FC845.7050308@gmail.com> <006301c83596$2e58fed0$6539a8c0@usish.com.cn> <4754A368.70806@gmail.com> <002d01c83615$79261090$6539a8c0@usish.com.cn> <4754B995.4010800@gmail.com> <47560245.70306@gmail.com> <000001c836e8$1ef1ba10$6539a8c0@usish.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:19441 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbXLEDQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 22:16:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6721164wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 19:16:16 -0800 (PST)
In-Reply-To: <000001c836e8$1ef1ba10$6539a8c0@usish.com.cn>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sam song <sam_song@usish.com>
Cc: linux-ide@vger.kernel.org

Hello,

sam song wrote:
> Still one puzzle to consult with you. As you mentioned, the ATA Pass Thru in
> SELS10 2.6.16.21-0.8 is "broken". So what is the workable vanilla kernel
> besides 2.6.23.X? I
> need to have more choice on distribution. For example 2.6.18.X vanilla
> kernel with your patch can work?

Well. libata has been developing pretty fast.  I think post 2.6.20
should be fine but not too sure.  Does anyone remember better?

-- 
tejun
