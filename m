From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
	and apply it to GGW-H10N
Date: Sun, 15 Nov 2009 12:22:43 -0600
Message-ID: <51f3faa70911151022g53be8a38g9252edece084e7b4@mail.gmail.com>
References: <4857313A.1000405@kernel.org>
	 <20080617094354.338e186b@lxorguk.ukuu.org.uk>
	 <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name>
	 <20080617110450.668f37e2@lxorguk.ukuu.org.uk>
	 <4857ADC3.3040106@kernel.org> <20080618114828.GB19903@lukeross.name>
	 <4858F894.6030409@garzik.org> <4AFDF5A8.1050005@gmail.com>
	 <4AFFB8ED.9050404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:38155 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbZKOSWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 13:22:38 -0500
Received: by iwn8 with SMTP id 8so3746141iwn.33
        for <linux-ide@vger.kernel.org>; Sun, 15 Nov 2009 10:22:43 -0800 (PST)
In-Reply-To: <4AFFB8ED.9050404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Luke Ross <luke@lukeross.name>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Sun, Nov 15, 2009 at 2:16 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> 11/14/2009 09:11 AM, Robert Hancock wrote:
>> Luke/Tejun, do you have some error output from those wodim or growis=
ofs
>> errors? It would be useful to know what commands those were that fai=
led
>> and whether they were also an unusual data size.
>
> I don't have anything. =A0For some reason, ahci works fine on the set=
ups
> here. =A0:-(
>
> I'm waiting for Dan's further report. =A0I still am not sure whether
> we're actually seeing a lot of ahci ATAPI failures or it's just that =
a
> lot of reports are on ahci because it's the most often used driver
> now. =A0I don't think anything fundamental is broken. =A0The reports =
are
> too infrequent for that to be true. =A0It might have something to do
> with the buffer padding / draining we do or how the controller and
> driver react.

=46rom the bug 10091 it looks like the failing command was a MODE SELEC=
T
with data transfer length of 66 bytes which is definitely odd..

My suspicion is that we're either padding out the data buffer and the
indicated PRD length to a longer length than the drive actually wants
to transfer, and the controller isn't happy with that, OR maybe
vice-versa (i.e. we don't pad out the length and it wants us to). It's
not clear if this and Jeff's issue are actually the same thing as the
response is fairly different (interface fatal error and SError
indications on the NV vs. a timeout on whatever chipset Jeff's using),
but that may just be a chipset difference.

If Jeff has a repeatable test case then that's likely the most
promising place to start poking at things..
