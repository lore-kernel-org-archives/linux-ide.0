From: "kern.petr@seznam.cz" <kern.petr@seznam.cz>
Subject: Re: [SATA] libata-dev queue updated
Date: Tue, 29 Mar 2005 11:12:04 +0200
Message-ID: <42491BE4.8080609@seznam.cz>
References: <422FDDCE.3020806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.upce.cz ([195.113.124.33]:14506 "EHLO mail.upce.cz")
	by vger.kernel.org with ESMTP id S262268AbVC2JMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Mar 2005 04:12:15 -0500
Received: from mail.upce.cz (root@localhost)
	by mail.upce.cz (8.12.11/8.12.11) with SMTP id j2T9GYRI027587
	for <linux-ide@vger.kernel.org>; Tue, 29 Mar 2005 11:16:34 +0200
In-Reply-To: <422FDDCE.3020806@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik napsal(a):

> Merged recent upstream changes into libata-dev queue.  No new patches=
=20
> have found their way into libata-dev since last email.
>
> BK URL, Patch URL, and changelog attached.
>
> Note that the patch is diff'd against 2.6.11-bk6, which won't exist=20
> until four hours after this email is sent.
>
>     Jeff=20

It is hard to add support for VIA VT6420 PATA channel (SATA works fine)=
?=20
Does anybody working on it? I can help with beta testing this driver.=20
(The way through via82cxxx.c don't working.)

Is it possible add to To-do list to sata_via.c or add this support to=20
driver?

sata_via.c:
---cut here---
   To-do list:
   * VT6420 PATA support <=3D new line
   * VT6421 PATA support
 */
---cut here---

Petr Nov=E1k,
kern.petr@seznam.cz

