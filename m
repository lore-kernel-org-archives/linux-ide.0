From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Tue, 16 Jan 2007 17:56:27 +0900
Message-ID: <45AC933B.1000201@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com> <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com> <200701160958.33561.matthew4196@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:25105 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbXAPI4e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 03:56:34 -0500
Received: by an-out-0708.google.com with SMTP id b33so978725ana
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 00:56:33 -0800 (PST)
In-Reply-To: <200701160958.33561.matthew4196@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Stapleton <matthew4196@gmail.com>
Cc: linux-ide@vger.kernel.org

Matthew Stapleton wrote:
> Tejun Heo wrote:
>> Does the problem still persist?
>>
> With that kernel and the previous patches it does.  I'll try kernel 2.6.20-rc5 
> and the which-cocktail-2.6.19.patch

I got confused between your report and Jan's.  Yours (not so sure about
Jan's) seems to be drive firmware bug which hald was successful to
undiscover.  Does hald clear CDO_USE_FFLAGS using ioctl
CDROM_CLEAR_OPTIONS?  The failed commands seem to be from cdrom
open_for_data().  Considering general quality of ATAPI devices, I
wouldn't be too surprised if some device fails after hours of repeated
poll sequence containing READ_TOC and ALLOW_MEDIUM_REMOVAL.

I think it's best to contact hal people about your issue.  If/when you
contact hal people, please cc me.

Thanks.

-- 
tejun
