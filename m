From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Linux kernel - Libata bad block error handling to user mode
	program
Date: Fri, 5 Mar 2010 01:01:07 -0500
Message-ID: <87f94c371003042201n72ce8578vc01331678b52da75@mail.gmail.com>
References: <f875e2fe1003032052p944f32ayfe9fe8cfbed056d4@mail.gmail.com>
	 <20100303224245.ae8d1f7a.akpm@linux-foundation.org>
	 <f875e2fe1003040458o3e13de97v3d839482939b687b@mail.gmail.com>
	 <201003041631.o24GVl51005720@alien.loup.net>
	 <f875e2fe1003041012m680ffc87i50099ed011526440@mail.gmail.com>
	 <201003050042.o250gsUC007947@alien.loup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60451 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0CEGBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Mar 2010 01:01:09 -0500
In-Reply-To: <201003050042.o250gsUC007947@alien.loup.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Hayward <hayward@loup.net>
Cc: foosaa@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jens.axboe@oracle.com, linux-mm@kvack.org

> Please let me know if you can prove data corruption. =A0I'm writing a
> sophisticated storage app and would like to know if kernel has such a
> defect. =A0My bet is it's just a drive that is slowly remapping.
>
> - Mike

=46or clarity, most ATA class disk drives are spec'ed to have one
non-recoverable error per 150TB or so of writes.  Disk drives do blind
writes.  (ie. They are not verified).  So we should all expect to have
the occasional silent data corruption on write.  The problem is
compounded with bad cables, controllers, RAM, etc.

The only way for the linux kernel even attempt to fix that is for it
to do a read verify on everything it writes.  For the vast majority of
uses that is just not acceptable for performance reasons.

OTOH, if data integrity is of the utmost for you, then you should
maintain a md5hash or similar for your critical files and verify them
any time you make a copy.  btrfs may offer a auto read-verify.  I
don't know much about btrfs.

Greg


--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
Preservation and Forensic processing of Exchange Repositories White Pap=
er -
<http://www.norcrossgroup.com/forms/whitepapers/tng_whitepaper_fpe.html=
>

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
