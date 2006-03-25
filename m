From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Sun, 26 Mar 2006 08:57:32 +0900
Message-ID: <20060325235732.GA23222@htj.dyndns.org>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com> <20060325054008.GG5288@htj.dyndns.org> <20060325061215.GH5288@htj.dyndns.org> <1143330895.28134.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:49795 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbWCYX5l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Mar 2006 18:57:41 -0500
Received: by wproxy.gmail.com with SMTP id 37so1216501wra
        for <linux-ide@vger.kernel.org>; Sat, 25 Mar 2006 15:57:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1143330895.28134.14.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sat, Mar 25, 2006 at 11:54:55PM +0000, Alan Cox wrote:
> On Sad, 2006-03-25 at 15:12 +0900, Tejun Heo wrote:
> > This patch renames ata_dev_present() to ata_dev_enabled() and adds
> > ata_dev_disabled().  This is to discern the state where a device is
> > present but disabled from not-present state.  This disctinction is
> > necessary when configuring transfer mode because device selection
> > timing must not be violated even if a device fails to configure.
> 
> This breaks the expected behaviour of ata_dev_pair(). I'd rather kept
> the existing behaviour of ata_dev_present for the moment until we can
> figure out what we need to do for "present but not enabled". That should
> also fit the scsi layer expectations so we can correctly "offline" a
> device.
> 

Hello, Alan.

Can you elaborate how ata_dev_pair() is broken by this patch?
ata_dev_present() is simply renamed to ata_dev_enabled().
ata_dev_disabled() only differenciates the conditions where
ata_dev_present() used to think there was no device.  There should be
no behavior change to existing code. 

Thanks.

-- 
tejun
