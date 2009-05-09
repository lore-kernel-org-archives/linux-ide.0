From: s ticket <smticket@gmail.com>
Subject: Re: How to assess PMP register
Date: Sat, 9 May 2009 14:23:15 +0800
Message-ID: <fa69d4570905082323q3cf36a06xa28d035e2dafbafa@mail.gmail.com>
References: <fa69d4570904291849p638b849fm856be97c81340624@mail.gmail.com>
	 <49FA2763.9040409@rtr.ca>
	 <fa69d4570905032204q726728a1qd4be4800b916439a@mail.gmail.com>
	 <49FF7C2A.6030000@rtr.ca>
	 <e7510f760905060003n60535405oaf8e431963b41ddf@mail.gmail.com>
	 <fa69d4570905082212y74242302o5bd8059ce358a4be@mail.gmail.com>
	 <4A05121C.1040104@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:16392 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbZEIGXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 02:23:15 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1098368yxj.1
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 23:23:15 -0700 (PDT)
In-Reply-To: <4A05121C.1040104@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

>
> The PMP access functions can only be called from EH context and that'=
s
> one of the reasons they aren't exported? =A0What are you trying to
> achieve?

To driver some gpios on the PMP ;-).
I tried to directly access the PMP and send ATA command from user space=
,
but all failed.
It seems there are no suitable way so far?


                        jbin
