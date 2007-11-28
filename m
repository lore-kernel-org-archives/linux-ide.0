From: Jeff Garzik <jeff@garzik.org>
Subject: Re: laptop reboots right after hibernation
Date: Wed, 28 Nov 2007 08:47:23 -0500
Message-ID: <474D716B.30608@garzik.org>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz> <4740692E.7010801@dbservice.com> <47409DA3.7070909@dbservice.com> <1195551141.2792.3.camel@localhost.localdomain> <474CBFB6.4020105@gmail.com> <1196253340.2884.1.camel@localhost.localdomain> <474D6EA7.2000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760807AbXK1Nrn@vger.kernel.org>
In-Reply-To: <474D6EA7.2000506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kjartan Maraas <kmaraas@broadpark.no>, Tomas Carnecky <tom@dbservice.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> 2. Filter out certain commands from ACPI.  I definitely don't like BIOS
> locking up random features via _GTF commands.  It makes debugging difficult.

I agree.

Take a look at what Alan has been doing for the "trusted" command stuff.

At the very least we should definitely blare a warning into the log if 
the BIOS is taking away key features from the user.

	Jeff
