From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise TX4 + SiI 3726 : only one disk visible
Date: Tue, 16 May 2006 11:34:13 +0900
Message-ID: <44693A25.8060302@gmail.com>
References: <6EB652BF05BEE44FA2A29B23F3A71528045B3857@UBIMAIL1.ubisoft.org>	 <44690D90.2030208@gmail.com> <44691172.8040402@pobox.com>	 <446915AB.8000205@garzik.org>	 <89d273ba0605151712q7d6ab748q52ab321d45848a53@mail.gmail.com>	 <44691A3D.4040804@gmail.com> <89d273ba0605151924o5ce25807qe01ca3b9e2715b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:39217 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751070AbWEPCeT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 22:34:19 -0400
Received: by wr-out-0506.google.com with SMTP id i28so984451wra
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 19:34:19 -0700 (PDT)
In-Reply-To: <89d273ba0605151924o5ce25807qe01ca3b9e2715b6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgVlVBUkFORA==?= <jerome.vuarand@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Jerome Vuarand <jerome.vuarand@ubisoft.com>, linux-ide@vger.kernel.org

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

Yeap, it probably is referring to my patch.  The PM part is not include=
d=20
in any other trees yet.  PM is gonna take some time to get merged.=20
Also, 3726 needs a quirk patch to work with the current PMP support.=20
I'm still trying to sort out hotplug spinup delaying, so it might take=20
some time.

> If I should still use 2.6.16.16 <http://2.6.16.16> and tj patches, is=
=20
> porting 0121-sata_sil24-implement-PM-support.patch to sata_promise=20
> enough or are the other sata_sil24 patches also needed (0117 to 0122)=
 ?

Actually, it's a bigger than the said patch.  To do PM, sata_promise=20
must be converted to new EH and thus to use hotplug framework, then, th=
e=20
PM support.  Look at how many patches update sata_sil24 in my patch ser=
ies.

> Also Jeff mentionned information about port multiplier support in=20
> PDC205xx. Is there any documentation freely available somewhere ? I=20
> looked on Promise site but found nothing. Should I contact Promise=20
> myself as a customer to obtain documentation or maybe look at Promise=
=20
> driver ?

The doc is available under NDA.  I don't know about Promise's NDA polic=
y=20
but in my experience getting docs is often difficult.

--=20
tejun
