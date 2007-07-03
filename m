From: Tejun Heo <htejun@gmail.com>
Subject: Re: Error in syslog on 2.6.20
Date: Tue, 03 Jul 2007 20:56:00 +0900
Message-ID: <468A3950.8020804@gmail.com>
References: <20070622184018.GA20301@electro-mechanical.com> <4689FA27.6040706@gmail.com> <20070703113945.GK24385@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:25297 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760113AbXGCL4F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 07:56:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1190555nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 04:56:05 -0700 (PDT)
In-Reply-To: <20070703113945.GK24385@electro-mechanical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

William Thompson wrote:
>> Your cd rom failed to complete the TUR command your program issued in
>> the specified timeout.  ODDs sometimes take quite long to finish TUR or
>> any other command when media is changed.  Did you use sg command or
>> cdrom ioctl?
> 
> I'm using SG_IO.  I also tested sg3-utils' sg_tur which gave me the same
> thing.  Is it just a crappy cdrom?

Not necessarily.  It could be just that you're specifying too short
timeout.  Give a shot at longer timeout.

-- 
tejun
