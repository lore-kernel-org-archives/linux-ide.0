From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] 2.6.34-rc3 v2 Disable R_OK (Early ACK) on SII 3726 PMP
Date: Fri, 23 Apr 2010 08:41:24 -0700
Message-ID: <w2qda824cf31004230841t4fabd0a4l11b54668b642b0c6@mail.gmail.com>
References: <g2ida824cf31004141843p41f7b21fz25927e3c6faeeed7@mail.gmail.com>
	 <l2jda824cf31004201352y5fcdfa40g2ecb5dbb1706bf88@mail.gmail.com>
	 <4BD102E5.7080006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:1411 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711Ab0DWPl1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 11:41:27 -0400
In-Reply-To: <4BD102E5.7080006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Apr 22, 2010 at 7:16 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 04/20/2010 04:52 PM, Grant Grundler wrote:
>>
>> ping? Can this patch please be applied?
>
> Apologies for the delay, I had been pulled away from libata this week=
 by
> baby stuff :/

No problem.

>
>
>> I was assuming this will show up here:
>>
>> =C2=A0http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/libata-dev=
=2Egit;a=3Dshortlog;h=3Drefs/heads/upstream-linus
>
> Nope, upstream-linus is always a temporary branch.
>
> #upstream-fixes is where 2.6.X-rcY changes are found (though typicall=
y these
> are pushed upstream ASAP)
>
> #upstream is the development branch for 2.6.(X+1), where this change =
can
> [now] be found.

Ok! Thanks for pulling in the patch (manually) and explaining the branc=
hes.

cheers,
grant

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Jeff
>
>
>
>
