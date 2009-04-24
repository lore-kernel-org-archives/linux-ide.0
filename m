From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] MAINTAINERS: update IDE entry
Date: Fri, 24 Apr 2009 18:41:42 +0200
Message-ID: <9ea470500904240941s53f41b2dq1c4e5bc85b6244d7@mail.gmail.com>
References: <200904232248.31735.bzolnier@gmail.com>
	 <49F17390.7070003@ru.mvista.com>
	 <200904241154.04860.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:53112 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbZDXQlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Apr 2009 12:41:44 -0400
In-Reply-To: <200904241154.04860.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2009 at 11:54 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> On Friday 24 April 2009 10:08:48 Sergei Shtylyov wrote:
>> Hello.
>>
>> Bartlomiej Zolnierkiewicz wrote:
>>
>> > By a popular demand quilt tree was replaced by a git one.
>> >
>> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> > ---
>> > =A0MAINTAINERS | =A0 =A02 +-
>> > =A01 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Index: b/MAINTAINERS
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -2743,7 +2743,7 @@ IDE SUBSYSTEM
>> > =A0P: Bartlomiej Zolnierkiewicz
>> > =A0M: bzolnier@gmail.com
>> > =A0L: linux-ide@vger.kernel.org
>> > -T: quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
>> > +T: git git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6=
=2Egit
>> >
>>
>> =A0 Does that mean that the patches that have been already accepeted=
 into
>> the git tree, can't be updated afterwards (i.e. I have a habit of
>> sometimes sending several takes of the same patch)?
>
> Yes, please just send incremental updates once the patch has been mer=
ged.

Or, you can interactively rebase the tree to the commit right before th=
e patch
to be replaced and then add the updated patch in place of the old one. =
There's a
very hands-on example in the manpage in section "INTERACTIVE MODE."

A problem with that might be that others who've pulled from your branch=
 will see
the rewritten history with a new SHA1 commit, but that would be still o=
k since
we'll be pulling from the linux-next branch and the for-linus branch is=
 the one
that is cast in stone once Linus pulls from you.

--=20
Regards/Gruss,
Boris
