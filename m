From: Tejun Heo <htejun@gmail.com>
Subject: Re: support for Lindy 51130?
Date: Tue, 24 Jan 2006 22:14:24 +0900
Message-ID: <43D62830.9040906@gmail.com>
References: <m3r76yop4c.fsf@pixie.isrnet>	 <58cb370e0601230919m6f78fb28h35a4470b4e92b785@mail.gmail.com>	 <m3mzhmom7k.fsf@pixie.isrnet> <58cb370e0601231031j38dcec66sa3fcc67ea405045a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:22663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030471AbWAXNOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 08:14:30 -0500
Received: by zproxy.gmail.com with SMTP id 16so1274674nzp
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 05:14:29 -0800 (PST)
In-Reply-To: <58cb370e0601231031j38dcec66sa3fcc67ea405045a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Rodrigo Ventura <yoda@isr.ist.utl.pt>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 1/23/06, Rodrigo Ventura <yoda@isr.ist.utl.pt> wrote:
> 
>>Thanks. According to the second link you gave, it seems well
>>supported.
> 
> 
> Just to clarify things:
> 
> "Summary: Full TCQ/NCQ support, with full SATA control including
> hotplug and PM."
> 
> These are _hardware_ features, they are not currently supported in
> the vanilla kernels (however they are under active development).
> 
> "libata driver status: beta. "
>                                 ^^^^
> 
> That is why I said that others should know more details, I don't.
> 

Hi, Rodrigo.  Hi, Bartlomiej.

Unfortunately, no NCQ / hotplug / PM support yet.  Just plain simple 
one-command-per-time support only.  However, Silicon Image guys have 
determined to be more open with open source and I think/hope things will 
improve soon.

-- 
tejun
