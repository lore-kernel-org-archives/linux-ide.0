From: "Kien Pham" <kienca@lycos.com>
Subject: Re: LibATA ATAPI-Found lockup spot.
Date: Tue, 18 Jan 2005 16:22:48 -0500
Message-ID: <20050118212248.9E1A186B0D@ws7-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:61136 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261436AbVARVX7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2005 16:23:59 -0500
Received: from wfilter.us4.outblaze.com (wfilter.us4.outblaze.com [205.158.62.180])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id 11682180022F
	for <linux-ide@vger.kernel.org>; Tue, 18 Jan 2005 21:23:53 +0000 (GMT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Jeff,

I tried that also. The driver indeed loads if I remove the REPORT LUNs. Unfortunately, it will lock when I try to access the drive so that's not a real solution I think.

~K.P.

----- Original Message -----
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Kien Pham" <kienca@lycos.com>
Subject: Re: LibATA ATAPI-Found lockup spot.
Date: 	Tue, 18 Jan 2005 14:43:20 -0500

> 
> Kien Pham wrote:
> > Hi Jeff,
> >
> > It blocks forever on line 2450 of libata-core.c. This is on 
> > vanilla 2.6.10 kernel source. Relevent snippet follows so you 
> > don't have to dig. Basically, the middle SCSI layer successfully 
> > sends 3 INQUIRY commands. Then it sends a REPORT LUNs command 
> > that fails with a status 0x50. The error register reads 0x60 at 
> > this point. Then the ATAPI layer sends a REQUEST SENSE which 
> > never completes because an interrupt never occurs and we're stuck 
> > at line 2450 waiting for completion. O.K. I know the how it 
> > happens, any ideas on the why? Or am I on my own? :)
> 
> 
> I think Bart mentioned something about problems with REPORT LUNS... 
> I bet things would work if we didn't send that command...
> 
> 	Jeff
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
_______________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

