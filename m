From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: PATCH: Put the new API functions in the header files
Date: Sat, 6 Nov 2004 01:51:28 +0100
Message-ID: <200411060151.28742.bzolnier@elka.pw.edu.pl>
References: <1099672368.5630.47.camel@localhost.localdomain> <200411052302.50280.bzolnier@elka.pw.edu.pl> <1099697793.5567.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:42214 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261275AbUKFAr7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:47:59 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:42988 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S49955AbUKFAr6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Nov 2004 01:47:58 +0100
Received: from chello062179088136.chello.pl ([62.179.88.136]:65187 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S98895AbUKFAqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 6 Nov 2004 01:46:55 +0100
In-Reply-To: <1099697793.5567.85.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Saturday 06 November 2004 00:36, Alan Cox wrote:
> On Gwe, 2004-11-05 at 22:02, Bartlomiej Zolnierkiewicz wrote:
> > * there is no ordering of your patches
> > * they are splitted on file boundary not change boundary
> >   (ie. appling one patch leaves you with kernel which won't compile)
> 
> Well I could send you bigger pieces if you want but you objected to that
> last time.

all or nothing...

> > * they are whitespace damaged as usual
> 
> Well if you want to be a bigot about the old trailing space caused by
> editor auto indenting feel free 8)

sigh
