From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Thu, 2 Sep 2010 12:56:00 -0700
Message-ID: <AANLkTi=_fmtNjj=ZeSyuMtQg+YBJ3=gHAkeurJhDZmmh@mail.gmail.com>
References: <1283027290.2721.37.camel@myfedorahat>
	<4C7BAA42.2050809@kernel.org>
	<AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>
	<AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>
	<AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com>
	<AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com>
	<AANLkTikqxmzQozCOo+7XDSWE4tTniSnYbomEgqA4aB-2@mail.gmail.com>
	<4C7F77C4.6040404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36370 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0IBT4C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2010 15:56:02 -0400
Received: by qwh6 with SMTP id 6so896534qwh.19
        for <linux-ide@vger.kernel.org>; Thu, 02 Sep 2010 12:56:01 -0700 (PDT)
In-Reply-To: <4C7F77C4.6040404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Applied patch to 2.6.35.4. Patched cleanly and kernel compile was smoot=
h.

Suspend works beautifully now. Not only does the system resume
properly but earlier suspend would take minutes, now it goes to
suspend within seconds (less than 10).

I will re-build my laptop with dmcrypt + ext4, apply this patch and
use the system for a while to ensure all play together nicely.

Thanks Tejun!! Really appreciate the quick turnaround on this issue. I
saved debugging info from the successful resume where I have debugging
turned on for various modules - acpi, pci etc. Let me know if you need
me to send it across.


- Siddhartha


On Thu, Sep 2, 2010 at 3:09 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Can you please the patch in the following message?
>
> =A0http://article.gmane.org/gmane.linux.ide/47387/raw
>
> Thanks.
>
> --
> tejun
>



--=20
- Siddhartha
=A0 WV6U
