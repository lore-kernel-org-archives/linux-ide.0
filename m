From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 17 Jan 2007 22:41:35 +0900
Message-ID: <45AE278F.5060004@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>	 <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com>	 <200701160958.33561.matthew4196@gmail.com>  <45AC933B.1000201@gmail.com>	 <1168947105.14636.11.camel@laundromat.jangutter.com>	 <45ACBA1F.6030007@gmail.com>	 <1168955594.14636.19.camel@laundromat.jangutter.com>	 <45ADB011.6000906@gmail.com> <1169040316.16103.18.camel@laundromat.jangutter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:63742 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158AbXAQNlr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jan 2007 08:41:47 -0500
Received: by wr-out-0506.google.com with SMTP id i22so549256wra
        for <linux-ide@vger.kernel.org>; Wed, 17 Jan 2007 05:41:46 -0800 (PST)
In-Reply-To: <1169040316.16103.18.camel@laundromat.jangutter.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Gutter <jangutter@gmail.com>
Cc: Matthew Stapleton <matthew4196@gmail.com>, linux-ide@vger.kernel.org

Jan Gutter wrote:
> If it's a firmware bug and implementing a workaround in hald helps it,
> would other userspace apps (k3b, cdrecord, etc.) also be affected?

Quite some number of ODDs don't seem to like the way hald polls them.  I
don't think other apps will be affected by this.  I dunno much about
hald and don't have enough time to chase it down myself but feel free to
cc me when reporting this to hald people.  I'll try to help as much as I
can.

Thanks.

-- 
tejun
