From: "cjacker huang" <cjacker@gmail.com>
Subject: Re: [PATCH v1] ata_piix: attempt to fix
Date: Fri, 14 Jul 2006 11:54:00 +0800
Message-ID: <bde732200607132054g3f0f6c25ke1f0c1756f768611@mail.gmail.com>
References: <20060711160202.GA2503@havoc.gtf.org>
	 <20060713235038.GA3613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:22339 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161240AbWGNDyB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Jul 2006 23:54:01 -0400
Received: by py-out-1112.google.com with SMTP id x31so511410pye
        for <linux-ide@vger.kernel.org>; Thu, 13 Jul 2006 20:54:01 -0700 (PDT)
In-Reply-To: <20060713235038.GA3613@kroah.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, albertcc@tw.ibm.com

I had test the ata-piix fix patch for kernel-2.6.17 and kernel-2.6.18rc1-mm1.

my sata controller is 0x8086 0x8020, that is to say, it is ICH8.

It works for me. long boot delay disappears.



2006/7/14, Greg KH <greg@kroah.com>:
> On Tue, Jul 11, 2006 at 12:02:02PM -0400, Jeff Garzik wrote:
> > This patch attempts to address problems on ata_piix that people have
> > been reporting:  long boot delay, ghost devices, and ICH8 brokenness.
> >
> > Testing feedback is requested as soon as possible, so that we can
> > potentially stick this into 2.6.18-rc2.
> >
> > I'm booting up several boxes locally here, mainly ICH5 and ICH8, as well.
>
> Sorry for the delay, but no, this does not solve the timeout at boot for
> me.  Do you need the boot log messages?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
