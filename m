From: Jean Delvare <jdelvare@suse.de>
Subject: Re: 2.6.{30,31} x86_64 ahci problem - irq 23: nobody cared
Date: Wed, 14 Oct 2009 13:45:29 +0200
Message-ID: <200910141345.30177.jdelvare@suse.de>
References: <4ABBB8C2.2080901@sbg.ac.at> <4AD422F2.4080308@sbg.ac.at> <4AD473F9.7090606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37057 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbZJNLqI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Oct 2009 07:46:08 -0400
In-Reply-To: <4AD473F9.7090606@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Huemer <alexander.huemer@sbg.ac.at>, Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Le mardi 13 octobre 2009, Tejun Heo a =E9crit=A0:
> Alexander Huemer wrote:
> > i compiled gcc in a loop over night, 14 times. no error.
> > it really seams i2c_i801 was the cause...
> > unfortunately i still don't know how i can extract the part of the =
gcc
> > compilation process that causes the error on an affected kernel.
> > that would enable me to create a simple test program.
>=20
> Given that i2c is used for temperature monitoring, I think it is not
> triggered by any single step of the compiling but rather by the
> accumulated heat load during compilation.  Let's wait for Jean to
> chime in.  :-)

Sorry, I'm somewhat busy at the moment, I'll give it a look as soon
as I get a moment.

--=20
Jean Delvare
Suse L3
