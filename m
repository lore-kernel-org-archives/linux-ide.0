From: Kovid Goyal <kovid@theory.caltech.edu>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 19 Dec 2006 20:56:16 -0800
Message-ID: <200612192056.16910.kovid@theory.caltech.edu>
References: <200612111003.39928.kovid@theory.caltech.edu> <200612191800.18624.kovid@theory.caltech.edu> <45889C67.900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from theory.caltech.edu ([131.215.116.2]:41071 "EHLO
	theory.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871AbWLTE4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 23:56:20 -0500
In-Reply-To: <45889C67.900@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Unfortunately I only have ssh access to the box for the next two weeks, but 
after I return I will send the netconsole logs. Thanks for looking into this.

Kovid.

On Tuesday 19 December 2006 18:13, you wrote:
> Kovid Goyal wrote:
> > Yes going back to 2.6.17 does fix it. Also windows and various LiveCDs
> > boot without problems.
> >
> > Here is the output
> > smartctl -d ata -a /dev/sda
> > smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce
> > Allen Home page is http://smartmontools.sourceforge.net/
>
> Thanks, I couldn't find anything indicating hardware problem from the
> smartctl output.  Ergh... The 0xff timing out is fixed in the devel
> tree.  The problem is why sda sometimes doesn't get detected.  Can you
> post the result of failing dmesg?  If you've got a second computer,
> doing netconsole (Documentation/networking/netconsole.txt) is the best
> way.  If not, just take a picture of the screen while ata1 detection is
> in progress.

-- 
_____________________________________

Kovid Goyal  MC 452-48
California Institute of Technology
1200 E California Blvd
Pasadena, CA 91125

home  : +01 626 390 8699
office: +01 626 395 6595 (449 Lauritsen)
email : kovid@theory.caltech.edu
web   : http://www.kovidgoyal.net
_____________________________________
