From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 9 Feb 2011 15:47:53 -0500
Message-ID: <AANLkTik58FyjV=uVB8fv9hY_+ZDtJb1CP+7vV=PXnuF-@mail.gmail.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <4D52ECB6.4010408@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39405 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab1BIUsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 15:48:14 -0500
Received: by iwn9 with SMTP id 9so549581iwn.19
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2011 12:48:13 -0800 (PST)
In-Reply-To: <4D52ECB6.4010408@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, Feb 9, 2011 at 2:36 PM, Phillip Susi <psusi@cfl.rr.com> wrote:
> On 2/9/2011 10:37 AM, Alan Cox wrote:
>> Unlocking the HPA is actually necessary for sanity on a lot of syste=
ms
>
> Right.. ones that were partitioned using an older kernel with the bug=
gy
> behavior of unlocking it by default.
>
>> too, and there are really no standards. Remember the primary use of =
HPA
>> has actually been to hide most of the disk from buggy BIOSen so that=
 the
>> OS can then unlock it after the BIOS has stopped looking.
>
> The ATA spec describes the HPA saying:
>
> A reserved area for data storage outside the normal operating system
> file system is required for several
> specialized applications.
>
> This tells me that it is intended for the bios to reserve an area of =
the
> disk that the OS should NOT access. =A0So far the only use of it that=
 I
> have seen is by bioses to hide a small area, presumably to store
> platform specific information. =A0I see about a dozen reports on the
> ubuntu forums and bug tracker each year of people with HPA problems a=
nd
> it always seems to be a small area, as opposed to hiding everything
> above 128 MB or something.
>

Philip,

At some point (maybe 10 years ago), Dell used a HPA hidden partition
to hold a diagnostic partition of some sort.  I never used it, but I
remember coming across it several times.  I don't recall how big it
was.

I assume their thought was to have a recovery / diagnostic area that
normal users couldn't get to.  Now they just use a normal partition
for that.

I gather fakeraids now use a HPA protected to hold metadata for how
the raid is built, but I may have that wrong.

Greg
