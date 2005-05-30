From: Erik Slagter <erik@slagter.name>
Subject: Re: Playing with SATA NCQ
Date: Mon, 30 May 2005 20:22:44 +0200
Message-ID: <1117477364.3108.2.camel@localhost.localdomain>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>
	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261684AbVE3SYx@vger.kernel.org>
In-Reply-To: <429B56CA.5080803@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 2005-05-30 at 14:09 -0400, Mark Lord wrote:
> >>>ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
> >>>no plans to implement support for AHCI transition in the BIOS. &^$##($%
> >>>DELL.
> > I really have a (native) SATA drive, I checked the ID from dmesg.
> 
> Seems rather unlikely that they would plumb the same notebook both ways.
> The 100GB drive in the i9300 here is a "FUJITSU MHV2100AH" (PATA).

This one is a MHT2080A and it looks indeed it's not SATA, so no NCQ.
Still I'd like to run in ACHI mode ;-)

I must have been fooled by the FC3 setup disk that handed it libata,  I
didn't know libata also handles pata, then.
