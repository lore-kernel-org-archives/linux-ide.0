From: Levente Kurusa <levex@linux.com>
Subject: Re: Unexpected _GTF length (8)
Date: Sun, 22 Sep 2013 08:25:11 +0200
Message-ID: <523E8D47.8040909@linux.com>
References: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
Reply-To: levex@linux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:41322 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab3IVGZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Sep 2013 02:25:15 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so1050662eek.34
        for <linux-ide@vger.kernel.org>; Sat, 21 Sep 2013 23:25:13 -0700 (PDT)
In-Reply-To: <CAMeQTsby_CoGq1xAKUEVg_yWyqSSMjfSf6gWWzFRR+-znpPVbw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-ide@vger.kernel.org

2013-09-22 03:56 keltez=E9ssel, Patrik Jakobsson =EDrta:
> Hi,
>
> I've just got myself a MacBook Air 2013 and started looking at the dm=
esg output
> for 3.12-rc1 where I found this:
>
> ata1.00: unexpected _GTF length (8)
>
> The condition in libata-acpi.c that triggers this is:
>
> if (out_obj->buffer.length % REGS_PER_GTF)
>
> Where REGS_PER_GTF is defined as 7 which is correct according to ACPI=
 specs.
> Since I'm getting a length of 8 I started digging in the ACPI code an=
d found
> that the length is rounded up to acpi_size (u32 or u64 depending on a=
rch). I
> cannot find any commits that recently touched this though I didn't re=
ally dig
> through it all.
>
> I've disassembled the SSDT for the "SataAhci" and everything looks ok=
=2E That
> code returns a 56 bit buffer. I also tried calling the _GTF method ma=
nually
> which returned the following (padded to 8 bytes by the ACPI code ofc)=
=2E
>
> {0x10, 0x03, 0x00, 0x00, 0x00, 0xa0, 0xef, 0x00}
>
> Doing a quick google search gives me a few of these _GTF length error=
s dating
> back to at least 2011. What's going on here? Is this a known error?
>
> Thanks
> Patrik Jakobsson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Hi,

Can you please post the outputs of dmesg and smartctl?
Maybe hdparm -I as well.
These information would greatly help us, in addition to those you
have supplied.

--
Regards,
Levente Kurusa
