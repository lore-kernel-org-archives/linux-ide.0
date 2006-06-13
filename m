From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Tue, 13 Jun 2006 12:00:50 +0200 (CEST)
Message-ID: <20060613100050.31066.qmail@web26913.mail.ukl.yahoo.com>
References: <1149873734.22124.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:30398 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750864AbWFMKAw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 06:00:52 -0400
In-Reply-To: <1149873734.22124.40.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> If I hack the OS I write a new boot block which locks the disk then r=
eboot into it.

 Another solution to be safe, because you need a full power cycle of th=
e HD,
 is to keep the HDs on a separate non interruptible power supply (not s=
toppable
 by APM/ACPI).

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection p=
ossible contre les messages non sollicit=E9s=20
http://mail.yahoo.fr Yahoo! Mail=20
