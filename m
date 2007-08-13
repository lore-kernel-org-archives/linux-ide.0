From: "Paul Fryer" <paul.fryer@cfoa.org.uk>
Subject: RE: Libata
Date: Mon, 13 Aug 2007 08:57:33 +0100
Message-ID: <B5FC65CA9955A4448C31FB6BD9796E5D27B7A7@rho.cfoa.org.uk>
References: <B5FC65CA9955A4448C31FB6BD9796E5D0D55A8@rho.cfoa.org.uk> <46BC9732.9080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.mail.cfoa.org.uk ([195.80.32.21]:51632 "EHLO
	callisto.cfoa.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936783AbXHMILT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 04:11:19 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46BC9732.9080309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Thank you for getting back to me.

I am currently using Debian unstable kernel 2.22 (I think off hand), I
had the same problem with the Debian stable dist (2.18).

 

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, August 10, 2007 5:50 PM
To: Paul Fryer
Subject: Re: Libata

Hello,

Paul Fryer wrote:
> Hi,
>  
> I got your details from the latest kernel change log. I am after some 
> help with the libata sata_sil driver.
>  
> A few of us have the Thecus N2100 NAS which is an ARM based NAS with 
> the
> Sil3512 ECTU128 which seems to have serious performance problems at 
> some point after libata 1.11 or  sata_sil version 0.9.
>  
> See
> http://thecususergroup.proboards106.com/index.cgi?board=modifications&
> action=display&thread=1186052573 
> <http://thecususergroup.proboards106.com/index.cgi?board=modifications
> &action=display&thread=1186052573> for further information.
>  
> I am trying to find the contact information of the person developing 
> this driver / aspect of libata, is there anything you can do to help?

Please cc linux-ide@vger.kernel.org.  I don't really keep track of
libata or sata_sil versions.  Which kernel version are you using?  Does
switching IO scheduler make any difference?

--
tejun
