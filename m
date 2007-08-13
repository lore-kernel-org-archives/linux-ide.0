From: "Paul Fryer" <paul.fryer@cfoa.org.uk>
Subject: FW: Libata
Date: Mon, 13 Aug 2007 09:04:27 +0100
Message-ID: <B5FC65CA9955A4448C31FB6BD9796E5D27B7AB@rho.cfoa.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.mail.cfoa.org.uk ([195.80.32.21]:51906 "EHLO
	callisto.cfoa.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S940819AbXHMIEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 04:04:47 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

 Many thanks for getting back to me.

I am currently using Debian Unstable (kernel 2.6.22 I think off hand), I
had the same problems with Debian stable (2.6.18).

At the moment I do not have remote access but I will try changing the IO
scheduler and let you know.

Paul

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
