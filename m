From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Tue, 16 May 2006 09:18:05 +0900
Message-ID: <44691A3D.4040804@gmail.com>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org>	 <44690D90.2030208@gmail.com> <44691172.8040402@pobox.com>	 <446915AB.8000205@garzik.org> <89d273ba0605151712q7d6ab748q52ab321d45848a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:61560 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750872AbWEPASK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 20:18:10 -0400
Received: by wx-out-0102.google.com with SMTP id t16so646394wxc
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 17:18:09 -0700 (PDT)
In-Reply-To: <89d273ba0605151712q7d6ab748q52ab321d45848a53@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgVlVBUkFORA==?= <jerome.vuarand@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jerome Vuarand <jerome.vuarand@ubisoft.com>, linux-ide@vger.kernel.org

J=C3=A9r=C3=B4me VUARAND wrote:
> Thanks a lot for the quick answers. Sorry to have misread tejun's
> readme, I tought there was some abstraction layer between SATA
> protocol and SATAII extensions, so I didn't even suppose there could
> be a need for controller specific code to support port multiplier. I
> was clearly wrong.

Yeap, there is a layer, but it still needs low level support.

> So to be clear, there is not yet any support for my configuration
> (sata_promise+SiI3726) in any of your code branches ? If not which on=
e
> should I start from to try to add the support myself (I never
> programmed anything in the kernel, so it would just be a newbie try) =
?

No, not yet.  You can try but the biggest obstacle would be lack of=20
document.  If you can access the doc, it shouldn't be too difficult, I=20
guess.  You can analyze how sata_sil24 has been changed and update=20
sata_promise similarly.

--=20
tejun
