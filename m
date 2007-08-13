From: babl <babl1986@gmail.com>
Subject: Re: FW: Libata
Date: Mon, 13 Aug 2007 12:17:10 +0400
Message-ID: <200708131217.10791.babl1986@gmail.com>
References: <B5FC65CA9955A4448C31FB6BD9796E5D27B7AB@rho.cfoa.org.uk>
Reply-To: babl1986@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.225]:30466 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S943268AbXHMIRS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 04:17:18 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1121064hue
        for <linux-ide@vger.kernel.org>; Mon, 13 Aug 2007 01:17:16 -0700 (PDT)
In-Reply-To: <B5FC65CA9955A4448C31FB6BD9796E5D27B7AB@rho.cfoa.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Fryer <paul.fryer@cfoa.org.uk>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

Hmm.... I'm using Debian kernel too and build 2.6.23-rc2 with debian co=
nfig=20
for 2.6.22 with some little changes! May be Debian config?

=F7 =D3=CF=CF=C2=DD=C5=CE=C9=C9 =CF=D4 13 =C1=D7=C7=D5=D3=D4=C1 2007 Pa=
ul Fryer =CE=C1=D0=C9=D3=C1=CC(a):
>  Many thanks for getting back to me.
>
> I am currently using Debian Unstable (kernel 2.6.22 I think off hand)=
, I
> had the same problems with Debian stable (2.6.18).
>
> At the moment I do not have remote access but I will try changing the=
 IO
> scheduler and let you know.
>
> Paul
>
> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com]
> Sent: Friday, August 10, 2007 5:50 PM
> To: Paul Fryer
> Subject: Re: Libata
>
> Hello,
>
> Paul Fryer wrote:
> > Hi,
> >
> > I got your details from the latest kernel change log. I am after so=
me
> > help with the libata sata_sil driver.
> >
> > A few of us have the Thecus N2100 NAS which is an ARM based NAS wit=
h
> > the
> > Sil3512 ECTU128 which seems to have serious performance problems at
> > some point after libata 1.11 or  sata_sil version 0.9.
> >
> > See
> > http://thecususergroup.proboards106.com/index.cgi?board=3Dmodificat=
ions&
> > action=3Ddisplay&thread=3D1186052573
> > <http://thecususergroup.proboards106.com/index.cgi?board=3Dmodifica=
tions
> > &action=3Ddisplay&thread=3D1186052573> for further information.
> >
> > I am trying to find the contact information of the person developin=
g
> > this driver / aspect of libata, is there anything you can do to hel=
p?
>
> Please cc linux-ide@vger.kernel.org.  I don't really keep track of
> libata or sata_sil versions.  Which kernel version are you using?  Do=
es
> switching IO scheduler make any difference?
>
> --
> tejun
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


