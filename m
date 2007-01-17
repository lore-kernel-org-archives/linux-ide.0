From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 17 Jan 2007 14:11:45 +0900
Message-ID: <45ADB011.6000906@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>	 <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com>	 <200701160958.33561.matthew4196@gmail.com>  <45AC933B.1000201@gmail.com>	 <1168947105.14636.11.camel@laundromat.jangutter.com>	 <45ACBA1F.6030007@gmail.com> <1168955594.14636.19.camel@laundromat.jangutter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:63533 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbXAQFLz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 00:11:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1892861uga
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 21:11:53 -0800 (PST)
In-Reply-To: <1168955594.14636.19.camel@laundromat.jangutter.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Gutter <jangutter@gmail.com>
Cc: Matthew Stapleton <matthew4196@gmail.com>, linux-ide@vger.kernel.org

Jan Gutter wrote:
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x43 data 12 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)

That's READ TOC.  Does the problem happen if you boot into single mode
(no hald)?  Can you access cd/dvd in single mode?

-- 
tejun
