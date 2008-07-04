From: =?ISO-8859-15?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
Subject: Re: 2.6.25 to 2.6.26-rc8 regression  (related to ahci and acpi _GTF)
Date: Fri, 04 Jul 2008 18:08:08 +0200
Message-ID: <486E4AE8.1040108@crans.org>
References: <4869FB3C.4060509@crans.org> <200807011614.21491.rjw@sisk.pl> <486AEE29.2010506@gmail.com> <486B4490.7080904@crans.org> <486DA8DA.4070601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756035AbYGDQKQ@vger.kernel.org>
In-Reply-To: <486DA8DA.4070601@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo a =E9crit :
>
>
> Can you please test the attached patch?
>
>  =20
Hi,
tested again latest git: It works.

I am yet to test more fragile features such as suspend or hibernation,
but the obvious regression is gone.
(Yet I still doesn't understand why it used to work with DIPM)

Thanks.

--=20
Mathieu
