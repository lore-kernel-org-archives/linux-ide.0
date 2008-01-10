From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata 4726 Testing
Date: Thu, 10 Jan 2008 09:53:02 +0900
Message-ID: <47856C6E.7090200@gmail.com>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com> <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com> <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com> <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com> <47850894.6090403@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:33498 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYAJAxI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 19:53:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so394759rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 16:53:07 -0800 (PST)
In-Reply-To: <47850894.6090403@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: linux-ide@vger.kernel.org

Hello, Andrew.

Andrew Ryder wrote:
> It works.
> 
> Boot log is attached.

Great!

> I ran mke2fs on all 4 drives simultaneously and all is . I did notice
> that DMA was disabled on the hardware? Do you need any info from my side
> for this?
> 
> Should device node sdf on the 5th port exist even though no drive is
> installed on the 5th port?

That's pseudo device for configuration.  You can ignore it safely.

I'll forward the patch upstream after Gaston's response.

Thanks.

-- 
tejun
