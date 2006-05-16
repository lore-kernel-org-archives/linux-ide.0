From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Mon, 15 May 2006 22:27:21 -0400
Message-ID: <44693889.3080100@garzik.org>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org>	 <44690D90.2030208@gmail.com> <44691172.8040402@pobox.com>	 <446915AB.8000205@garzik.org>	 <89d273ba0605151712q7d6ab748q52ab321d45848a53@mail.gmail.com>	 <44691A3D.4040804@gmail.com> <89d273ba0605151924o5ce25807qe01ca3b9e2715b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55256 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751065AbWEPC1Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 May 2006 22:27:24 -0400
In-Reply-To: <89d273ba0605151924o5ce25807qe01ca3b9e2715b6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgVlVBUkFORA==?= <jerome.vuarand@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Jerome Vuarand <jerome.vuarand@ubisoft.com>, linux-ide@vger.kernel.org

J=C3=A9r=C3=B4me VUARAND wrote:
> Latest libata feature table mentions port multiplier support as "(pat=
ch=20
> available)". Is that "patch" refering to tejun patch ? If not is that=
 an=20
> evolution or another branch ? Where is it available ? It don't seem t=
o=20
> be inside 2.6.17-rc4-git2-libata1.patch, but I had only a quick look =
at=20
> the patch content.

That refers to Tejun's stuff, yes.


> Also Jeff mentionned information about port multiplier support in=20
> PDC205xx. Is there any documentation freely available somewhere ? I=20

No.


> looked on Promise site but found nothing. Should I contact Promise=20
> myself as a customer to obtain documentation or maybe look at Promise=
=20
> driver ?

I'll try to work up a patch with the necessary info.

	Jeff



