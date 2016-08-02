From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0063/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 15:58:10 +0200
Message-ID: <A2C6171B-DD7F-4C31-B032-0F3DC6B3F161@holtmann.org>
References: <20160802103759.17958-1-baolex.ni@intel.com> <5391e340-1285-574d-1979-a19571341eb5@cogentembedded.com> <a4bf3836-1ffa-9f83-6e8f-998c99d5b507@cogentembedded.com> <20160802131937.GB11666@home.goodmis.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:54488 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966888AbcHBN61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2016 09:58:27 -0400
In-Reply-To: <20160802131937.GB11666@home.goodmis.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Baole Ni <baolex.ni@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, tj@kernel.org, lenb@kernel.org, X86 ML <x86@kernel.org>, hpa@zytor.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, travis@sgi.com

Hi Steven,

>>>> static int all;
>>>> -module_param(all, int, 0444);
>>>> +module_param(all, int, S_IRUSR | S_IRGRP | S_IROTH);
>>> 
>>>   There's S_IRUGO for this case, no?
> 
> Sure, and honestly, I understand what 0444 is better than seeing:
> 
>  S_IRUSR | S_IRGRP | SIROTH
> 
> Heck, 0444 is more understandable to me than S_IRUGO, because honestly, those
> macros are just as cryptic as 0444 is. Working with Unix/Linux systems since
> 1991, I understand the octo numbers very well. And I'm sure most other people
> do to. Any file that I'm Cc'd on here will get an automatic NAK from me.

you are not helping to reduce the 1285 patch bomb. Your automatic replies make it worse now ;)

Regards

Marcel

