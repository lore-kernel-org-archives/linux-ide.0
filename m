From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 19 May 2009 15:56:17 +0200
Message-ID: <200905191556.17793.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905191506.00245.bzolnier@gmail.com> <4A12B200.6010706@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:10702 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZESNwN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 09:52:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1847223rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 19 May 2009 06:52:14 -0700 (PDT)
In-Reply-To: <4A12B200.6010706@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Tuesday 19 May 2009 15:20:00 Jo=E3o Ramos wrote:
> Ok, I will apply the changes, test them and then resubmit the final p=
atch.
> By the way, I will submit the final patch through 'arm-linux' mailing=
=20
> list, if that is OK to you, since the full patch has platform-specifi=
c=20
> dependencies.
> I mean, as long as we iterate with the IDE part of it untill it is go=
od=20
> for submission from you, I can submit it in 'arm-linux' with your=20
> acknowledge, right?

It is good to post it also to linux-arm for additional review & better =
merge
coordination but the patch itself should go through IDE tree and linux-=
ide.

[ It is IDE host driver, has also IDE dependencies (ide_{set,get}_drive=
data()
  patch) and there are some other pending IDE changes that will require=
 minor
  updates to the patch. ]

Just ping me after platform-specific part is in and I'll push the drive=
r
to Linus (of course given that everybody is happy with the final versio=
n).

Thanks.
Bart
