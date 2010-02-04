From: Tejun Heo <tj@kernel.org>
Subject: Re: port multiplier problem
Date: Thu, 04 Feb 2010 12:24:29 +0900
Message-ID: <4B6A3DED.6060708@kernel.org>
References: <4B5885F7.2020007@gmail.com> <4B679EA9.6030203@kernel.org>	 <4B6833DD.1020001@gmail.com> <4B683581.7070708@kernel.org>	 <4B683DEF.3000302@gmail.com>	 <da824cf31002020844r12cada26x57f96b0aa24b59c6@mail.gmail.com>	 <4B686B2B.2080406@gmail.com>	 <da824cf31002021104v72efcd05ne639091042d5999d@mail.gmail.com>	 <4B687B7C.2070406@gmail.com> <da824cf31002031837t1cf2357bsbb53a3b4ea5e671f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40373 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab0BDDRv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Feb 2010 22:17:51 -0500
In-Reply-To: <da824cf31002031837t1cf2357bsbb53a3b4ea5e671f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Chandra Shekhar Sah <edu4madh@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 02/04/2010 11:37 AM, Grant Grundler wrote:
> I had two questions on that thread that never got answered:
>    http://markmail.org/message/snpekoj4qexrslk5
> 
> | How can we find out if anyone has the SEMB properly wired up?
> | Would it be hard to make libata aware of "SEMB port not responding" case?
> | ie if the SEMB port times out or has no link, reduce the port count of
> | the sil3726 PMP by one.
> |
> | Maybe add a "enable_sil24_semb" flag to libata?
> | (avoid checking unless someone asks for it). I hate magic flags but also
> | don't want to subject most people to the timeout delay.
> 
> I (or Gwendal) can post a patch (and lightly test) for any of the above.
> Just need to get some guidance so we don't waste our time.

It's not really sil24 tho.  But anyways, I think we can just disable
them altogether.  It's not like they have ever worked.  Just limiting
both 3726 and 4726 to 5 ports should be fine.  That said, I'm not
quite sure this is relevant to the reported problem but it's worth a
shot.

Thanks.

-- 
tejun
