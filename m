From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: libata PATA support - work items?
Date: Thu, 6 Jan 2005 16:51:27 +0800
Message-ID: <005701c4f3ce$37d56140$fb7f4109@tw.ibm.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com> <41DB2781.7000203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:500 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262781AbVAFJDN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Jan 2005 04:03:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "\"Bartlomiej Zolnierkiewicz\"" <bzolnier@gmail.com>, "\"IDE Linux\"" <linux-ide@vger.kernel.org>, "\"Doug Maxey\"" <dwm@maxeymade.com>, "\"Alan Cox\"" <alan@lxorguk.ukuu.org.uk>


For the 1st item,
- add PATA device errata/blacklist info
Is there any detail or draft design idea available?

For
- C/H/S addressing.
 I've an old Segate drive which support CHS-only at hand.
Maybe I can work on it first.

  BTW, what items are required for the PATA lowlevel driver like pdc2027x
to move out of the libata-dev tree to production tree? Do we have to finish all items?


Albert

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Albert Lee" <albertcc@tw.ibm.com>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>; "IDE Linux" <linux-ide@vger.kernel.org>; "Doug Maxey" <dwm@maxeymade.com>;
"Alan Cox" <alan@lxorguk.ukuu.org.uk>
Sent: Wednesday, January 05, 2005 7:32 AM
Subject: Re: libata PATA support - work items?


> Albert Lee wrote:
> > The following PATA work items were previously collected from the mailing list:
> >     1. ATAPI
> >        1.1 possibly avoid REPORT LUNS for ATAPI devices
> >        1.2 when check condition occurs, automatically request sense inside
> >             driver, and put that data into the sense buffer.
> >        1.3 make INQUIRY report SCSI version MMC-3 (or later...)
> >        1.4 support strange sector sizes
> >     2. C/H/S addressing; libata currently hardcoded to use LBA
> >     3. add PATA device errata/blacklist info
> >    (Any missing items?)
> >
> > Need your advice, thanks.
>
> Yes, this seems like an accurate list to me.
>
> I would probably prioritize #3 as the most important, followed by C/H/S
> support.
>
> Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


