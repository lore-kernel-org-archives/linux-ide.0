From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: [PATCH 0/4] partitions/ide: improve Host Protected Area handling
Date: Mon, 1 Jun 2009 08:59:29 -0400
Message-ID: <87f94c370906010559k4f2694cbv4023129c7b0cbc31@mail.gmail.com>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:36150 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbZFAM72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2009 08:59:28 -0400
In-Reply-To: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Frans Pop <elendil@planet.nl>

On Sun, May 31, 2009 at 10:39 AM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>
<snip>
>=A0Additionally HPA can also
> be disabled using the "nohpa" module parameter (i.e. "ide_core.nohpa=3D=
0.0"
> to disable HPA on /dev/hda).

If we use that parameter on older kernels, is it just ignored?  I'm
hoping I can just make that a default for my live CDs, etc..

Also, how is that handled in libata?  (ie. we typically want to force
exposing the HPA regardless of driver selection.)

Alan, given your emphatic ack, is libata likely to follow the same
model.  Any chance we could have a single boot param that handled both
drivers?  I mean instead of having 2 module params.

Thanks
Greg
--=20
Greg Freemyer
Head of EDD Tape Extraction and Processing team
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
=46irst 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.p=
df

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
