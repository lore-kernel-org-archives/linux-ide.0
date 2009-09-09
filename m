From: Grant Grundler <grundler@google.com>
Subject: Re: patch file for ahci.c
Date: Wed, 9 Sep 2009 10:01:58 -0700
Message-ID: <da824cf30909091001k64b7e790ob6a16644a4fbe72d@mail.gmail.com>
References: <4AA7D4AA.8050903@cybersource.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:51582 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZIIRCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2009 13:02:04 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id n89H24xT000495
	for <linux-ide@vger.kernel.org>; Wed, 9 Sep 2009 18:02:05 +0100
Received: from pxi6 (pxi6.prod.google.com [10.243.27.6])
	by wpaz1.hot.corp.google.com with ESMTP id n89H0EsD018666
	for <linux-ide@vger.kernel.org>; Wed, 9 Sep 2009 10:02:01 -0700
Received: by pxi6 with SMTP id 6so1070824pxi.21
        for <linux-ide@vger.kernel.org>; Wed, 09 Sep 2009 10:02:01 -0700 (PDT)
In-Reply-To: <4AA7D4AA.8050903@cybersource.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cyber Source <peter@cybersource.us>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Wed, Sep 9, 2009 at 9:15 AM, Cyber Source<peter@cybersource.us> wrot=
e:
> Hello Jeff,
> =C2=A0I was hoping you could help me with a patch that I need for the=
 ahci.c
> file. I am specifically referring to this, it appears to be the fix t=
hat I
> need.
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3Dbd17243a84632465f5403bc9eb8b4831bd67e582
> I am having a hard time implementing this change. I don't see where t=
his
> patch can be download and or what kernel it's been patched against.

I just checked. This patch is included in the 2.6.30 kernel:
    http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.30.6.tar.bz2

and the latest 2.6.31-rc9 tree.

> I see
> the diffs but again, don't know what the original file is from. I hav=
e
> downloaded the full 2.6.30 kernel and then applied the full kernel pa=
tch
> 2.6.31-rc9 in hopes that the patch/change would have been included, b=
ut it
> wasn't,

It definitely is.

> still had the soft-reset error.

Can you test the 2.6.31-rc9 *OR* 2.6.30.6 kernel and include the full
console output when reproducing the problem?
I expect you are having a different problem than this patch fixes.

> I then tried to download the
> b/drivers/ata/ahci.c file from the git.kernel link above and did a di=
ff
> against the one from the above kernel and patch and then it failed up=
on
> compile when it hit that file saying error on lines 1604 and 1605 exp=
ecting
> a ";'" before "if". Could you please help me with this. This is for a=
 laptop
> and I cannot change out the controller. Thanks for any help, Peter*

Please just grab either of the above source trees and post the "dmesg"
output after you've reproduced the problem.

hth,
grant
