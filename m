From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] libata: add @disable_on_err argument to ata_set_mode()
Date: Sat, 25 Mar 2006 14:40:08 +0900
Message-ID: <20060325054008.GG5288@htj.dyndns.org>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:54703 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751049AbWCYFkP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Mar 2006 00:40:15 -0500
Received: by wproxy.gmail.com with SMTP id i5so1103632wra
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 21:40:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4424C12B.7070106@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Fri, Mar 24, 2006 at 11:03:55PM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >ata_set_mode() used to disable whole port on failure.  This patch adds
> >@disable_on_err which makes ata_set_mode() disable failing devices
> >when non-zero, and simply return when zero.  Due to the port-wide
> >characteristic of ATA xfer mode configuration, ata_mode_set() is the
> >final place to determine device offlining; thus, the @disable_on_err
> >mechanism to tell it which action to take on failure.
> >
> >With this patch, only failing devices are disabled not the whole port.
> >Transfer mode configuration must consider all devices on the port
> >regardless of failure status; otherwise, device selection timing can
> >be violoated resulting in malfunction.  This patch makes
> >ata_dev_xfermask() consider disabled but present devices such that
> >device timing selection timing is honored.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK, but dropped due to dropping patch #1
> 

I'll remove ata_dev_present() for the time being.  It's used in only
one place anyway.  We can do with ata_dev_enabled() ||
ata_dev_disabled() for the time being and resurrect ata_dev_present()
after one or two releases, I think.

> 
> >As said in the above comment, this patch makes sure that present but
> >disabled devices are taken into account when determining transfer
> >mode.  If IDENTIFY data is present, it is used; otherwise, PIO0 is
> >forced.  I think this should be enough.
> 
> Several follow-up comments:
> 
> * Ideally, I think libata should re-read the identify data from the 
> device.  This (a) makes sure PIO is working, and (b) tells us for 
> certain what mode the device is.  That's fine for a follow-up patch 
> though, since few will exercise this code anyway.

Agreed, we can revalidate the device and then try to configure the
next lower transfer mode until we succeed.  For the time being, I just
wanna move forward with the current code so that EH changes can be
submitted sooner than later.

> * skipping ->post_set_mode() in this error case being discussing is 
> probably unwise.

We don't skip ->post_set_mode() unless @disable_on_err is zero, in
which case the upper layer is responsible for handling the error
condition.  Upper layer will usually reset and reconfigure the whole
thing again, so omitting ->post_set_mode() should be fine there (we
need to force PIO0 before IDENTIFY'ing though).

> BTW, got any PATA hardware lying about?  Since you're wandering into 
> xfer mode territory, it would better to test PATA than SATA, as xfer 
> mode matters more in the PATA realm.  Intel PATA should be fairly easy 
> to find, covered by ata_piix, and all the docs are on developer.intel.com.

Yeap, my test machine's ICH7 can do ata_piix and my notebook has
ICH6M.

-- 
tejun
