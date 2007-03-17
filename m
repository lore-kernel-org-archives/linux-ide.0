From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 16:00:55 +0100
Message-ID: <200703171600.55863.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703171429.49646.bzolnier@gmail.com> <45FBFD89.3080308@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:38218 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXCQOxh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 10:53:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so810282wxd
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 07:53:36 -0700 (PDT)
In-Reply-To: <45FBFD89.3080308@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: YUP <yupadmin@gmail.com>, linux-ide@vger.kernel.org


On Saturday 17 March 2007, Albert Lee wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> > 
> > Any news about this test?  ide-cd driver is much more forgiving for
> > quirky hardware than libata+sr so please give it a try...
> > 
> 
> Hi Bart,
> Yarema did the run test, but the AOpen drive was connected to the PIIX
> controller, which is driven by libata:

Which unfortunately says us nothing besides that pdc202xx_new works great
on this system... ;-)

Yarema, could you disable ata_piix, enable drivers/ide piix driver and retest?

Thanks,
Bart
