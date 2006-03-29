From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] libata: implement ata_dev_enabled and disabled()
Date: Wed, 29 Mar 2006 15:58:14 +0900
Message-ID: <20060329065814.GB11047@htj.dyndns.org>
References: <11431815313764-git-send-email-htejun@gmail.com> <44240A67.7030001@pobox.com> <1143215493.18986.11.camel@localhost.localdomain> <20060325011432.GE5288@htj.dyndns.org> <4424C12B.7070106@pobox.com> <20060325054008.GG5288@htj.dyndns.org> <20060325061215.GH5288@htj.dyndns.org> <1143330895.28134.14.camel@localhost.localdomain> <20060325235732.GA23222@htj.dyndns.org> <1143458257.4970.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:55451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751108AbWC2G6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Mar 2006 01:58:20 -0500
Received: by zproxy.gmail.com with SMTP id o37so120175nzf
        for <linux-ide@vger.kernel.org>; Tue, 28 Mar 2006 22:58:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1143458257.4970.18.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Mon, Mar 27, 2006 at 12:17:37PM +0100, Alan Cox wrote:
> On Sul, 2006-03-26 at 08:57 +0900, Tejun Heo wrote:
> > Can you elaborate how ata_dev_pair() is broken by this patch?
> > ata_dev_present() is simply renamed to ata_dev_enabled().
> > ata_dev_disabled() only differenciates the conditions where
> > ata_dev_present() used to think there was no device.  There should be
> > no behavior change to existing code. 
> 
> Some of the drivers want one sematic some want the other, and
> ata_dev_pair is now confusing. Needs a pair of better names and I'm not
> sure what they should be
> 

Hmm... how about using ata_dev_enable() || ata_dev_disable() for
ata_dev_pair() such that any existent device returned and make the
user responsible for ata_dev_enable() testing if it wants only enabled
device?

And I think the current enabled/disabled model matches SCSI device
state model sufficiently.  SCSI doesn't register devices which fail
INQUIRY and devices which fail after being attached get offlined.
Similar thing will happen for libata devices.  Stuff that fails
initial configuration won't be attached to SCSI while devices which
fail during operation will get disabled and then get SCSI-offlined.

Thanks.

-- 
tejun
