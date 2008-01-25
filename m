From: rgheck <rgheck@bobjweil.com>
Subject: Re: SATA timeouts on two disks
Date: Thu, 24 Jan 2008 22:24:46 -0500
Message-ID: <4799567E.9010705@bobjweil.com>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>	 <18313.65287.290482.369023@harpo.it.uu.se>	 <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>	 <47944E2E.2070300@gmail.com> <3afbacad0801240931w4587d79cj6a84f36320573a9a@mail.gmail.com> <47991CF2.2000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:57239
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335AbYAYDYs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 22:24:48 -0500
In-Reply-To: <47991CF2.2000403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jim MacBaine <jmacbaine@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
>
> Jim MacBaine wrote:
>   
>> A co-worker, to whom I explained my problem, asked me whether I had
>> properly grounded my drives. In fact I had not: The drives resided in
>> a vibration-absorbing frame through which their exterior had no
>> electrical contact with the grounded case. Since I grounded the drives
>> two days ago, I got no new errors.  So maybe my problem is solved.
>>     
>
> Hmmm... Grounding..... Interesting.
>
>   
Can you say about more about this, Jim? This may also be my problem, or 
part of it, as my drives too are mounted in such a way as not to be in 
physical contact with the case. How did you go about grounding them? I 
suppose one test would be just to remove the washers....

That said, in my case, 2.6.24 seems to make a big difference, too. I 
accidentally booted into 2.6.23 today and, boom.

Richard

