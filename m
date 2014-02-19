From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 17:24:43 +0000
Message-ID: <20140219172443.GJ10504@lee--X1>
References: <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
 <20140219140458.GA10134@htj.dyndns.org>
 <20140219150121.GG10504@lee--X1>
 <20140219150654.GH10134@htj.dyndns.org>
 <20140219152336.GH10504@lee--X1>
 <20140219153624.GI10134@htj.dyndns.org>
 <20140219163937.GI10504@lee--X1>
 <20140219170037.GK10134@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:64825 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbaBSRYu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 12:24:50 -0500
Received: by mail-wg0-f48.google.com with SMTP id a1so575858wgh.3
        for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2014 09:24:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140219170037.GK10134@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org, hdegoede@redhat.com

> > Again, that's not what I said. It's great that your subsystem is be=
ing
> > improved, but insisting that anyone who submits new code to rebase
> > on top of some development patches which only exist in mail form, a=
nd
> > refusing to take patches until they do so doesn't seem right to me.
>=20
> No policy is perfect and nothing can be decided solely on single
> policy.  There of course are trade-offs to make depending on the
> specific circumstances.  The problem, here, is that what has been
> going on is skewed towards one extreme and has potential to develop
> into a fairly large mess if left uncorrected.
>=20
> The message I've been sending out has been pretty clear.  There are
> multiple people duplicating about the same thing in their drivers.
> Fortunately, Hans' refactoring is pretty close to completion and
> should help simplifying most of them.  I'm not even asking you to do
> the bulk of work.  Just take a look at it and help / push if you can.
> It may be unfortunate that the circumstances haven't been completely
> aligned for your convenience but that's what needs to be done to keep
> things sustainable.

I understand this. Thanks for taking the time to explain properly.

=46WIW, I have now managed to rebase the driver on top of Hans' work an=
d
I am now in the process of converting it to the new way of working.

> This is a collaborative work and what I asked you isn't some
> insurmountable amount of extra work.  It's just beyond me that your
> response is "it's not fair".  No wonder the whole thing has been
> drifting towards mess.  That's not how this works.  Judging from your
> linaro address, I assume you have been involved with some upstream
> work, how can this possibly be your response?  Such attitude is
> actively harmful and has no place in upstream development.
>
> Again, of course, there can be trade-offs.  We sometimes do need to
> take termporal hits in maintainability for faster hardware enablement
> or whatnot; however, we can't do that without trust that the people
> dumping stuff which needs later cleanups would actually help.
> Unfortnately, I have close to zero trust given the recent development=
s
> and your "it's not fair, that's not my responsibility" attitude
> clearly confirms the conclusion.
>=20
> So, please take long look at how you perceive upstream development.
> It's a collaborative process.  Other people don't owe you by default.

Please refrain from adding quotation marks around things I didn't
actually say. I didn't say that this whole process was unfair. I was
pertaining to the fact that requesting that a driver is converted to a
non-existing API was wrong. As it currently stands the driver uses the
correct one. I also said that I'd happily convert it over when the
clean-ups are actually applied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
