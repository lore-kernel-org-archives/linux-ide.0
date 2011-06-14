From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: Q67 and QM67 COMRESET solved by skip_host_reset=1
Date: Tue, 14 Jun 2011 11:13:28 -0400
Message-ID: <BANLkTimzRNk0WWiXrqxocr0ne1J-q=5JcA@mail.gmail.com>
References: <BANLkTinYpjMgqqmtEuPsZSTGb0ENGWKf8g@mail.gmail.com>
 <20110525093617.GE10146@htj.dyndns.org> <BANLkTinq4HB_yyW29PBeU+o_Q3EYmr9BEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60262 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1FNPNt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jun 2011 11:13:49 -0400
Received: by yia27 with SMTP id 27so1602310yia.19
        for <linux-ide@vger.kernel.org>; Tue, 14 Jun 2011 08:13:49 -0700 (PDT)
In-Reply-To: <BANLkTinq4HB_yyW29PBeU+o_Q3EYmr9BEw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, dan.j.williams@intel.com, seth.heasley@intel.com, Matthew Wilcox <matthew@wil.cx>

On Thu, May 26, 2011 at 9:12 AM, Andrew Lutomirski <luto@mit.edu> wrote=
:
> On Wed, May 25, 2011 at 5:36 AM, Tejun Heo <tj@kernel.org> wrote:
>> Cc'ing Intel people and Jeff. =A0Hi!
>>
>> Any ideas what's going on with the following? =A0In short, on sandy
>> bridge ahci + intel g2 ssd, doing HOST_RESET during initialization
>> makes the first reset timeout inducing 10 sec delay.
>
> On my desktop box, I have three SATA devices: a Sandforce-based SSD, =
a
> normal hard drive, and a CD. =A0Only the SSD has the problem, and
> libahci.skip_host_reset=3D1 fixes it on this box as well. =A0Here's t=
he
> relevant bit of the log:
>

> [ =A0 =A07.431907] ata1: link is slow to respond, please be patient (=
ready=3D0)
> [ =A0 12.121178] ata1: COMRESET failed (errno=3D-16)
> [ =A0 12.428010] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 30=
0)
> [ =A0 12.540828] ata1.00: ATA-9: OCZ-VERTEX3, 2.02, max UDMA/133

*sigh*

I assumed the fact that I had this problem on two similar motherboard
chipsets with two different generations of disks from two vendors
meant it was a chipset or driver bug.  I assumed wrong.

It was separate firmware bugs in the Sandforce and the Intel firmware.
 Both are fixed in newer versions.

Sorry for the noise,
Andy
