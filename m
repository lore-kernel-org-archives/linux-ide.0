From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 14:29:49 +0100
Message-ID: <200703171429.49646.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <45FAB270.8090909@tw.ibm.com> <45FABCE0.30907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:57584 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933826AbXCQNWc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 09:22:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so931208uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 06:22:31 -0700 (PDT)
In-Reply-To: <45FABCE0.30907@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org


Hi,

Any news about this test?  ide-cd driver is much more forgiving for
quirky hardware than libata+sr so please give it a try...

Bart

On Friday 16 March 2007, YUP wrote:
> Hi Albert,
> I'll do it today and send you results.
> 
> Yarema
> 
> > 
> > Could you please check whether the IDE driver work for it? (Please configure the
> > IDE pdc202xx_new and deconfig the libata pata_pdc2027x driver, recompile/reboot
> > the kernel and try read some cd using the IDE driver.) Thanks.
> > 
> > --
> > albert
