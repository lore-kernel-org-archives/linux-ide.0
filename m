From: Frans Pop <elendil@planet.nl>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Mon, 14 Apr 2008 17:29:18 +0200
Message-ID: <200804141729.20160.elendil@planet.nl>
References: <200804021524.27222.elendil@planet.nl> <20080414135214.GC7385@csclub.uwaterloo.ca> <20080414145607.3ae98a6f@core>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760178AbYDNP3g@vger.kernel.org>
In-Reply-To: <20080414145607.3ae98a6f@core>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Monday 14 April 2008, Alan Cox wrote:
> > > 2) it is only loaded if an ISA bus is present
>
> All PC class systems have an ISA bus, it may be on the main board and
> called LPC but it is there.

The actual test is if /sys/bus/isa exists, which it does not at least on my 
current PC class desktop (em64t).
My 4 year old laptop (i386) does have it though.
